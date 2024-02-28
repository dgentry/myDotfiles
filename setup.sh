#!/bin/bash

# So this can run by double-clicking this script, identify its path.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  # if $SOURCE was a relative symlink, we need to resolve it relative
  # to the path where the symlink file was located
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

my_long_name=$0  # Something like "./setup.sh"
annoying_prefix="./"
myname=${my_long_name#$annoying_prefix}  # Now just "setup.sh"

# Colors etc.
[[ -f msg.sh ]] && source msg.sh
[[ -f scripts/msg.sh ]] && source scripts/msg.sh

# Make a .bash_completion directory
BASHCOMP=~/.bash_completion.d
if ! [[ -d "$BASHCOMP" ]]; then
    # If this ever turns out to be a symlink (which it could), I'll add the -L check.
    mkdir "$BASHCOMP"
fi

# Symlink .git_completion if necessary
GITCOMP=git-completion.bash
BCSCRIPT=$BASHCOMP/$GITCOMP
if ! [ -L $BCSCRIPT ]; then
    msg "Setting up git completion for bash"
    ln -s $PWD/$GITCOMP $BCSCRIPT
fi

# Turn off pager behavior for git
git config --global pager.branch false

packages_i_want="figlet gpg nmap grc dc"
install_me=""

for p in $packages_i_want; do
    if ! command -v $p &> /dev/null ; then
        install_me="$install_me $p"
    fi
done

if ! command -v ag &> /dev/null ; then
    install_me="$install_me silversearcher-ag"
fi

# This might not be necessary, since at least emacs28 installs etags.
if ! command -v ctags &> /dev/null ; then
    msg "No ctags command"
    install_me="$install_me universal-ctags"
else
    if [[ ! $(ctags --version | grep -s -i universal) ]]; then
        msg "There's a ctags, but it's non-universal."
        install_me="$install_me universal-ctags"
    fi
fi


# What am I?
arch_name="$(uname -m)"
name="$(uname)"
if [ $name == "Darwin" ]; then
    msgn "I'm a Mac "
    if [ "${arch_name}" = "x86_64" ]; then
        if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
            echo "running on Rosetta 2.  "
        else
            echo "running on native Intel.  "
        fi
    elif [ "${arch_name}" = "arm64" ]; then
        echo "running on ARM.  "
    else
	echo " "
        msg "Running an unknown architecture, ${arch_name}.  Bye."
        exit 1
    fi

    if [ $(sw_vers -productVersion) == "10.13.6" ]; then
	ver="HS"
	msg "My version is High Sierra, trimming Brewfile."
	grep -v "High Sierra"  <Brewfile.in >Brewfile
	# Would like gcc, but it fails.  Maybe an older version?
	# brew install gcc
    else
	msg "Using Brewfile"
	cp Brewfile.in Brewfile
    fi

    # Install brew if necessary
    if ! [[ -x $(which brew) ]]; then
        msg "Installing brew"
        source install-brew.sh
    fi

    function brew_needs_install() {
        # First arg is --cask or ""
        # If the package is missing, return true
        if brew ls $1 --versions $2 > /dev/null 2>&1; then
            return 1
        fi
        return 0
    }

    # Apparently necessary, just once, due to some homebrew load on github.
    function fetch_deep() {
        if $(git rev-parse --is-shallow-repository $1); then
            msg "Unshallowing $1"
            git -C $1 fetch --unshallow
        fi
    }
    # fetch_deep /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core
    # fetch_deep /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask

    msg "Installing/updating brewed packages"
    brew bundle

    # Stops Mac FS junk from ending up on USB sticks.  Or maybe mdworkers?
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    current_shell="$(dscl . -read /Users/root UserShell)"
    current_shell=${current_shell#"UserShell: "}
    if [[ $current_shell == "/bin/sh" ]]; then
        msg "Root shell is $current_shell, setting to bash"
        sudo dscl . -change /Users/root UserShell /bin/sh /bin/bash
        msg "Done."
    else
        msg "Root shell is already $current_shell"
    fi
else
    msg "I'm some kind of non-Mac Unix."

    if [[ ! -x nala ]]; then
        sudo apt install nala
        sudo nala update
    fi
    if [[ -x nala ]]; then
        aptcmd=nala
    else
        aptcmd=apt
    fi
    msg "Using $aptcmd as package manager"

    export LANGUAGE=en_US.utf8
    export LANG=en_US.utf8
    export LC_ALL=en_US.utf8
    LOCALES="$(localedef --list-archive /usr/lib/locale/locale-archive)"
    msg "Existing LOCALES are:\n$LOCALES"
    # Is en_US.utf8 in LOCALES?
    if [[ "$LOCALES" == *"$LC_ALL"* ]]; then
        msg "We already have locale $LC_ALL"
    else
        msg "A bunch of packages complain about locale problems on Ubuntu and Debian, so:"
	sudo apt-get install -y locales
	sudo bash -c 'echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen'
        sudo locale-gen
    fi

    # apt_upd=~/.apt-updated
    # if [[ -f $apt_upd ]] && [[ $(find ${apt_upd} -mtime -1) ]]; then
    #     last_done_s=$(date -d "$(cat $apt_upd)" +%s)
    #     now=$(date +%s)
    #     ago_m=$(( ($now - $last_done_s) / 60 ))
    #     msg "Apt-update was done $ago_m minutes ago, skipping."
    # else
    #     msg "Updating package lists"
    #     sudo apt-get update
    #     if [[ $? ]]; then
    #         msg "Marking apt update done now."
    #         date > ~/.apt-updated
    #     fi
    # fi

    if ! command -v /usr/bin/python &> /dev/null ; then
        msg "installing python-is-python3"
        sudo $aptcmd install -y python-is-python3
    fi
    pmv=$(python -c 'print(__import__("sys").version_info.major)')
    if [[ $pmv != 3 ]]; then
        msg "Python version is $pmv.  Nothing else is likely to go well here."
    fi

    msg "Installing python 3 pip and venv"
    # Need to install python-is-python3 lest later apt installs of
    # python stuff revert us to python2.
    sudo $aptcmd install -y python-is-python3
    # pip wants launchpadlib, which is in testresources.
    sudo $aptcmd install python3-testresources
    sudo $aptcmd install -y python3-pip python3-venv

    # Do we already have our "3" venv?
    if [[ ! -x ~/.venvs/3/bin/python3 ]]; then
	msg "No existing \"3\" venv; creating one."
	mkdir -p ~/.venvs/3
	python3 -m venv ~/.venvs/3
	~/.venvs/3/bin/pip install lolcat
    fi

    if ! command -v apt-file &> /dev/null ; then
        msg "Installing apt-file"
        sudo $aptcmd install -y apt-file

        msg "Spinning off apt-file update, output to apt-file.log."
        sudo apt-file update 2>&1 >> apt-file.log &
    fi

    if command -v emacs &> /dev/null; then
        ev=$(emacs --version | head -1 | grep -Po '[0-9]+\.[0-9]+')
        msg "Emacs version $ev is installed."
        emacs_package=
    else
        msg "Didn't find emacs"
        emacs_package=emacs
        # If it won't install emacs 28, don't bother
        if [[ ! $($aptcmd -V -s install $emacs_package | grep -o -E "emacs.*-nox.*28\..") ]]; then
            msg "Furthermore, the system-installable emacs isn't emacs 28."
            emacs_package=emacs28
        fi
        if [[ -f /etc/apt/sources.list.d/kelleyk-ubuntu-emacs-focal.list ]]; then
            msg "Happily, we have a newer emacs PPA"
        else
            msg "Adding Kevin Kelley's newer emacs PPA"
            if [[ ! -x $(which add-apt-repository) ]]; then
		msg "Software-properties-common fails on ppa.py the first time it's installed."
		msg "It seems to reinstall OK, though."
                sudo $aptcmd install -y software-properties-common
            fi
            sudo add-apt-repository -y ppa:kelleyk/emacs
            sudo apt update
        fi
    fi
    install_me="$install_me $emacs_package"

    if [[ -z $(echo $install_me) ]]; then
        msg "Nothing new to install"
    else
        msg "Installing \"$install_me\""
        sudo $aptcmd install -y $install_me
    fi
    if ! command -v emacs &> /dev/null; then
        msg "Still no emacs, but keeping calm and carrying on."
    else
        ev=$(emacs --version | head -1 | grep -Po '[0-9]+\.[0-9]+')
        if [[ $ev < 28.1 ]]; then
            msg "Emacs version is $ev, which isn't 28."
            msg "Sigh."
        fi
    fi

    msg "Checking for swapfile"
    if [[ -f /swapfile ]]; then
	msg "Leaving existing swapfile alone."
    else
        # TODO: Add setup --interactive, ask sudo password and swapfile size up front
        mem=$(grep MemTotal /proc/meminfo | tr -s ' ' | cut -f2 -d' ')
        mb=$(( $mem/1024 ))
        msg "You seem to have $mb MB of RAM"
        if [ $mb -gt 2048 ]; then
            msg "Which is > 2 GB, so not setting up 1G swapfile"
        else
            msg "This is a small-memory system, so setting up a token 1G swapfile"
            # TODO: Make this a separate script
	    sudo fallocate -l 1G /swapfile
	    sudo chmod 600 /swapfile
	    sudo mkswap /swapfile
	    sudo swapon /swapfile
            # This should probably instead be "dphys-swapfile on" instead for modern debian
	    sudo sh -c 'echo "" >> /etc/fstab'
	    sudo sh -c 'echo "/swapfile   none    swap    sw    0   0" >> /etc/fstab'
	    sudo swapon -s
        fi
    fi

    if [[ -x /opt/scripts/tools/grow_partition.sh ]]; then
        msg "Could grow root filesystem.  Are we on a beaglebone?"
        cd /opt/scripts/tools/
        sudo git config --global --add safe.directory /opt/scripts
        sudo git pull || true
        flag=grew-partition.flag
        if [ -f $flag ]; then
            msg "Partition already grown."
        else
            msg "Partition hasn't already been grown, so. . ."
            sudo ./grow_partition.sh
            sudo touch $flag
            msg "Please reboot ASAP.  Partitions may have changed."
        fi
    fi

    msg "Turning off window-maximize when it hits the top bar"
    # Don't care if it fails
    gsettings set org.gnome.mutter edge-tiling false

    if ! command -v git-town &> /dev/null ; then
        msg "Install Git Town"
        installers/install-git-town.sh
    fi
fi

#if [[ -x "$(which npm)" ]]; then
#    msg "Installing mathjax-node-cli for org-latex-impatient"
#    npm install mathjax-node-cli
#fi

msg "Fetching GNU Emacs Package Repo keys (valid in 2019 at least)"
GNUPG_DIR=$HOME/.emacs.d/elpa/gnupg
mkdir -p $GNUPG_DIR
chmod go-rwx $GNUPG_DIR
gpg --homedir $GNUPG_DIR --receive-keys 066DAFCB81E42C40

if [[ -f "plex-mono.zip" ]]; then
    msg "Plex mono already downloaded, skipping download and install"
else
    msg "Fetching plex-mono"
    curl -o plex-mono.zip https://fonts.google.com/download?family=IBM%20Plex%20Mono
    # Should also check to see if these fonts are already installed
    if [ $name == "Darwin" ]; then
        pushd /Library/Fonts
    else
        mkdir -p ~/.fonts && pushd ~/.fonts
    fi
    sudo unzip ~/myDotfiles/plex-mono.zip
    popd
fi

msg "Done"
