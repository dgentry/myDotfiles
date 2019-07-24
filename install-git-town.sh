!#/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "Trying 64 bit amd."
    if [[ -x `which dpkg` ]]; then
	curl -O -L https://github.com/Originate/git-town/releases/download/v7.2.1/git-town-amd64.deb
	sudo dpkg -i git-town-amd64.deb
    else
	echo "No dpkg.  Giving up."
    fi
    
elif [[ "$OSTYPE" == "linux-gnueabihf" ]]; then
    echo "Trying linux arm."
    curl -O -L https://github.com/Originate/git-town/releases/download/v7.2.1/git-town-linux-arm
    chmod +x git-town-linux-arm
    sudo cp git-town-linux-arm /usr/local/bin/git-town
fi
