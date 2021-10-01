#!/bin/bash
# -*- Mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

export BASH_SILENCE_DEPRECATION_WARNING=1
export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/games
# Maybe these can have symlinks? /usr/local/CrossPack-AVR/bin:/Library/TeX/texbin

# Wacky python pathery
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/opt/python@3.9/Frameworks/Python.framework/Versions/3.9/bin:$PATH
# Perl is stupid
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ "$0" = "/etc/X11/Xsession" ] ; then
    return
fi

# WTF is a Bourne Shell (sh) doing executing my fucking .bashrc?  Get your
# own goddamn .profile or whatever.  Fucking X11.  Man I hate X11.
# echo "Zero is $0"
# echo "BASH is $BASH"
# echo "SHELL is $SHELL"
if [ ! -n "$BASH" ] ;then exit 0; fi

name="$(uname)"
#if [[ "$name" != "Darwin" ]] && [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then

if [ $name != "Darwin" ]; then
    if [[ -x /usr/local/bin/gdate ]]; then
        DATE=/usr/local/bin/gdate
    else
        DATE=$(which date)
    fi
    start_time=$(${DATE} +%S.%N)
    # Shut up whiny perl program installers
    export LANGUAGE=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi

# Start an ssh agent
SSH_ENV="$HOME/.ssh/environment"
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add


if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

export EDITOR='emacs'
export LESS='-R --no-init --quit-if-one-screen'
export LESSOPEN='|~/.lessfilter %s'

export IPYTHONDIR='~/.ipython'
if [ -f ~/.virtualenv/3/bin/activate ]; then
    source ~/.virtualenv/3/bin/activate
else
    echo "Missing python virtualenv, yo."
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# World's fanciest prompt:
# Should maybe switch from escape sequences for colors to tput
get_PS1(){
    if [[ $TERM != "screen" ]]; then
        iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
    fi
    # Putting the prompt string in \[\] makes bash not count those
    # characters for line editing purposes.
    bold_blue="\[\e[01;34m\]"
    #bold_lightgreen="\e[01;38;05;77m"
    bold_red="\[\e[01;31m\]"
    bold_green="\[\e[01;32m\]"
    #periwinkle="\[\e[01;34m\]"
    bold_yellow="\[\e[01;33m\]"
    norm="\[\e[00m\]"

    # echo "${bold_yellow}$PS1${norm}"
    # Turn the prompt symbol red if the user is root
    if [ $(id -u) -eq 0 ];
    then # you are root, we want a red hash
	root_or_user="${bold_red}# ${norm}"
    else # regular users get an amber $
	root_or_user="${bold_yellow}$ ${norm}"
    fi

    # There is probably an easier way to replace "/Users/gentry" with "~"
    home_len="${#HOME}"
    home_match="${PWD:0:${home_len}}"
    if [[ "${home_match}" = "${HOME}" ]]; then
        WD="~${PWD:${home_len}:${#PWD}}"
    else
	WD="${PWD}"
    fi
    # Now WD starts with ~ or an absolute path

    limit=${1:-26}
    if [[ "${#WD}" -gt "$limit" ]]; then
        ## Take the first 8 characters of the path
        left="${WD:0:8}"
        ## ${#WD} is the length of $WD. Get the last ($limit - 8)
        ##  characters of $WD.
        right="${WD:$((${#WD}-($limit-8))):${#WD}}"
        elided_path=${left}...${right}
    else
        elided_path="\w"
    fi

    # If we have a venv, say so:
    if [ "$VIRTUAL_ENV" ]; then
	v="($(basename "$VIRTUAL_ENV"))"
    else
	v=""
    fi
    gb=${bold_yellow}$(git_branch)${norm}
    if [[ -z "$SSH_CLIENT" ]]; then
        host="@\h"
    else
        host="${bold_yellow}@\h${norm}"
    fi
    PS1="$v${bold_green}\u${norm}${host}${bold_blue} ${gb}${elided_path} ${root_or_user}"
}

PROMPT_COMMAND=get_PS1

# Badge for iterm2
# Show the current session name and git branch, if any is set.
printf "\e]1337;SetBadgeFormat=%s\a" \
       $(echo -n "\(user.gitBranch)" | base64)

#export TERM=cathode
#If this is cathode, could set some primitive prompt.
#case "$TERM" in
#xterm*|rxvt*|cathode)
#     PROMPT_COMMAND='$ '
#     ;;
# *)
#     ;;
# esac

# enable programmable completion features (you don't need to enable
# this if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Too slow!
#BREW_PREFIX=$(brew --prefix)
BREW_PREFIX=/usr/local

if [ -x "$(command -v brew)" ]; then
    if [ -f /etc/bash_completion ]; then
        source $BREW_PREFIX/etc/bash_completion
    fi
fi

if [ -d "$HOME/.bash_completion.d" ]; then
    have()
    {
        unset -v have
        # Completions for system administrator commands are installed as well in
        # case completion is attempted via `sudo command ...'.
        export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin type $1 &>/dev/null &&
        have="yes"
    }
    for file in "$HOME/.bash_completion.d/"*
    do
	source "$file"
    done
fi

export COMMAND_MODE=legacy

# Passwords and stuff could go here, just an API token as of 2015-10
if [ -r ~/.not-public ]; then
    source ~/.not-public
fi

# This makes a bunch of commands colorize their output
if [ -r /usr/local/etc/grc.bashrc ]; then
  GRC=/usr/local/etc/grc.bashrc
elif [ -r /etc/grc.bashrc ]; then
  GRC=/etc/grc.bashrc
elif [ -r $HOME/myDotfiles/grc.bashrc ]; then
  GRC=$HOME/myDotfiles/grc.bashrc
elif [ -r $HOME/github/myDotfiles/grc.bashrc ]; then
  GRC=$HOME/github/myDotfiles/grc.bashrc
fi

if [ ! -z "$GRC" ]; then
  echo -n "$(tput setaf 1)r$(tput setaf 2)g$(tput setaf 4)b$(tput sgr0)"
  source $GRC
else
  echo -n "monochrome"
fi

if [ $name == "Darwin" ]; then
    echo ""
else
    now=$(${DATE} +%S.%N)
    delta=`echo "3 k $now $start_time - p" | dc`
    echo " ${delta:0:4}"
fi

# if [[ -f ~/.autoenv/activate.sh ]]; then
#     source ~/.autoenv/activate.sh
# elif [ -x "$(command -v brew)" ]; then
#     if [[ -f "$BREW_PREFIX/autoenv/activate.sh" ]]; then
#         source "$BREW_PREFIX/autoenv/activate.sh"
#     fi
# fi
# export AUTOENV_ENABLE_LEAVE=yes

#eval "$(direnv hook bash)"

# llvm linking:

# llvm is keg-only, which means it was not symlinked into /usr/local,
# because macOS already provides this software and installing another version in
# parallel can cause all kinds of trouble.

# If you need to have llvm first in your PATH run:
# export PATH="/usr/local/opt/llvm/bin:$PATH"

# For compilers to find llvm you may need to set:
# export LDFLAGS="-L/usr/local/opt/llvm/lib"
# export CPPFLAGS="-I/usr/local/opt/llvm/include"

# To use the bundled libc++ please add the following LDFLAGS:
#LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"

if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi

hostname -s | figlet >/tmp/xyzzy
lolcat </tmp/xyzzy
weather

#CPU Temp
# figlet "CPU Temp" | lolcat
# osx-cpu-temp | figlet | lolcat

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
