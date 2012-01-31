# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile
#umask 022

echo ".profile pre .bashrc" `date +%S.%N`
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f ~/.bashrc ]; then
	. ~/.bashrc
    fi
fi
echo ".profile post .bashrc" `date +%S.%N`

# For Brew, python via brew, then Macports. . . 
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$PATH:/Users/gentry/.cabal/bin:/opt/local/bin:/opt/local/sbin

[[ -s "/Users/gentry/.rvm/scripts/rvm" ]] && source "/Users/gentry/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f ~/.aliases ]; then
    echo '.aliases here'
    . ~/.aliases
fi

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 


# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    #alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

echo ".profile done" `date +%S.%N`
