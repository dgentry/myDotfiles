#!/bin/bash

shopt -s expand_aliases
source ~gentry/.aliases
myname=$0

msg "All packages:"
packages
echo " "

current_linux=$(uname -r)
msg "Currently running: $current_linux"
echo " "

linuxlines=$(linux-version sort --reverse $(linux-version list))
linuxlist=$(echo $linuxlines)
linuxcount=$(echo $linuxlist | wc -w)

if [[ $linuxcount > 1 ]]; then
    msg "There are ${linuxcount} on this system:"
    echo "$linuxlines"
    echo " "
    # We only want to clean up linuxes older than the currently
    # running one.
    msg "Can we clean any up?"
    removable_kernels=()
    for i in $linuxlist; do
        if $(linux-version compare $i lt $current_linux); then
            # msg "Yes.  $i is less than $current_linux."
            removable_kernels+=($i)
        fi
    done

    msg " "
    if [[ "${#removable_kernels[@]}" == 0 ]]; then
        msg "No."
    else
        msg "Yes. Kernels to clean up: $removable_kernels"
        for k in "${removable_kernels[@]}"; do
            msg "Cleaning up $k"
            sudo apt remove -y linux-modules-$k linux-modules-extra-$k \
                               linux-headers-$k
        done

    fi
fi
