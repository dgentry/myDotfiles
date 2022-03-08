#!/bin/bash -x

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Setting PATH for Python 2.7
# export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export BASH_SILENCE_DEPRECATION_WARNING=1

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -f . "$HOME/.cargo/env" ]] && source $HOME/.cargo/env
