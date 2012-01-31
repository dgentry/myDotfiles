dotfiles = aliases bashrc emacs emacs.d gitconfig gitignore profile


install: setaside dot-*
	for file in $(dotfiles); do \
	  ln -s `pwd`/dot-$$file ~/.$$file; \
	done

.PHONY: setaside
setaside:
	for file in $(dotfiles); do \
	  mv ~/.$$file ~/.$$file-aside-`date +%S.%N`; \
	done

.PHONY: clean
clean:
	for file in $(dotfiles); do \
	  rm -rf ~/.$$file-aside-*; \
	done
	rm *~
