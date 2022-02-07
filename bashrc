#!/bin/bash
# -*- Mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

export BASH_SILENCE_DEPRECATION_WARNING=1

source "${HOME}/.common"

# World's fanciest prompt:
# Should maybe switch from escape sequences for colors to tput
get_PS1(){
    if [[ $TERM != "screen" ]]; then
	if [[ -e "iterm2_set_user_var" ]]; then
            iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
	fi
    fi
    # Putting the prompt string in \[\] makes bash not count those
    # characters for line editing purposes.
    bold_blue="\[\e[01;34m\]"
    #bold_lightgreen="\e[01;38;05;77m"
    bold_red="\[\e[01;31m\]"
    bold_green="\[\e[01;32m\]"
    #periwinkle="\[\e[01;34m\]"
    bold_yellow="\[\e[01;33m\]"
    norm="\[\e[00m\]"

    # echo "${bold_yellow}$PS1${norm}"
    # Turn the prompt symbol red if the user is root
    if [ $(id -u) -eq 0 ];
    then # you are root, we want a red hash
	root_or_user="${bold_red}# ${norm}"
    else # regular users get an amber $
	root_or_user="${bold_yellow}$ ${norm}"
    fi

    # There is probably an easier way to replace "/Users/gentry" with "~"
    home_len="${#HOME}"
    home_match="${PWD:0:${home_len}}"
    if [[ "${home_match}" = "${HOME}" ]]; then
        WD="~${PWD:${home_len}:${#PWD}}"
    else
	WD="${PWD}"
    fi
    # Now WD starts with ~ or an absolute path

    limit=${1:-26}
    if [[ "${#WD}" -gt "$limit" ]]; then
        ## Take the first 8 characters of the path
        left="${WD:0:8}"
        ## ${#WD} is the length of $WD. Get the last ($limit - 8)
        ##  characters of $WD.
        right="${WD:$((${#WD}-($limit-8))):${#WD}}"
        elided_path=${left}...${right}
    else
        elided_path="\w"
    fi

    # If we have a venv, say so:
    if [ "$VIRTUAL_ENV" ]; then
	v="($(basename "$VIRTUAL_ENV"))"
    else
	v=""
    fi
    gb=${bold_yellow}$(git_branch)${norm}
    if [[ -z "$SSH_CLIENT" ]]; then
        host="@\h"
    else
        host="${bold_yellow}@\h${norm}"
    fi
    PS1="$v${bold_green}\u${norm}${host}${bold_blue} ${gb}${elided_path} ${root_or_user}"
}

PROMPT_COMMAND=get_PS1

# enable programmable completion features (you don't need to enable
# this if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# Too slow!
#BREW_PREFIX=$(brew --prefix)

BREW_PREFIX=/usr/local

if [ -x "$(command -v brew)" ]; then
    if [ -f /etc/bash_completion ]; then
        source $BREW_PREFIX/etc/bash_completion
    fi
fi

if [ -d "${HOME}/.bash_completion.d" ]; then
    have()
    {
        unset -v have
        # Completions for system administrator commands are installed as well in
        # case completion is attempted via `sudo command ...'.
        export PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin type $1 &>/dev/null &&
        have="yes"
    }
    for file in "${HOME}/.bash_completion.d/"*
    do
	source "$file"
    done
fi

export COMMAND_MODE=legacy

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
. "$HOME/.cargo/env"
