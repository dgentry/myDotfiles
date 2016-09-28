dotfiles = aliases bashrc emacs emacs.d gitconfig gitignore lessfilter \
	   profile screenrc git-completion.bash

# Move aside existing dotfiles in home directory, make symlinks to these
install : system_packages setaside $(dotfiles) pip
	for file in $(dotfiles); do \
	  ln -s `pwd`/$$file ~/.$$file; \
	done
	sudo -H pip install requests[security]
	sudo -H pip install --upgrade Pygments

pip : /usr/local/bin/pip

/usr/local/bin/pip :
	sudo -H python get-pip.py

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

NEW_PYTHON = $(PREFIX)/python
EMACS = $(PREFIX)/emacs
NMAP = $(PREFIX)/nmap
GRC = $(PREFIX)/grc

system_packages : $(EMACS) $(NMAP) $(GRC)

$(EMACS) :
	$(INSTALL_CMD) emacs

$(NMAP) :
	$(INSTALL_CMD) nmap

$(GRC) : /usr/local/bin/python
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
