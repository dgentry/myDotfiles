#!/bin/bash
#
# Set up HOST (arg 1)
hosts="tinycow.local tiny.zapto.org movies.local crappo.local boof.local"

# Iterate the string variable using for loop
for host in $hosts; do
    echo "Working on $host"
    ssh $host "cd myDotfiles && git pull"
done
