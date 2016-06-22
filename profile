# -*- Mode: sh -*-

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Setting PATH for Python 2.7
# export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
