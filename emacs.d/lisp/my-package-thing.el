;;; my-package-thing -- Summary

;;; Code:

;;; Commentary:
;; Could probably defer some of this to programming language specific
;; inits (e.g., my-python-programming.el)
;;(defvar my-packages
;;  '(yasnippet
;;		autopair
;;		flycheck
;;		elpy flymake-cursor
;;		markdown-mode
;;		yaml-mode
;;		multi-web-mode
  ;; '(ack-and-a-half auctex
  ;;    clojure-mode coffee-mode deft expand-region
  ;;    gist haml-mode haskell-mode inf-ruby
  ;;    magit magithub paredit projectile python
  ;; 	sass-mode rainbow-mode scss-mode solarized-theme
  ;; 		   volatile-highlights yaml-mode yari
  ;; 		   zenburn-theme
;;		spinner spotify sublimity super-save tdd tdd-status-mode-line ten-hundred-mode theme-changer vagrant virtualenv visible-color-code wordsmith-mode writegood-mode writeroom-mode xkcd yafolding zen-mode metar mo-git-blame nose on-screen pydoc reveal-in-osx-finder seclusion-mode selectric-mode sentence-highlight shrink-whitespace sos sourcetalk speech-tagger sphinx-doc bash-completion flymake-shell focus fold-dwim forecast google-maps google-this hide-comnt idle-require jenkins-watch live-py-mode
		;; xterm-color
;;		)
;;  "A list of packages to ensure are installed at launch.")

;(defun my-packages-installed-p ()
;  "Jeebus, the flychecker never shuts up."
;  (loop for p in my-packages
;	when (not (package-installed-p p)) do (return nil)
;	finally (return t)))

;(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
;  (package-refresh-contents)
  ;; install the missing packages
;  (dolist (p my-packages)
;    (when (not (package-installed-p p))
;      (package-install p))))

(provide 'my-package-thing)
;;; my-package-thing ends here
