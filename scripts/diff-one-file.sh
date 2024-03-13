#!/bin/bash

declare -a commits=($(git log --oneline $1 | cut -f 1 -d' '))

previous_commit=""
for c in ${commits[@]}; do
    if [[ ! -z "$previous_commit" ]]; then
        git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold white)— %an%C(reset)' --abbrev-commit -1 $previous_commit $1
        echo " "
        git --no-pager diff $c $previous_commit $1
        echo " "
        echo " "
    fi
    previous_commit=$c
done
