# Run this Makefile to fix up your .bashrc, .emacs, etc.
# You'll need to log in again to activate the virtual environment, etc.

# For debugging, 'make print-whatever' to see the value of whatever.
print-%: ; @$(error $* is $($*) ($(value $*)) (from $(origin $*)))

#OLD_SHELL := $(SHELL)
#SHELL = $(warning [$@ ($^) ($?)])$(OLD_SHELL)

# See if we have dnf (i.e., RedHat), apt (Debian), or brew (Mac)
DNF := $(shell command -v dnf 2> /dev/null)
# Use ipv4 because I've had some trouble reaching servers via ipv6.
APT := $(shell command -v apt-get -o Acquire::ForceIPv4=true 2> /dev/null)
BREW := $(shell command -v brew 2> /dev/null)
ifdef DNF
    INSTALL_CMD = sudo dnf install -y
endif
ifdef APT
    INSTALL_CMD = sudo apt-get install -y
endif
ifdef BREW
    INSTALL_CMD = brew install
endif
ifndef INSTALL_CMD
    $(error "No install command (brew, apt-get, dnf) found.")
endif


# Installed stuff lives different places on Mac vs. Linux.
UNAME_S := $(shell uname -s)
ARCH := $(shell uname -m)

ifeq ($(UNAME_S),Linux)
    PREFIX = /usr/bin
    CURL = wget
    AGNAME = silversearcher-ag
    AG = /usr/bin/ag
endif

# And on Mac, different places for m1 vs. x86
ifeq ($(UNAME_S),Darwin)
    ifeq ($(ARCH),arm64)
	# m1
	PREFIX = /opt/homebrew/bin
        OS_SPECIFIC_PACKAGES = /opt/homebrew/bin/brew
    else
	# x86
	PREFIX = /usr/local/bin
	OS_SPECIFIC_PACKAGES = /usr/local/bin/brew
    endif
    INSTALL_CMD = brew install
    CURL = curl -L -O
    AGNAME = ag
    AG = $(PREFIX)/ag
endif


PYTHON = $(PREFIX)/python3
PIP = $(PREFIX)/pip3

VIRTUALENV = $(PREFIX)/virtualenv
NMAP = $(PREFIX)/nmap

MY_V = ~/.venvs/3
MY_V_PYTHON = $(MY_V)/bin/python
PYMACS = $(MY_V)/lib/python/site-packages/Pymacs.py
BREW = /opt/homebrew/bin/brew

# What do I think goes in the system python?
# Need pip, setuptools
# Nice to have newest pip

# In my own venv, requests[security], Pygments, stuff for pymacs-rope


# All the dotfiles
dotfiles = aliases bashrc bash_profile emacs.d gitconfig		\
	   gitconfig-dgentry gitconfig-zoetis gitignore lessfilter	\
	   profile screenrc git-completion.bash zshrc oh-my-zsh		\
	   zshenv common

# Move aside (setaside) existing dotfiles in home directory, make symlinks to mine, here.
install : packages_i_want setaside $(dotfiles)
	for file in $(dotfiles); do \
	    ln -s `pwd`/$$file ~/.$$file; \
	done

packages_i_want : $(OS_SPECIFIC_PACKAGES) $(AG) $(PYTHON) $(PIP) \
	$(MY_V_PYTHON) $(PYMACS) curl

$(PIP)    :
$(PYTHON) :
	$(INSTALL_CMD) python3

$(MY_V_PYTHON) : $(VENV)
	$(PYTHON) -m venv $(MY_V)
	echo "Your venv is $(MY_V)"
	echo "You'll want to source $(MY_V)/bin/activate"
install-pymacs.sh:
	echo "Downloading install-pymacs.sh"
	$(CURL) https://github.com/Pymacs2/Pymacs/raw/master/install-pymacs.sh
	chmod +x install-pymacs.sh
$(PYMACS) : $(MY_V_PYTHON) install-pymacs.sh
	echo "Make installing Pymacs in venv"
	. $(MY_V)/bin/activate && python -m pip install --upgrade pip && ./install-pymacs.sh

# We still want curl for login banner, even though we may have used wget above.
curl :
	$(INSTALL_CMD) curl

$(AG):
	$(INSTALL_CMD) $(AGNAME)

$(BREW) :
	./install-brew.sh
$(GIT-TOWN) :
	$(INSTALL_CMD) git-town

DATE=`date +%Y-%m-%d:%H:%M:%S`
.PHONY : setaside
# Set aside real files that we're going to replace with symlinks.
setaside :
	for file in $(dotfiles); do \
	    if [ -L ~/.$$file ]; then \
	        echo "Removing link" .$$file; \
	        rm ~/.$$file; \
	    elif [ -e ~/.$$file ]; then \
	        echo "Moving aside" .$$file ;\
	        mv ~/.$$file ~/.$$file-aside-`date +%S.%N`; \
	    fi \
	done


.PHONY : clean
clean :
	rm -f *~ */*~ install-pymacs.sh *.orig

.PHONY : really-clean
distclean : clean
	for file in $(dotfiles); do \
	  rm -rf ~/.$$file-aside-* Pymacs; \
	done
