#!/bin/bash -x

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Setting PATH for Python 2.7
# export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="$HOME/.cargo/bin:$PATH"
export BASH_SILENCE_DEPRECATION_WARNING=1
