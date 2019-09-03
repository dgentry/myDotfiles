sudo apt install -y git make 
scp -rp ssh.surlycat.com:.ssh .
git clone git@github.com:dgentry/myDotfiles
cd myDotfiles
make
