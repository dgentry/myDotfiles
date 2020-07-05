;;; package -- A big pile of .emacs
;;;
;;; Commentary:
;;;     This commentary is only here to shut up some flychecker thing.
;;; Code:
;;;     Same with this "Code:"

;; This just adds one directory to the path
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'spud)

;; This adds directories recursively
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("elpy" . "http://jorgenschaefer.github.io/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")))
(package-initialize)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Comment out if you've already loaded this package...
(require 'cl)

;; Could probably defer some of this to programming language specific
;; inits (e.g., my-python-programming.el)
(defvar my-packages
  ;; '(ack-and-a-half auctex
  ;;    clojure-mode coffee-mode deft expand-region
  ;;    gist groovy-mode haml-mode haskell-mode inf-ruby
  ;;    magit magithub paredit projectile python
  ;; 	sass-mode rainbow-mode scss-mode solarized-theme
  ;; 		   volatile-highlights yaml-mode yari
  ;; 		   zenburn-theme)
  '(color-theme git yasnippet
		autopair
		flycheck
		elpy flymake-cursor
		markdown-mode
		yaml-mode
		multi-web-mode
;;		spinner spotify sublimity super-save tdd tdd-status-mode-line ten-hundred-mode theme-changer vagrant virtualenv visible-color-code wordsmith-mode writegood-mode writeroom-mode xkcd yafolding zen-mode metar mo-git-blame nose on-screen pydoc reveal-in-osx-finder seclusion-mode selectric-mode sentence-highlight shrink-whitespace sos sourcetalk speech-tagger sphinx-doc bash-completion flymake-shell focus fold-dwim forecast google-maps google-this hide-comnt idle-require jenkins-watch live-py-mode
		;; xterm-color
		)
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
  "Jeebus, the flychecker never shuts up."
  (loop for p in my-packages
	when (not (package-installed-p p)) do (return nil)
	finally (return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; Make the mouse work in emacs and iterm2
(require 'mwheel)
(require 'mouse)
(xterm-mouse-mode t)
(mouse-wheel-mode t)
(global-set-key [mouse-4] 'next-line)
(global-set-key [mouse-5] 'previous-line)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

(require 'yasnippet)  ; From 'packages now
(yas-global-mode 1)

;; For the ChromeOS Edit with Emacs extension
(require 'edit-server)
(edit-server-start)

(define-key global-map "\e+" 'update-time-stamp)

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
;(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; turn on font-lock (syntax highlighting) mode
(global-font-lock-mode t)

;; disable visual feedback on selections, because damn it's annoying.
(setq-default transient-mark-mode nil)

;; always end files with a newline
(setq require-final-newline t)

;; stop at the end of the file instead of just adding lines
(setq next-line-add-newlines nil)

; Deal with whitespace
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Make python, etc.,to  space indents only
(setq indent-tabs-mode nil)
;; This seems to be required for js2 mode (javascript)
(setq-default indent-tabs-mode nil)

;; Get rid of the damn menu bar
(menu-bar-mode -1)

(autoload 'git-status "git" "Entry point into git-status mode." t)

;; git-blame.el
;; this autoload as recommended by git-blame.el comments
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

;(load-file "/home/build/public/google/util/google.el")

(require 'timestomp)
(global-set-key "\C-ct" 'insert-timestomp)

(defun other-window-backward (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (if n
      (other-window (- n))  ;if n is non-nil
    (other-window (- n))))  ;if n is nil

(global-set-key "\C-x\C-p" 'other-window-backward)

(setq load-path (cons "~/.emacs.d/ruby-mode" load-path))
(require 'ruby-mode)

(setq load-path (cons "~/.emacs.d/rails" load-path))
(require 'rails)

(require 'arduino-mode)

;(require 'ess-site)

; Flymake colors for dark background
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-error ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))))
 '(flymake-warning ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold))))
 '(mode-line ((t (:background "#001000" :foreground "brightgreen" :weight bold)))))

(require 'flymake-cursor)

(global-set-key "\C-cn" 'flymake-goto-next-error)
(global-set-key "\C-cp" 'flymake-goto-previous-error)

;(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-startup-indented t)  ; Don't require repetitive stars for sub-trees
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)


; Fix goddamn dark dark blue color in syntax highlighting
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-6.6.0/themes")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-gentrix)
     ;(color-theme-cathode)
     ))

(setq my-color-themes (list
;		       'color-theme-cathode
		       'color-theme-gentrix
		       'color-theme-arjen
		       'color-theme-billw
		       'color-theme-simple-1
		       'color-theme-calm-forest
		       'color-theme-goldenrod
		       'color-theme-clarity
		       'color-theme-comidia
		       'color-theme-jsc-dark
		       'color-theme-dark-green
		       'color-theme-dark-laptop
		       'color-theme-euphoria
		       'color-theme-hober
		       'color-theme-late-night
		       'color-theme-lawrence
		       'color-theme-lethe
		       'color-theme-ld-dark
		       'color-theme-matrix
		       'color-theme-midnight
		       'color-theme-oswald
		       'color-theme-renegade
		       'color-theme-retro-green
		       'color-theme-retro-orange
		       'color-theme-salmon-font-lock
		       'color-theme-subtle-hacker
		       'color-theme-taming-mr-arneson
		       'color-theme-taylor
		       'color-theme-tty-dark
		       'color-theme-pok-wob
		       'color-theme-word-perfect))


(defun my-theme-set-default ()
  "Choose the first row of my-color-themes."
  (interactive)
  (setq theme-current my-color-themes)
  (funcall (car theme-current)))

(defun my-describe-theme ()
  "Describe the current color theme."
  (interactive)
  (message "%s" (car theme-current)))

; Set the next theme
(defun my-theme-cycle ()
  "Cycle to the next color theme."
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
      (setq theme-current my-color-themes))
  (funcall (car theme-current))
  (message "%S" (car theme-current)))

(setq theme-current my-color-themes)
(setq color-theme-is-global nil) ; Initialization
;(my-theme-set-default)
(global-set-key "\C-c," 'my-theme-cycle)

;; -------------- jedi python -----------------
;; Standard el-get setup
;; (See also: https://github.com/dimitri/el-get#basic-setup)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

;; Standard Jedi.el setting
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)

(require 'my-python-setup)

(defun* get-closest-pathname (&optional (file "Makefile"))
  "Determine the pathname of the first instance of FILE starting from the current directory towards root.  This may not do the correct thing in presence of links. If it does not find FILE, then it returns the name of FILE in the current directory, suitable for creation"
    (let ((root (expand-file-name "/"))) ; the win32 builds should translate this correctly
      (expand-file-name file
			(loop
			 for d = default-directory then (expand-file-name ".." d)
			 if (file-exists-p (expand-file-name file d))
			 return d
			 if (equal d root)
			 return nil))))

(require 'compile)
(add-hook 'python-mode-hook
	  (lambda () (set (make-local-variable 'compile-command)
			  (format "cd %s && make -k runrec"
				  (file-name-directory (get-closest-pathname))))))

(add-hook 'after-init-hook #'global-flycheck-mode)

(provide 'emacs)
;;; emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
