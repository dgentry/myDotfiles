# For MacPorts. . . 
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

[[ -s "/Users/gentry/.rvm/scripts/rvm" ]] && source "/Users/gentry/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f .aliases ]; then
    . .aliases
fi
