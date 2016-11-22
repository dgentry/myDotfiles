#!/bin/bash
# -*- Mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# For Brew, then Macports. . ., also RVM to PATH for scripting
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/Library/Contributions/cmds:/usr/local/CrossPack-AVR/bin:/Library/TeX/texbin

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

name="$(uname)"
if [ $name == "Darwin" ]; then
    echo -n ".bashrc (Mac) starting:" `date +%S`" "
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    name="Linux"
    start_time=`date +%S.%N`
    #echo -n ".bashrc at: ${start_time:0:6}"
    echo -n "+"
fi

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

# if [ -f "${SSH_ENV}" ]; then
#      . "${SSH_ENV}" > /dev/null
#      #ps ${SSH_AGENT_PID} doesn't work under cywgin
#      ps auxww | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#          start_agent;
#      }
# elif [ $name != "Linux" ]; then
#     echo $name
#     #start_agent;
# fi

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
if [ -f .virtualenv/default/bin/activate ]; then
    echo "Default Virtualenv, yo."
    source .virtualenv/default/bin/activate
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Should maybe switch from escape sequences for colors to tput
get_PS1(){
    # Putting the prompt string in \[\] makes bash not count those
    # characters for line editing purposes.
    bold_blue="\e[01;34m"
    bold_lightgreen="\e[01;38;05;77m"
    bold_red="\e[01;31m"
    bold_green="\e[01;28m"
    bold_yellow="\e[01;33m"
    norm="\e[00m"

    # echo "${bold_yellow}$PS1${norm}"
    # Turn the prompt symbol red if the user is root
    if [ $(id -u) -eq 0 ];
    then # you are root, we want a red hash
	root_or_user="\[${red}\]#\[${norm}\]"
    else # regular users get a green $
	root_or_user="\[${bold_green}\]$\[${norm}\]"
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
        PS1="\[${periwinkle}\]\u@\h\[${bold_blue}\] ${left}...${right} \[\033[00m\]${root_or_user} "
    else
        PS1="\[${periwinkle}\]\u@\h\[${bold_blue}\] \w \[\033[00m\]${root_or_user} "
    fi

    # If we have a venv, say so:
    if [ $VIRTUAL_ENV ]; then
	v="($(basename $VIRTUAL_ENV))"
    else
	v=""
    fi
    PS1="$v$PS1"

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
