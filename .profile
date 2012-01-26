# For Brew, python via brew, then Macports. . . 
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python:$PATH:/Users/gentry/.cabal/bin:/opt/local/bin:/opt/local/sbin

[[ -s "/Users/gentry/.rvm/scripts/rvm" ]] && source "/Users/gentry/.rvm/scripts/rvm"  # This loads RVM into a shell session.

echo '.profile here'

if [ -f ~/.aliases ]; then
    echo '.aliases here'
    . ~/.aliases
fi
