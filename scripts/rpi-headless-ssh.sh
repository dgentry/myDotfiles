#!/bin/bash

echo "This script sets up headless ssh on a new rpi image since late 2022."
echo " "
echo "I need an SD card with a raspbian image on it, mounted somewhere."

candidates=($(ls /Volumes))

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
touch ssh

echo "Writing userconf.txt"
echo "$username:$encrypted" >userconf.txt

echo " "

if [[ "$PWD" == "$c" ]]; then
    echo "You'll need to cd out of $c before unmounting the card."
fi

echo "Unmount the card and see if it works!"
