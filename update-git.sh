#!/usr/bin/env bash

# Install a modern git from source.  Ubuntu 20.04 LTS is shipping git
# 2.25 from Jan 2020, and 2.43 from Nov 2023 is available.

set -e

source $(which msg.sh)
if which git > /dev/null; then
    git_version=$(git version | grep -oP '[0-9].[0-9][0-9].[0-9]')
    if [[ $git_version == "2.43.0" ]]; then
        msg "Git is already version 2.43.0, skipping install"
        exit
    fi
fi

version=2.43.0
tarball=v2.43.0.tar.gz
tarball_url=https://github.com/git/git/archive/refs/tags/$tarball

msg "Installing Git $version"

msg "First the dependencies:"

# The documentation dependencies make the downloads/installs larger
# (probably 0.5 GB installed), so we could skip the stuff after
# asciidoc if disk space is tight.
sudo apt-get install -y dh-autoreconf libcurl4-gnutls-dev \
     libexpat1-dev gettext libz-dev libssl-dev asciidoc xmlto docbook2x \
     install-info

if [[ ! -d git-$version ]]; then
    if [[ ! -f $tarball ]]; then
        msg "Fetching git source tarball"
        if ! curl -L -O $tarball_url; then
            exit 1
        fi
    fi
    msg "Expand it"
    tar xfBpz $tarball
fi
msg "cd into the source dir"
pushd git-$version

msg "PWD is $PWD"
if [[ "$PWD" != *git-$version ]]; then
    msg "Apparently we aren't in the source directory."
    msg "Giving up."
    exit 1
fi

msg "That apparently worked, so let's uninstall ubuntu's git"
sudo apt remove -y --purge git
sudo apt autoremove -y

msg "Configure."
make configure
./configure --prefix=/usr

msg "Build and install docs.  This could take a couple of minutes."
msg "Redirecting errors into make-git.log"
if make -j$(nproc) all doc info &> make-git.log; then
    msg "Make status was OK"
else
    msg "Make exited with an error, examine make-git.log for details."
    msg "Continuing."
fi

msg "Installing"
sudo make -j$(nproc) install install-doc

msg "Removing source dir git-$version"
popd
sudo rm -rf git-$version

msg "Leaving tarball"

msg "Done."
