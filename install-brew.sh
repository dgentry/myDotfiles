#!/bin/bash

GCC=/usr/bin/gcc
BREW=/usr/local/bin/brew
BREW_INSTALL_URL=https://raw.githubusercontent.com/Homebrew/install/master/install

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

my_long_name=$0  # Something like "./setup-dotfiles.sh"
annoying_prefix="./"
myname=${my_long_name#$annoying_prefix}  # Now just "setup-dotfiles.sh"

# Provide our messages with our name, and contrast to the other
# install messages that will be going by
msg() {
    echo "$bldblu${myname}: $1${txtrst}"
}

# So this can run by double-clicking this script, identify the path
# where the run script lives.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  # if $SOURCE was a relative symlink, we need to resolve it relative
  # to the path where the symlink file was located
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

while [ ! -x "${GCC}" ]; do
    msg "Don't see an executable ${GCC}; trying to install xcode or xcode command line tools"
    git --version >& /dev/null  # This should trigger the UI to offer to do an xcode/clt install
done

# Install homebrew
while [ ! -x "${BREW}" ]; do
    msg "Don't see an executable ${BREW}; trying to install homebrew."
    /usr/bin/ruby -e "$(curl -fsSL ${BREW_INSTALL_URL})"
done

VERSION=`brew --version | head -1`
msg "${VERSION} is installed."
