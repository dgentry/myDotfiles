dotfiles = aliases bashrc emacs emacs.d gitconfig gitignore profile screenrc

install : setaside $(dotfiles)
	for file in $(dotfiles); do \
	  ln -s `pwd`/$$file ~/.$$file; \
	done
	sudo python /usr/local/bin/easy_install pymacs

.PHONY : setaside
setaside :
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
