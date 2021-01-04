#!/usr/bin/env bash

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
myname=${my_long_name#$annoying_prefix}  # Now just "install-brew.sh"
source msg.sh

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

function brew_needs_install() {
    # First arg is --cask or ""
    # If the package is missing, return true
    if brew ls $1 --versions $2 > /dev/null 2>&1; then
        return 1
    fi
    return 0
}

function fetch_deep() {
    if $(git rev-parse --is-shallow-repository $1); then
        msg "Unshallowing $1"
        git -C $1 fetch --unshallow
    fi
}

name="$(uname)"
if [ $name == "Darwin" ]; then
    msg "I'm a Mac."

    # Install brew if necessary
    if ! [ -x $(which brew) ]; then
        msg "Installing brew"
        source install-brew.sh
    fi

    # Apparently necessary, just once, due to some homebrew foul-up
    fetch_deep /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core
    fetch_deep /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask

    # "Normal" brew packages
    brew_wanted="git-town figlet"
    brew_to_install=""
    msg "Checking for previous brew installs of $wht$brew_wanted"
    msg "This can take a minute, but it saves time later."
    # We have to check these one at a time because brew just errors
    # out if you list one that isn't installed.
    for pkg in $brew_wanted; do
        if brew_needs_install "" git-town; then
            brew_to_install="$brew_to_install $pkg"
        fi
    done

    if [ $brew_to_install ]; then
        # brew_to_install, if it has anything, has a leading space
        msg "Installing$brew_to_install"
        brew install $brew_to_install
    fi

    # "Cask" brew packages
    brew_wanted="google-chrome iterm2 slack discord quicksilver caffeine clover-configurator synergy steam battle-net macdown vlc"
    brew_to_install=""
    msg "Checking for casks $wht$brew_wanted"
    for pkg in $brew_wanted; do
        if brew_needs_install --cask $pkg; then
            brew_to_install="$brew_to_install $pkg"
        fi
    done

    if [ $brew_to_install ]; then
        msg "Installing$brew_to_install"
        brew install --cask $brew_to_install
    else
        msg "Everything already installed, yay."
    fi

    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
else
    echo "Assuming you're on some kind of Unix."

    export LANGUAGE=en_US.utf8
    export LANG=en_US.utf8
    export LC_ALL=en_US.utf8
    LOCALES="$(localedef --list-archive /usr/lib/locale/locale-archive)"
    # Is en_US.utf8 in LOCALES?
    if [[ "$LOCALES" == *"$LC_ALL"* ]]; then
        echo "Looks like you already have locale $LC_ALL"
    else
        echo "A bunch of packages complain about locale problems on Ubuntu and Debian, so:"
        exit
        sudo locale-gen en_US.utf8
        # I don't think this is necessary -- locale-gen just did what we needed
        # dpkg-reconfigure locales
    fi

    echo "Installing python 3 pip"
    sudo apt-get install -y python3-pip

    echo "Installing apt-file"
    sudo apt-get install -y apt-file

    echo "Spinning off apt-file update, output to apt-file.log."
    sudo apt-file update 2>%1 >> apt-file.log &

    echo "Installing lolcat (python, not ruby)"
    pip install lolcat

    echo "Fetching GNU Emacs Package Repo keys (valid in 2019 at least)"
    GNUPG_DIR=$HOME/.emacs.d/elpa/gnupg
    mkdir -p $GNUPG_DIR
    chmod go-rwx $GNUPG_DIR
    gpg --homedir $GNUPG_DIR --receive-keys 066DAFCB81E42C40
fi
