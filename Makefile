# Run this Makefile to fix up your .bashrc, .emacs, etc.
# You'll need to log in again to activate the virtual environment, etc.

# Slightly helpful for debugging.  'make print-whatever' to see the value of whatever.
print-%: ; @$(error $* is $($*) ($(value $*)) (from $(origin $*)))

#OLD_SHELL := $(SHELL)
#SHELL = $(warning [$@ ($^) ($?)])$(OLD_SHELL)

# Figure out where emacs, nmap, etc. live
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    PREFIX = /usr/bin
    PIPFIX = /usr/local/bin
    VE_PREFIX = /usr/local/bin
    INSTALL_CMD = sudo apt-get install -y
    CURL=wget
endif
ifeq ($(UNAME_S),Darwin)
    # On Mac
    PREFIX = /usr/local/bin
    VE_PREFIX = /usr/local/bin
    PIPFIX = /usr/local/lib/python2.7/site-packages
    INSTALL_CMD = brew install
    CURL=curl -L -O
#echo "Also going to need Xcode"
endif

PYTHON = $(PREFIX)/python
PIP = $(PIPFIX)/pip
VIRTUALENV = $(VE_PREFIX)/virtualenv
EMACS = $(PREFIX)/emacs
NMAP = $(PREFIX)/nmap
GRC = $(PREFIX)/grc
# Apparently dc is not included by default in Ubuntu 17.04
DC = $(PREFIX)/dc
MY_V = ~/.virtualenv/v
MY_V_PYTHON = $(MY_V)/bin/python2.7
PYMACS = $(MY_V)/lib/python2.7/site-packages/Pymacs.py
DC = /usr/bin/dc

# What do I think goes in the system python?
# Need pip, setuptools, virtualenv
# Nice to have newest pip, virtualenv

# In my own virtualenv, requests[security], Pygments, stuff for pymacs-rope


# All the dotfiles
dotfiles = aliases bashrc emacs.d gitconfig gitignore lessfilter \
	   profile screenrc git-completion.bash

# Move aside (setaside) existing dotfiles in home directory, make symlinks to the mine, here.
install : packages_i_want setaside $(dotfiles)
	for file in $(dotfiles); do \
	    ln -s `pwd`/$$file ~/.$$file; \
	done
	# Don't care if deactivate doesn't work since all that means
	# is that we already weren't in a virtual environment.
	deactivate || true
	sudo -H $(PYTHON) -m pip install --upgrade pip setuptools virtualenv Pygments

packages_i_want : $(EMACS) $(NMAP) $(GRC) $(PYTHON) $(PIP) $(VIRTUALENV) $(MY_V_PYTHON) \
	$(PYMACS) $(DC)

$(PYTHON) :
	$(INSTALL_CMD) python

$(PIP) : $(PYTHON)
	echo "python is $(PYTHON), pip is $(PIP)"
	sudo -H $(PYTHON) get-pip.py
	sudo -H $(PYTHON) -m pip install --upgrade pip

$(VIRTUALENV) : $(PIP)
	sudo -H $(PYTHON) -m pip install --upgrade virtualenv

$(MY_V_PYTHON) : $(VIRTUALENV)
	echo $(VIRTUALENV)
	$(VIRTUALENV) ~/.virtualenv/v
	echo "You'll want to source ~/.virtualenv/v/bin/activate"

install-pymacs.sh:
	$(CURL) https://github.com/dgentry/Pymacs/raw/master/install-pymacs.sh
	chmod +x install-pymacs.sh

$(PYMACS) : $(MY_V_PYTHON) install-pymacs.sh
	echo "Installing Pymacs"
	./install-pymacs.sh

$(EMACS) :
	$(INSTALL_CMD) emacs-nox

$(NMAP) :
	$(INSTALL_CMD) nmap

$(GRC) :
	$(INSTALL_CMD) grc

$(DC) :
	$(INSTALL_CMD) dc


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
	rm -f *~ */*~ install-pymacs.sh

.PHONY : really-clean
distclean : clean
	for file in $(dotfiles); do \
	  rm -rf ~/.$$file-aside-* Pymacs; \
	done
