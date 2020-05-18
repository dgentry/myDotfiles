#!/bin/bash

# echo "Take care.  Supposedly you can corrupt your system by removing some ACLs."
# echo "This will recursively remove all ACLS from ${PWD} and set ownership to ${USER}."
# echo "In 3. . ."
# sleep 1
# echo "2. . ."
# sleep 1
# echo "1. . ."
# sleep 1
# echo "Go."
# sleep 1

#
# Here are ways files can be hard to operate on:
# 1. There are ACLs that prohibit you from doing stuff
# 2. They have weird flags
# 3. They have weird extended attributes
# 4. They are symlinks that point nowhere (and which can have the preceding issues too)
# 5. You don't own them

# Let's fix 1 (including for symlinks):
# ls -Rle shows ACLs
#echo "Counting ACLs."
#COUNT=$(ls -Rle | grep ' [0-9]:' | wc -l)
#echo "Got ${COUNT}."

# remove all ACLs recursively from all files in your current dir
#sudo chmod -v -RN .
# And symlinks
#sudo find . -type s -exec chmod -v -h -N {} \;

#echo "Counting ACLs again"
#COUNT=$(ls -Rle | grep ' [0-9]:' | wc -l)
#echo "Got ${COUNT} after."

set -x

FLAG_COUNT=$(ls -laRO . | cut -c 30- | tee /tmp/mrgrgl | grep 'arch\|archived\|opaque\|nodump\|sappnd\|sappend\|schg\|schange\|simmutable\|uappnd\|uappend\|ugch\|uchange\|uimmutable\|hidden' | wc -l)
echo "Flag count is ${FLAG_COUNT}."

exit 0

# Flags are displayed with:
# ls -laO /Volumes/my-volume
# ls -e shows ACLs
# ls -Rle .

# Flags can be removed recursively with:
sudo chflags -v -R nouchg,nouappnd,noopaque,dump .

# Clear extended attributes
sudo xattr -rc .
# Also for symlinks
sudo xattr -rcs .

# recursively change ownership of files to you.
sudo chown -R $(whoami) .
