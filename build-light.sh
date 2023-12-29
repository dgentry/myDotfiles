#!/bin/bash

light=/dev/ttyACM0

# Only do stuff on auclyoctop01 and only if the build light is present
if [[ $(hostname) != "auclyoctop01" ]]; then
    echo "Not on primary builder"
    exit 0
elif [[ ! -c $light ]]; then
    echo "$light isn't a character device."
elif [[ ! -w $light ]]; then
    echo "$light isn't writable."
fi


# Here are all the chars that it echoed:
# a -
# b - blue
# c - light blue (cyan?)
# g - green
# m - light purple
# o - orange
# r - red
# w - white
# x - blipping up white
# y - yellow
# z - rainbow

echo "Sending $1 to $light"
echo $1 >$light
