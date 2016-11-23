# Run this Makefile to fix up your .bashrc, .emacs, etc.

# You'll need to log in again to activate the virtual environment, etc.

# Slightly helpful for debugging
print-%: ; @$(error $* is $($*) ($(value $*)) (from $(origin $*)))

#OLD_SHELL := $(SHELL)
#SHELL = $(warning [$@ ($^) ($?)])$(OLD_SHELL)

# Figure out where emacs, nmap, etc. live
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    # On raspbian
    PREFIX = /usr/bin
    INSTALL_CMD = sudo apt-get install
endif
ifeq ($(UNAME_S),Darwin)
    # On Mac
    PREFIX = /usr/local/bin
    INSTALL_CMD = brew install
#echo "Also going to need Xcode"
endif

PYTHON = $(PREFIX)/python
PIP = $(PREFIX)/pip
VIRTUALENV = $(PREFIX)/virtualenv
EMACS = $(PREFIX)/emacs
NMAP = $(PREFIX)/nmap
GRC = $(PREFIX)/grc
MY_V_PYTHON = ~/.virtualenv/v/bin/python2.7


# What do I think goes in the system python?
# Need pip, setuptools, virtualenv
# Nice to have newest pip, virtualenv

# In my own virtualenv, requests[security], Pygments, stuff for pymacs-rope


# All the dotfiles
dotfiles = aliases bashrc emacs emacs.d gitconfig gitignore lessfilter \
	   profile screenrc git-completion.bash


# Move aside existing dotfiles in home directory, make symlinks to these
install : packages_i_want setaside $(dotfiles)
	for file in $(dotfiles); do \
	  ln -s `pwd`/$$file ~/.$$file; \
	done
	# Don't care if deactivate doesn't work since all that means
	# is that we already weren't in a virtual environment.
	deactivate || true
	sudo -H pip install --upgrade pip setuptools virtualenv Pygments

packages_i_want : $(EMACS) $(NMAP) $(GRC) $(PYTHON) $(PIP) $(VIRTUALENV) $(MY_V_PYTHON)

$(PYTHON) :
	$(INSTALL_CMD) python

$(PIP) : $(PYTHON)
	$(PYTHON) get-pip.py
	$(PIP) install -upgrade pip

$(VIRTUALENV) : $(PIP)
	$(PIP) install --upgrade virtualenv

$(MY_V_PYTHON) : $(VIRTUALENV)
	echo $(VIRTUALENV)
	$(VIRTUALENV) ~/.virtualenv/v
	source ~/.virtualenv/v/bin/activate

$(EMACS) :
	$(INSTALL_CMD) emacs

$(NMAP) :
	$(INSTALL_CMD) nmap

$(GRC) :
	$(INSTALL_CMD) grc


.PHONY : setaside
setaside :
        # Symlinks are OK to delete
	for file in $(dotfiles); do \
	  if [ -h ~/.$$file ]; then \
	    rm ~/.$$file; \
	  fi \
	done
        # Real files should be kept
	for file in $(dotfiles); do \
	  if [ -L ~/.$$file ]; then \
	    echo "Removing link" .$$file; \
	    rm ~/.$$file; \
	  elif [ -f ~/.$$file ]; then \
	    echo "Moving aside" .$$file ;\
	    mv ~/.$$file ~/.$$file-aside-`date +%S.%N`; \
	  fi \
	done


.PHONY : clean
clean :
	rm -f *~ */*~

.PHONY : really-clean
really-clean : clean
	for file in $(dotfiles); do \
	  rm -rf ~/.$$file-aside-*; \
	done
