;; -*-emacs-lisp-*-

;; (normal-top-level-add-to-load-path ~/.emacs.d)
(setq load-path (cons "~/.emacs.d" load-path))
(require 'spud)

(require 'auto-complete)
(global-auto-complete-mode t)

(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;(require 'yasnippet)
;(yas-global-mode 1)

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

;; always end a file with a newline
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

(setq load-path (cons "~/.emacs.d/ruby-mode" load-path))
(require 'ruby-mode)
(setq load-path (cons "~/.emacs.d/rails" load-path))
(require 'rails)

(defun other-window-backward (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (if n
      (other-window (- n))  ;if n is non-nil
    (other-window (- n))))  ;if n is nil

(global-set-key "\C-x\C-p" 'other-window-backward)

(require 'python-programming)
;(require 'init-python)

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

;(require 'org-install)
;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;(define-key global-map "\C-cl" 'org-store-link)
;(define-key global-map "\C-ca" 'org-agenda)
;(setq org-log-done t)


;(setq gnus-secondary-select-methods '((nnml "")))
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
(setq org-startup-indented t)

; Fix goddamn dark dark blue color in syntax highlighting
;(add-to-load-path "color-theme-6.6.0"
(add-to-list 'load-path "/Users/gentry/.emacs.d/color-theme-6.6.0")
;(require 'color-theme-autoload "color-theme-autoloads")
;(require 'color-theme)
;(eval-after-load "color-theme"
;  '(progn
;     (color-theme-initialize)
;     (color-theme-simple-1)))

(setq my-color-themes (list
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
