dotfiles = aliases bashrc emacs emacs.d gitconfig gitignore lessfilter \
	   profile screenrc

install : setaside $(dotfiles) emacs.d/pinard-Pymacs-5989046 pip
	for file in $(dotfiles); do \
	  ln -s `pwd`/$$file ~/.$$file; \
	done
	sudo -H pip install requests[security]
	sudo -H pip install --upgrade Pygments

pip : /usr/local/bin/pip
	sudo -H pip install -U pip

emacs.d/pinard-Pymacs-5989046:
	pushd emacs.d && \
	curl -O https://codeload.github.com/pinard/Pymacs/legacy.zip/v0.25 && \
	tar xf v0.25 && rm v0.25 && \
	cd pinard-Pymacs-5989046 && \
	make check && \
	make install && \
	popd




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
