# Not sure why this is here -- should probably be setting it from .common
export PATH=$HOME/bin:/opt/homebrew/opt/ccache/libexec:/opt/homebrew/bin:/usr/local/bin:/opt/homebrew/sbin:/usr/local/sbin:/snap/bin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/games:/Library/TeX/texbin

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
