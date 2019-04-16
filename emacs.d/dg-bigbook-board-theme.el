(deftheme dg-bigbook-board
  "Created 2019-04-15.")

(custom-theme-set-variables
 'dg-bigbook-board
 '(elpy-rpc-python-command "python3")
 '(python-fill-docstring-style (quote pep-257-nn))
 '(package-selected-packages (quote (ox-reveal exec-path-from-shell org-plus-contrib org lv flycheck-pony ponylang-mode all-the-icons yaml-mode yafolding xterm-color xkcd writeroom-mode writegood-mode wordsmith-mode virtualenv vagrant use-package theme-changer tdd-status-mode-line super-save sublimity spotify spinner sphinx-doc speech-tagger sos smart-compile shrink-whitespace selectric-mode seclusion-mode reveal-in-osx-finder pydoc on-screen nose multiple-cursors metar markdown-mode magit live-py-mode jedi-direx ivy-xref ivy-rtags idle-require hl-sentence google-this google-maps forecast fold-dwim focus flymake-shell flycheck elpy elm-mode dumb-jump doom-modeline diminish csharp-mode counsel-projectile bash-completion autopair auto-package-update ag ace-window ac-inf-ruby ac-capf))))

(custom-theme-set-faces
 'dg-bigbook-board
 '(flymake-error ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))))
 '(flymake-warning ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold)))))

(provide-theme 'dg-bigbook-board)
