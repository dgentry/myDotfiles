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

# Install brew, I guess
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
