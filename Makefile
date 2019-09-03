# Run this Makefile to fix up your .bashrc, .emacs, etc.
# You'll need to log in again to activate the virtual environment, etc.

# For debugging, 'make print-whatever' to see the value of whatever.
print-%: ; @$(error $* is $($*) ($(value $*)) (from $(origin $*)))

#OLD_SHELL := $(SHELL)
#SHELL = $(warning [$@ ($^) ($?)])$(OLD_SHELL)

# See if we have dnf (i.e., RedHat), apt (Debian), or brew (Mac)
DNF := $(shell command -v dnf 2> /dev/null)
APT := $(shell command -v apt-get 2> /dev/null)
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
ifeq ($(UNAME_S),Linux)
    PREFIX = /usr/bin
    CURL = wget
    AGNAME = silversearcher-ag
    AG = /usr/bin/ag
    $(INSTALL_CMD) python-setuptools
endif
ifeq ($(UNAME_S),Darwin)
    # On Mac
    PREFIX = /usr/local/bin
    INSTALL_CMD = brew install
    CURL = curl -L -O
    OS_SPECIFIC_PACKAGES = /usr/local/bin/brew
    AGNAME = ag
    AG = $(PREFIX)/ag
endif

PYTHON = $(PREFIX)/python3

VIRTUALENV = $(PREFIX)/virtualenv
EMACS = $(PREFIX)/emacs
NMAP = $(PREFIX)/nmap
GRC = $(PREFIX)/grc
# Apparently dc is not included by default in Ubuntu 17.04
DC = $(PREFIX)/dc

MY_V = ~/.virtualenv/3
MY_V_PYTHON = $(MY_V)/bin/python
PYMACS = $(MY_V)/lib/python/site-packages/Pymacs.py
DC = /usr/bin/dc
BREW = /usr/local/bin/brew

# What do I think goes in the system python?
# Need pip, setuptools, virtualenv
# Nice to have newest pip, virtualenv

# In my own virtualenv, requests[security], Pygments, stuff for pymacs-rope


# All the dotfiles
dotfiles = aliases bashrc emacs.d gitconfig gitignore lessfilter \
	   profile screenrc git-completion.bash

# Move aside (setaside) existing dotfiles in home directory, make symlinks to mine, here.
install : packages_i_want setaside $(dotfiles)
	for file in $(dotfiles); do \
	    ln -s `pwd`/$$file ~/.$$file; \
	done
	# Don't care if deactivate doesn't work since all that means
	# is that we already weren't in a virtual environment.
	deactivate || true
	sudo -H $(PYTHON) -m pip install --upgrade pip setuptools virtualenv Pygments

packages_i_want : $(OS_SPECIFIC_PACKAGES) $(EMACS) $(NMAP) $(AG) $(GRC) $(PYTHON) $(PIP) \
	 $(VIRTUALENV) $(MY_V_PYTHON) $(PYMACS) $(DC)

$(PYTHON) :
	$(INSTALL_CMD) python@3
$(VIRTUALENV) : $(PIP)
	sudo -H $(PYTHON) -m pip install --upgrade virtualenv
$(MY_V_PYTHON) : $(VIRTUALENV)
	echo "Virtualenv is $(VIRTUALENV)"
	$(VIRTUALENV) $(MY_V)
	echo "You'll want to source $(MY_V)/bin/activate"
install-pymacs.sh:
	$(CURL) https://github.com/dgentry/Pymacs/raw/master/install-pymacs.sh
	chmod +x install-pymacs.sh
$(PYMACS) : $(MY_V_PYTHON) install-pymacs.sh
	echo "Make installing Pymacs"
	. $(MY_V)/bin/activate && ./install-pymacs.sh

$(EMACS) :
	$(INSTALL_CMD) emacs

$(AG):
	$(INSTALL_CMD) $(AGNAME)

$(NMAP) :
	$(INSTALL_CMD) nmap

$(GRC) :
	$(INSTALL_CMD) grc
# The bc package gets you dc, at least on Fedora
$(DC) :
	$(INSTALL_CMD) bc

$(BREW) :
	./install_brew.sh
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
