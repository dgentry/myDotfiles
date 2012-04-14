;; -*-emacs-lisp-*-

;; (normal-top-level-add-to-load-path ~/.emacs.d)
(setq load-path (cons "~/.emacs.d" load-path))
(require 'spud)

;; For the ChromeOS Edit with Emacs extension
(require 'edit-server)
;(edit-server-start)

(define-key global-map "\e+" 'update-time-stamp)

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
;(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; turn on font-lock (syntax highlighting) mode
(global-font-lock-mode t)

;; disable visual feedback on selections
(setq-default transient-mark-mode nil)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(setq show-trailing-whitespace t)

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
;(setq p4-use-p4config-exclusively t)

(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\M-%" 'query-replace-regexp)
(global-set-key "\C-c\C-]" 'indent-rigidly)

(global-set-key "\C-x!" 'compile)

(require 'timestomp)
(global-set-key "\C-ct" 'insert-timestomp)

(setq load-path (cons "~/.emacs.d/ruby-mode" load-path))
(require 'ruby-mode)
(setq load-path (cons "~/.emacs.d/rails" load-path))
(require 'rails)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(face-font-family-alternatives (quote (("Inconsolata" "Monospace" "courier" "fixed") ("courier" "CMU Typewriter Text" "fixed") ("Sans Serif" "helv" "helvetica" "arial" "fixed") ("helv" "helvetica" "arial" "fixed")))))

(defun other-window-backward (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (if n
      (other-window (- n))  ;if n is non-nil
    (other-window (- n))))  ;if n is nil

(global-set-key "\C-x\C-p" 'other-window-backward)

(require 'python-programming)

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
