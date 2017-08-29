#!/bin/bash
# -*- Mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# For Brew, then Macports. . ., also RVM to PATH for scripting
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/Library/Contributions/cmds:/usr/local/CrossPack-AVR/bin:/Library/TeX/texbin

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ "$0" = "/etc/X11/Xsession" ] ; then
    return
fi

# WTF is a Bourne Shell doing executing my fucking .bashrc?  Get your
# own goddamn .profile or whatever.  Fucking X11.
# echo "Zero is $0"
# echo "BASH is $BASH"
# echo "SHELL is $SHELL"
if [ ! -n "$BASH" ] ;then exit 0; fi

name="$(uname)"
if [[ "$name" == "Darwin" ]]; then
    echo -n ".bashrc (Mac) starting:" `date +%S`" "
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    name="Linux"
    start_time=$(date +%S.%N)
    #echo -n ".bashrc at: ${start_time:0:6}"
    echo -n "+"

    SSH_ENV="$HOME/.ssh/environment"

    if [ ! -S ~/.ssh/ssh_auth_sock ]; then
        eval `ssh-agent`
        ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    fi
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    ssh-add -l | grep "The agent has no identities" && ssh-add
fi

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

export EDITOR='emacs'
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
export IPYTHONDIR='~/.ipython'
if [ -f ~/.virtualenv/v/bin/activate ]; then
    source ~/.virtualenv/v/bin/activate
else
    echo "Missing virtualenv, yo."
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1:/'
}

# Should maybe switch from escape sequences for colors to tput
get_PS1(){
    # Putting the prompt string in \[\] makes bash not count those
    # characters for line editing purposes.
    bold_blue="\[\e[01;34m\]"
    #bold_lightgreen="\e[01;38;05;77m"
    bold_red="\[\e[01;31m\]"
    bold_green="\[\e[01;32m\]"
    #periwinkle="\[\e[01;34m\]"
    yellow="\[\e[01;33m\]"
    norm="\[\e[00m\]"

    # echo "${bold_yellow}$PS1${norm}"
    # Turn the prompt symbol red if the user is root
    if [ $(id -u) -eq 0 ];
    then # you are root, we want a red hash
	root_or_user="${bold_red}# ${norm}"
    else # regular users get a green $
	root_or_user="${bold_green}$ ${norm}"
    fi

    # There is probably an easier way to replace "/Users/gentry" with "~"
    home_len="${#HOME}"
    home_match="${PWD:0:${home_len}}"
    if [[ "${home_match}" = "${HOME}" ]]; then
        WD="~${PWD:${home_len}:${#PWD}}"
    else
	WD="${PWD}"
    fi
    # Now WD starts with ~, or an absolute path

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
    gb=${yellow}$(git_branch)${norm}
    PS1="$v${bold_green}\u@\h${norm}${bold_blue} ${gb}${elided_path} ${root_or_user}"
}

PROMPT_COMMAND=get_PS1

#export TERM=cathode
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*|cathode)
#     PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#     ;;
# *)
#     ;;
# esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# mount the android file image
function mountAndroid { hdiutil attach ~/android.dmg.sparseimage -mountpoint /Volumes/android; }

#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export COMMAND_MODE=legacy

# Passwords and stuff could go here, just an API token as of 2015-10
if [ -r ~/.not-public ]
then
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
  echo -n "$(tput setaf 1)r$(tput setaf 2)g$(tput setaf 4)b$(tput sgr0) "
  source $GRC
fi

if [ $name == "Darwin" ]; then
    echo "done:" `date +%S`
else
    now=`date +%S.%N`
    delta=`echo "3 k $now $start_time - p" | dc`
    echo ${delta:0:4}
fi

export TPG_SUPPRESS_LOGIN=jeebus_h_christ
