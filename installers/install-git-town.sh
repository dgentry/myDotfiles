#!/bin/bash

# I would check the version number, but git-town-version returns "Git Town  ()"
git_town=$(which git-town)
if [[ -x $git_town ]]; then
    echo "$git_town appears to be installed, exiting."
    exit
fi

# v7.8.0 current as of Jan 2023
download_path="https://github.com/Originate/git-town/releases/download/v7.8.0"

set -x

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "Trying 64 bit amd/intel."
    filename="git-town_7.8.0_linux_intel_64.deb"
    if [[ -x `which dpkg` ]]; then
        if [[ ! -r ${filename} ]]; then
            echo "Downloading ${filename}"
	    curl -O -L "${download_path}/${filename}"
        fi
	sudo dpkg -i ${filename}
    else
	echo "No dpkg.  Giving up."
    fi

elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    echo "Trying linux arm."
    filename="git-town-linux-arm"
    curl -O -L "${download_path}/${filename}"
    chmod +x ${filename}
    sudo cp ${filename} /usr/local/bin/git-town

else
    echo "Git town installer doesn't recognize this OS.  Giving up."
fi

# Remove download if git-town exists now
git_town=$(which git-town)
if [[ -x $git_town ]]; then
    echo "$git_town is executable, deleting download"
    \rm ${filename}
fi
