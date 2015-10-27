
# -*- Mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# For Brew, then Macports. . ., also RVM to PATH for scripting
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/Library/Contributions/cmds:/usr/local/CrossPack-AVR/bin:/usr/texbin

# "The OpenCV Python module will not work until you edit your
# PYTHONPATH like so:"
#export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

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


# Do I use this?  Not on raspberry pi, I guess.
# source /usr/local/bin/virtualenvwrapper.sh

# Load RVM into a shell session *as a function*
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

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

export EDITOR='emacs'
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
export IPYTHONDIR='~/.ipython'

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

#export TERM=cathode
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|cathode)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

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
if [ -r /usr/local/etc/grc.bashrc ]
then
  echo -n "$(tput setaf 1)r$(tput setaf 2)g$(tput setaf 4)b$(tput sgr0) "
  source "/usr/local/etc/grc.bashrc"
fi

if [ $name == "Darwin" ]; then
    echo "done:" `date +%S`
else
    now=`date +%S.%N`
    delta=`echo "3 k $now $start_time - p" | dc`
    echo ${delta:0:4}
fi
