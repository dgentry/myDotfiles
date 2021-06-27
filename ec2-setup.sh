#
# Source this file
#
#ssh ubuntu@54.226.117.61 'mkdir .ssh'
scp ~/.ssh/Instance1.pem ubuntu@54.226.117.61:
alias foo='ssh -i ~/.ssh/Instance1.pem ubuntu@54.226.117.61'
foo sudo adduser -u 501 gentry
foo sudo usermod -a -G admin gentry
foo 'sudo mkdir ~gentry/.ssh'
foo 'sudo cp .ssh/authorized_keys ~gentry/.ssh/'
foo 'sudo chown -R gentry.gentry ~gentry'
alias bar='ssh -i ~/.ssh/Instance1.pem 54.226.117.61'

sudo apt-get install git make
git clone https://github.com/dgentry/myDotfiles
cd myDotfiles
make

sudo apt-get install unity vnc4server firefox
cd .vnc
x-window-manager
mv xstartup xstartup.aside
cat >xstartup.aside
33  cat xstartup.aside
chmod +x xstartup
vncs
cat *.log
