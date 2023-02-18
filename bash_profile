export BASH_SILENCE_DEPRECATION_WARNING=1

if [[ -f ${HOME}/.bashrc ]]; then
   source "${HOME}/.bashrc"
fi

if [[ -f $HOME/.cargo/env ]]; then
    . "$HOME/.cargo/env"
fi
