!#/bin/bash

set -x

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "Trying 64 bit amd."
    if [[ -x `which dpkg` ]]; then
	curl -O -L https://github.com/git-town/git-town/releases/download/v7.8.0/git-town_7.8.0_linux_intel_64.deb
	sudo dpkg -i git-town_7.8.0_linux_intel_64.deb
    else
	echo "No dpkg.  Giving up."
    fi

elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    echo "Trying linux arm."
    curl -O -L https://github.com/git-town/git-town/releases/download/v7.8.0/git-town_7.8.0_linux_arm_64.deb
    sudo dpkg -i git-town_7.8.0_linux_arm_64.deb
fi
