#!/bin/bash

# Install brew ("homebrew") for MacOS.
# If necessary, install Xcode or the Command Line tools first.

# So this can run by double-clicking this script, identify its path.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  # if $SOURCE was a relative symlink, we need to resolve it relative
  # to the path where the symlink file was located
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

my_long_name=$0  # Something like "./install-brew.sh"
annoying_prefix="./"
myname=${my_long_name#$annoying_prefix}  # Now just "install-brew.sh"


GCC=/usr/bin/gcc
BREW=/opt/homebrew/bin/brew

# Variables for colors/contrast
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}

name="$(uname)"
if [ $name != "Darwin" ]; then
    echo "Brew is only for macs.  You want apt-get or something."
    exit
fi

# Provide our messages with our name, and contrast to the other
# install messages that will be going by
msg() {
    echo "$bldblu${myname}: $1${txtrst}"
}

while [ ! -x "${GCC}" ]; do
    msg "Don't see an executable ${GCC}; trying to install xcode or xcode command line tools"
    git --version >& /dev/null  # This should trigger the UI to offer to do an xcode/clt install
done

# Install homebrew
while [ ! -x "${BREW}" ]; do
    msg "Don't see an executable ${BREW}; trying to install homebrew."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
done

# The extra cat is to keep brew from complaining
VERSION=$( brew --version | cat | head -1 )
msg "${VERSION} is installed."
