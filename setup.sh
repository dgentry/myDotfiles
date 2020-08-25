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

    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
else
    echo "Assuming you're on some kind of Unix."

    export LANGUAGE=en_US.utf8
    export LANG=en_US.utf8
    export LC_ALL=en_US.utf8
    LOCALES="$(localedef --list-archive /usr/lib/locale/locale-archive)"
    echo "Existing locales: $LOCALES"
    if [[ x"$LOCALES"x == x"$LC_ALL"x ]]; then
        echo "Looks like you already have locale $LC_ALL"
    else
        echo "A bunch of packages complain about locale problems on Ubuntu and Debian, so:"
        sudo locale-gen en_US.utf8
        # I don't think this is necessary -- locale-gen just did what we needed
        # dpkg-reconfigure locales
    fi

    echo "Installing python 3 setuptools."
    sudo apt-get install -y python3-pip

    sudo apt-get install -y figlet apt-file

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
