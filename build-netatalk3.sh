#!/bin/bash -x

set -e

# This gist gives instructions to build a basic deb package of
# netatalk-3.1.11 using checkinstall on Ubuntu 18.04.  The idea is
# that you build the deb on your build server and install from the
# resulting deb in production.  Given that the deb is packaged using
# checkinstall with basic options, think home use, not real
# production.

# Note that this build does not provide the spotlight feature.  The
# tracker packages have been left out as the intent was to provide
# TimeMachine functionality only.

#
# Parameters for build and install
#

# Current as of Jan 2020
NETATALK_VERSION='3.1.12'
ARCH=$(dpkg --print-architecture)
DEB=netatalk3_${NETATALK_VERSION}-1_${ARCH}.deb
MAINTAINER='dennis.gentry@gmail.com'

# The one true netatalk3 config file.
AFP_CONF=/usr/local/etc/afp.conf

# Where your time machine backups should go:
TIMEMACHINE_PATH='/media/gentry/mybook'
# The user making them
VALID_USER='gentry'


#------------------------------------------------------------
# STEP ONE - Make the Netatalk deb on a build machine
#------------------------------------------------------------

echo "Deb is $DEB."

if [ ! -f $DEB ]; then
    echo "It isn't already here, so building it."
    
    sudo apt install --yes \
	 build-essential \
	 libevent-dev \
	 libssl-dev \
	 libgcrypt20-dev \
	 libkrb5-dev \
	 libpam0g-dev \
	 libwrap0-dev \
	 libdb-dev \
	 libtdb-dev \
	 avahi-daemon \
	 libavahi-client-dev \
	 libacl1-dev \
	 libldap2-dev \
	 libcrack2-dev \
	 systemtap-sdt-dev \
	 libdbus-1-dev \
	 libdbus-glib-1-dev \
	 libglib2.0-dev \
	 libio-socket-inet6-perl \
	 tracker  \
	 libtracker-sparql-2.0-dev \
	 libtracker-miner-2.0-dev

    TARBALL=netatalk-${NETATALK_VERSION}.tar.gz
    cd /tmp
    if [ -r $TARBALL ]; then
	SHA=$(sha256sum $TARBALL)
	echo "Local checksum is $SHA"
	# Should probably only save checksum after success at the end of the build
	echo "$SHA" >$TARBALL.sha
    else
	wget http://prdownloads.sourceforge.net/netatalk/netatalk-${NETATALK_VERSION}.tar.gz
    fi
    tar xzf $TARBALL
    cd netatalk-${NETATALK_VERSION}


    ./configure \
	--with-init-style=debian-systemd \
	--without-libevent \
	--with-cracklib \
	--enable-krbV-uam \
	--with-pam-confdir=/etc/pam.d \
	--with-dbus-daemon=/usr/bin/dbus-daemon \
	--with-dbus-sysconf-dir=/etc/dbus-1/system.d \
	--with-tracker-pkgconfig-version=2.0

    time make -j8

    sudo apt install --yes checkinstall

    sudo checkinstall -D \
    --pkgname='netatalk3' \
    --pkgversion="${NETATALK_VERSION}" \
    --maintainer="${MAINTAINER}" \
    --replaces='netatalk' \
    make install

    echo "Copying .debs to $HOME"
    OBSERVED_PKG=($echo netatalk*.deb)
    echo "Observed: $OBSERVED_PKG."
    echo "DEBNAME: $DEB."
    ls -lh /tmp/netatalk*/netatalk*.deb
    cp -v /tmp/netatalk*/netatalk*.deb $HOME
    cd $HOME
    #echo "Removing build dir"
    #sudo rm -rf /tmp/netatalk*
fi

#------------------------------------------------------------
# STEP TWO - Install the Netatalk deb on a production server
#------------------------------------------------------------

echo " "
echo "Install netatalk deb."
echo " "

if [ ! -f $DEB ]; then
    echo "NO .deb to install.  Did the build fail?"
    exit 1
fi

sudo mkdir -p $TIMEMACHINE_PATH
sudo chown -R $VALID_USER:$VALID_USER $TIMEMACHINE_PATH

# Manually install netatalk_3 dependencies. 
sudo apt install --yes \
     avahi-daemon \
     cracklib-runtime \
     db-util \
     db5.3-util \
     libtdb1 \
     libavahi-client3 \
     libcrack2 \
     libcups2 \
     libpam-cracklib \
     libdbus-glib-1-2

sudo dpkg -i $DEB

sudo ldconfig

if [ -f /etc/afp.conf ]; then
    DATE=$(date -u +"%FT%H%M%SZ")
    sudo mv /usr/local/etc/afp.conf /usr/local/etc/afp.conf.$DATE
fi

echo "[Global]
mimic model = TimeCapsule6,106
log level = default:warn
log file = /var/log/afpd.log
spotlight = yes


[TimeMachine]
path = ${TIMEMACHINE_PATH}
valid users = ${VALID_USER}
time machine = yes
# spotlight is useless and wasteful on time machine
spotlight = no
vol size limit = 1430512" | sudo tee $AFP_CONF

echo "Setting netatalk to start on boot"
sudo systemctl enable netatalk
sudo systemctl daemon-reload

echo "Starting netatalk"
sudo systemctl start netatalk

echo "Is it running?"
systemctl status avahi-daemon
systemctl status netatalk

echo "Check netatalk and afpd:"
/usr/local/sbin/netatalk -V
/usr/local/sbin/afpd -V

# EOF
