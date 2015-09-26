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

echo ".bashrc interactive starting:" `date +%S.%N`

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

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps auxww | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi


if [ -f ~/.aliases ]; then
#    echo '.aliases here'
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
export HOMEBREW_GITHUB_API_TOKEN=4d015f8446cbec8689bdf52fa9dda9c0921221bf

# This makes a bunch of commands colorize their output
if [ -r /usr/local/bin/etc/grc.bashrc ]
then
  echo "Colors on."
  source "/usr/local/bin/etc/grc.bashrc"
fi

echo ".bashrc interactive done:" `date +%S.%N`
