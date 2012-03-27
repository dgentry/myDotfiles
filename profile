# -*- Mode: sh -*-

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

echo '.profile here'

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

echo '.profile done'
