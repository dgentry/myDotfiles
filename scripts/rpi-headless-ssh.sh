#!/bin/bash

echo "This script copies a raspbian image to an SD card."

srcimg=~/Downloads/2023-10-10-raspios-bookworm-arm64-full.img.xz
if [[ ! -f "$srcimg" ]]; then
    echo "Don't have an image ($srcimg) to write.  Edit me and try again."
    exit
fi

candidates=($(ls /Volumes))
for c in "${candidates[@]}"; do
    echo "Candidate $c"
    useme="/Volumes/$c"
    if [[ "$c" == "Untitled" ]]; then
        diskutil info $useme
        read -p "Use this card? " thiscard
        if [[ "$thiscard" == 'y' ]]; then
            break
        fi
    fi
    if [[ -x "$useme/kernel8.img" ]]; then
        echo "Found a likely raspbian card at $useme"
        break
    fi
    useme=""
done

if [[ -z "$useme" ]]; then
    echo "Didn't find a raspbian card."
    exit 1
fi

partition=$(diskutil info $useme | grep 'Device Identifier' | tr -s ' ' | cut -f4 -d' ')
device=$(echo $partition | grep -oh 'disk[0-9]*')
fulldevice=/dev/r$device

if [[ $(diskutil unmountDisk $fulldevice) ]]; then
    echo "Unmounted $fulldevice OK"
else
    echo "Wasn't able to unmount $fulldevice.  Exiting."
    exit
fi


echo "Writing $srcimg to $fulldevice"
unxz <~/Downloads/2023-10-10-raspios-bookworm-arm64-full.img.xz | sudo dd of=$fulldevice bs=1m status=progress

tput bel
sleep 1
tput bel
sleep 1
tpub bel

echo "Now to set up headless ssh"
echo " "
echo "I need an SD card with a raspbian image on it, mounted somewhere."

candidates=($(ls /Volumes))

useme=""
for c in "${candidates[@]}"; do
    echo "Candidate $c"
    useme="/Volumes/$c"
    if [[ -x "$useme/kernel8.img" ]]; then
        echo "Found a likely raspbian card at $useme"
        break
    fi
    useme=""
done

if [[ -z "$useme" ]]; then
    echo "Didn't find a raspbian card."
    exit 1
fi


echo "Setting up username/password and ssh on $c"

set -e
if [[ -z "$1" ]]; then
    read -r -p "Username for new user: " username
else
    username=$1
fi

if [[ -z "$2" ]]; then
    read -s -r -p "Password for that user: " password
    echo " "
else
    password=$2
fi
encrypted=$(echo "$password" | openssl passwd -6 -stdin)

echo " "
echo "Enabling ssh"
touch $useme/ssh

echo "Writing userconf.txt"
echo "$username:$encrypted" >$useme/userconf.txt

echo " "

if [[ "$PWD" == "$c" ]]; then
    echo "You'll need to cd out of $c before unmounting the card."
fi

diskutil unmountDisk $useme
echo "Unmount the card and see if it works!"
