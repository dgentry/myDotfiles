#!/bin/bash

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

my_long_name=$0  # Something like "./setup.sh"
annoying_prefix="./"
myname=${my_long_name#$annoying_prefix}  # Now just "setup.sh"

# Terminal colors/contrast
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
wht=$(tput setaf 7)             # plain white
bldred=${txtbld}$(tput setaf 1) #  red
bldblu=${txtbld}$(tput setaf 4) #  blue
bldwht=${txtbld}${wht}          #  white
txtrst=$(tput sgr0)             # Reset

# Provide our messages with our name in a contrasting color from the
# other install messages
msg() {
    echo "$bldblu${myname}: $1${txtrst}"
}


msg "Setting up this system for RDDX builds."

# What am I?
name="$(uname)"
if [ $name != "Linux" ]; then
    msg "Not really set up for non-Linux ($name) installs.  Exiting."
    exit 1
fi

msg "I'm some kind of Unix."
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ]; then
    msg "Running on Intel/AMD 64 bit hardware"
elif [ "${arch_name}" = "arm64" ]; then
    msg "Running on arm64"
else
    msg "on an unknown architecture, ${arch_name}.  Bye."
    exit 1
fi

# Make a .bash_completion directory
BASHCOMP=~/.bash_completion.d
if ! [[ -d "$BASHCOMP" ]]; then
    # If this ever turns out to be a symlink (which it could), add the -L check.
    mkdir "$BASHCOMP"
fi

# Symlink .git_completion if necessary
GITCOMP=git-completion.bash
BCSCRIPT=$BASHCOMP/$GITCOMP
if ! [ -L $BCSCRIPT ]; then
    msg "Setting up git completion for bash"
    ln -s $PWD/$GITCOMP $BCSCRIPT
fi

# Turn off pager behavior for git
git config --global pager.branch false

export LANGUAGE=en_US.utf8
export LANG=en_US.utf8
export LC_ALL=en_US.utf8
LOCALES="$(localedef --list-archive /usr/lib/locale/locale-archive)"
# Is en_US.utf8 in LOCALES?
if [[ "$LOCALES" == *"$LC_ALL"* ]]; then
    msg "We already have locale $LC_ALL"
else
    msg "A bunch of packages complain about locale problems on Ubuntu and Debian, so:"
    sudo locale-gen en_US.utf8
fi

if [[ -x /opt/scripts/tools/grow_partition.sh ]]; then
    msg "Expanding filesystem"
    cd /opt/scripts/tools/
    git pull || true
    sudo ./grow_partition.sh
    msg "Please reboot ASAP.  Partitions have changed."
fi

msg "Updating package lists"
sudo apt-get update

msg "Installing python 3 pip and venv"
sudo apt-get install -y python3 python3-pip python3-venv python3-pexpect python3-all-dev

msg "Installing apt-file"
sudo apt-get install -y apt-file

msg "Spinning off apt-file update, output to apt-file.log."
sudo apt-file update 2>&1 >> apt-file.log &

msg "Installing figlet and lolcat"
sudo apt-get install -y figlet lolcat

msg "Installing emacs, nmap, ag, grc, and curl"
sudo apt-get install -y emacs-nox nmap silversearcher-ag grc curl

msg "Installing bmon, htop, iotop, net-tools, geany, and openssh-server"
sudo apt-get install -y bmon htop iotop net-tools geany openssh-server
msg "Installing Yocto dependencies"
sudo apt-get install gawk wget git diffstat unzip texinfo gcc build-essential \
     chrpath socat cpio xz-utils debianutils iputils-ping xterm \
     python3-git python3-jinja2 pylint3 python3-subunit \
     libegl1-mesa libsdl1.2-dev xterm mesa-common-dev

if [[ -x /usr/bin/google-chrome ]]; then
    msg "Google Chrome is already installed."
else
    msg "Installing Google Chrome"
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
fi

if [ -x `which gsettings` " " ]; then
   msg "Turning off window-maximize when it hits the top bar"
   gsettings set org.gnome.mutter edge-tiling false
fi

msg "Fetching GNU Emacs Package Repo keys (valid in 2021 at least)"
GNUPG_DIR=$HOME/.emacs.d/elpa/gnupg
mkdir -p $GNUPG_DIR
chmod go-rwx $GNUPG_DIR
gpg --homedir $GNUPG_DIR --receive-keys 066DAFCB81E42C40

# Make this stand out from the clutter a bit
echo ""
# Run this for the return status
if (systemctl status xrdp 2>&1 > /dev/null); then
    msg "Looks like Remote Desktop is already set up."
else
    msg "Setting up Remote Desktop"
    sudo apt-get install xrdp
    sudo adduser xrdp ssl-cert
    sudo systemctl restart xrdp
fi
msg "Your IP address (for Remote Desktop) is $(hostname -I)"
echo ""

msg "Done"
