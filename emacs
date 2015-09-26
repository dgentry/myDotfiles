;; -*-emacs-lisp-*-

;; (normal-top-level-add-to-load-path ~/.emacs.d)

(setq load-path (cons "~/.emacs.d/lisp" load-path))

(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(require 'spud)

(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")))

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;; Comment out if you've already loaded this package...
(require 'cl)

(defvar my-packages
  ;; '(ack-and-a-half auctex
  ;; 		   color-theme
  ;; 		   clojure-mode coffee-mode deft expand-region
  ;; 		   git git-blame
  ;; 		   gist groovy-mode haml-mode haskell-mode inf-ruby
  ;; 		   magit magithub markdown-mode paredit projectile python
  ;; 		   sass-mode rainbow-mode scss-mode solarized-theme
  ;; 		   volatile-highlights yaml-mode yari
  ;; 		   yasnippet
  ;; 		   zenburn-theme)
  '(color-theme git git-blame haml-mode yasnippet
		autopair)
;  '()
  "A list of packages to ensure are installed at launch.")

(defun my-packages-installed-p ()
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

;; Make python, etc., space indentable
(setq indent-tabs-mode nil)

;; Get rid of the damn menu bar
(menu-bar-mode -1)

;; ---------------------------------------------------------------------------
;; Git (on Debian, from git-el, copied into .emacs.d/git/ for portability)
;; ---------------------------------------------------------------------------
(setq load-path (cons "~/.emacs.d/git" load-path))
(require 'git)
(require 'git-blame)

;;(require 'vc-git)
;;(add-to-list 'vc-handled-backends 'GIT)

(autoload 'git-status "git" "Entry point into git-status mode." t)

;; git-blame.el
;; this autoload as recommended by git-blame.el comments
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)


(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

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

(require 'python-programming)
;(require 'init-python)
(global-set-key "\C-c\C-e" 'python-shell-send-buffer)


(setq load-path (cons "~/.emacs.d/ruby-mode" load-path))
(require 'ruby-mode)
;(require 'haml-mode)

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
 '(flymake-errline ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))))
 '(flymake-warnline ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold)))))

(require 'flymake-cursor)

(global-set-key "\C-cn" 'flymake-goto-next-error)
(global-set-key "\C-cp" 'flymake-goto-previous-error)

(require 'markdown-mode)


(setq gnus-secondary-select-methods '((nnmaildir "")))

;Now, the next time you start Gnus, this back end will be queried for
;new articles, and it will move all the messages in your spool file to
;its directory, which is `~/Mail/' by default. The new group that will
;be created (`mail.misc') will be subscribed, and you can read it like
;any other group.

;You will probably want to split the mail into several groups, though:

(setq nnmail-split-methods
      '(("junk" "^From:.*Lars Ingebrigtsen")
        ("crazy" "^Subject:.*die\\|^Organization:.*flabby")
        ("other" "")))

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-startup-indented t)  ; Don't require repetitive stars for sub-trees

;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;(setq org-log-done t)


; Fix goddamn dark dark blue color in syntax highlighting
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-gentrix)
     ))

(setq my-color-themes (list
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


(defun my-theme-set-default () ; Set the first row
  (interactive)
  (setq theme-current my-color-themes)
  (funcall (car theme-current)))

(defun my-describe-theme () ; Show the current theme
  (interactive)
  (message "%s" (car theme-current)))

; Set the next theme
(defun my-theme-cycle ()
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

;; adjust this path:
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")

;; For 0.7.90 and above:
;(require 'jabber-autoloads)
;(setq jabber-server "xmpp.l.google.com")
;(setq jabber-username "dennis.gentry@gmail.com")
;(setq ssl-program-name "openssl s_client -ssl2 -connect %s:%p")


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
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Type:
;;     M-x el-get-install RET jedi RET;;     M-x jedi:install-server RET
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (manoj-dark))))
