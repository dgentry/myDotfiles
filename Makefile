dotfiles = aliases bashrc emacs emacs.d gitconfig gitignore profile screenrc

install : setaside dot-*
	for file in $(dotfiles); do \
	  ln -s `pwd`/dot-$$file ~/.$$file; \
	done
        cd ~/.emacs.d/pymacs && make && make install

.PHONY : setaside
setaside :
	for file in $(dotfiles); do \
	  if [ -f ~/.$$file ]; then \
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

