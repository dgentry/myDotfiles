dotfiles = aliases bashrc emacs emacs.d gitconfig gitignore lessfilter \
	   profile screenrc

install : setaside $(dotfiles)
	for file in $(dotfiles); do \
	  ln -s `pwd`/$$file ~/.$$file; \
	done
	sudo -H pip install requests[security]
	sudo -H pip install --upgrade Pygments

pip : /usr/local/bin/pip
	sudo -H pip install -U pip



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
