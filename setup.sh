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
    brew cask install vlc audacity
else
    echo "Assuming you're on some kind of Unix."
    echo "Installing python 3 setuptools."
    sudo apt-get install python3-pip
fi
