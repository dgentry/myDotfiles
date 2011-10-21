
# MacPorts Installer addition on 2011-10-02_at_02:06:31: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

[[ -s "/Users/gentry/.rvm/scripts/rvm" ]] && source "/Users/gentry/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f .aliases ]; then
    . .aliases
fi
