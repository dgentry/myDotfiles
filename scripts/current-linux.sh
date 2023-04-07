#!/bin/bash

myname=clean-linux-packages

# Variables for colors/contrast
txtbld=$(tput bold)             # Bold
bldblu=${txtbld}$(tput setaf 4)
bldgrn=${txtbld}$(tput setaf 2)
txtrst=$(tput sgr0)             # Reset

msg() {
    echo "$bldblu$1${txtrst}"
}


version=$(uname -a | cut -f3 -d' ')
version=${version%$"-generic"}

# msg "Running kernel version is $bldgrn$version."

tmpfile=$(mktemp)

function packages() {
    dpkg-query --show --showformat='${Installed-Size}\t${Package}\n' | sort -rh | head -25 | awk '{print $1/1024, $2}'
}

# Remove sizes with the cut
packages | cut -f2- -d' ' | grep -E 'linux-modules|linux-headers'  > ${tmpfile}

# Ideally, our linux version would match the highest versioned
# linux-modules and -headers, but the only way to fix that is a reboot.
highest=$(grep linux-headers- $tmpfile | cut -d'-' -f3- | sort -n | tail -1)


if [[ $version == $highest ]]; then
    msg "Kernel matches highest installed header/module: $bldgrn$highest"
else
    msg "Kernel version $bldgrn$version ${bldblu}, highest module version is $bldgrn$highest."
    msg "So retaining both.  After a reboot, you can also get rid of $bldgrn$version."
fi

# So just keep the highest versioned packages, plus those currently in use

B=$(mktemp)
grep -v $version ${tmpfile} | grep -v $highest > $B

if [ -s $B ]; then
    msg "That leaves these packages to go away:\n"
    cat $B
    xargs sudo apt-get --purge -y remove < $B
else
    msg "There aren't any extra linux packages."
    exit 0
fi
