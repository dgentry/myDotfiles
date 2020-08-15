#!/usr/bin/env bash

BASHCOMP=~/.bash_completion.d

# Make a .bash_completion directory
if [[ ! -d "$BASHCOMP" ]]; then
    # If this ever turns out to be a symlink (which it could), I'll add the -L check.
    mkdir "$BASHCOMP"
fi

# Symlink .git_completion until I figure out how I really want to do multilevel symlinks.
if [[ ! -L "$BASHCOMP/git_completion.bash" ]]; then
    ln -s "$PWD/git-completion.bash" "$BASHCOMP/"
fi

# Turn off pager behavior for git
git config --global pager.branch false

name="$(uname)"
if [ $name == "Darwin" ]; then
    echo "It's a Mac."

    # Install brew, I guess
    source install-brew.sh

    brew install git-town
    brew cask install google-chrome
    brew cask install iterm2 slack discord

    brew cask install quicksilver caffeine
    brew cask install clover-configurator
    brew cask install synergy
    brew cask install steam battle-net
    brew cask install backblaze
    brew cask install macdown
    brew cask install vlc
else
    echo "Assuming you're on some kind of Unix."

    echo "A bunch of packages complain about locale problems on Ubuntu and Debian, so:"
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    sudo locale-gen en_US.UTF-8
    # Not sure if this is necessary:
    # dpkg-reconfigure locales

    echo "Installing python 3 setuptools."
    sudo apt-get install python3-pip

    echo "Fetching GNU Emacs Package Repo keys (valid in 2019 at least)"
    GNUPG_DIR=$HOME/.emacs.d/elpa/gnupg
    mkdir -p $GNUPG_DIR
    chmod go-rwx $GNUPG_DIR
    gpg --homedir $GNUPG_DIR --receive-keys 066DAFCB81E42C40
fi
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
