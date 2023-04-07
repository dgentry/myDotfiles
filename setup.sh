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

packages_everywhere='figlet gpg nmap universal-ctags'

# What am I?
arch_name="$(uname -m)"
name="$(uname)"
if [ $name == "Darwin" ]; then
    msg "I'm a Mac."
    if [ "${arch_name}" = "x86_64" ]; then
        if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
            msg "Running on Rosetta 2"
        else
            msg "Running on native Intel"
        fi
    elif [ "${arch_name}" = "arm64" ]; then
        msg "Running on ARM"
    else
        msg "on an unknown architecture, ${arch_name}.  Bye."
        exit 1
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

    # "Normal" brew packages
    brew_wanted="git-town $packages_everywhere"
    brew_to_install=""
    msgn "Checking for previous brew installs of "
    # We have to check these one at a time because brew just errors
    # out if you list one that isn't installed.
    for pkg in $brew_wanted; do
        echo -n "${bldwht}${pkg}${rst} "
        if brew_needs_install "" $pkg; then
            brew_to_install="$brew_to_install $pkg"
        fi
    done
    if [[ ! $brew_to_install ]]; then
        echo "${bldblu}Already installed."
    else
        # Finish the msgn
        echo ""
        # brew_to_install, if it has anything, has a leading space
        msg "Installing$brew_to_install"
        brew install $brew_to_install
    fi

    # "Cask" brew packages
    brew_cask_wanted="emacs google-chrome iterm2 slack discord quicksilver caffeine clover-configurator steam battle-net macdown vlc"
    brew_to_cask_install=""
    msgn "Checking for casks "
    for pkg in $brew_cask_wanted; do
        echo -n "${bldwht}${pkg}${rst} "
        if brew_needs_install --cask $pkg; then
            brew_to_cask_install="$brew_to_cask_install $pkg"
        fi
    done

    if [[ ! $brew_to_cask_install ]]; then
        # Finish msgn
        echo "${bldblu}Already installed."
    else
        # Finish msgn
        echo ""
        msg "Installing$brew_to_cask_install"
        brew install --cask $brew_to_cask_install
    fi

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

    export LANGUAGE=en_US.utf8
    export LANG=en_US.utf8
    export LC_ALL=en_US.utf8
    LOCALES="$(localedef --list-archive /usr/lib/locale/locale-archive)"
    # Is en_US.utf8 in LOCALES?
    if [[ "$LOCALES" == *"$LC_ALL"* ]]; then
        msg "We already have locale $LC_ALL"
    else
        msg "A bunch of packages complain about locale problems on Ubuntu and Debian, so:"
	sudo apt-get install -y locales
        sudo locale-gen en_US.utf8
    fi

    msg "Updating package lists"
    sudo apt-get update

    msg "Installing python 3 pip and venv"
    sudo apt-get install -y python-is-python3
    # Crazily enough, in Nov 2021, this results in
    # "python-dev-is-python2" being installed if you haven't
    # previously installed the python3 version.
    sudo apt-get install -y python3-pip python3-venv

    msg "Installing apt-file"
    sudo apt-get install -y apt-file

    msg "Spinning off apt-file update, output to apt-file.log."
    sudo apt-file update 2>&1 >> apt-file.log &

    # ev=$(emacs --version | head -1 | grep -Po '[0-9]+\.[0-9]+')
    if ! command -v emacs &> /dev/null; then
        msg "Didn't find emacs"
        emacs_package=emacs-nox
    else
        msg "Emacs is already installed."
        emacs_package=
    fi
    msg "Installing $packages_everywhere"
    sudo apt-get install -y $packages_everywhere $emacs_package grc silversearcher-ag

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
	    sudo echo "" | sudo tee /etc/fstab
	    sudo echo "/swapfile   none    swap    sw    0   0" | sudo tee /etc/fstab
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

    msg "Install Git Town"
    installers/install-git-town.sh
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

if ! [[ -x $( which lolcat ) ]]; then
    msg "Installing lolcat (python, not ruby)"
    pip3 install lolcat
fi

msg "Done"
