;;; My-python -- This is my python programming setup.
;;; Commentary:
;;;                    There are many like it, but this one is mine.
;;; Code:

; Should only be for python, and not sure I use this anymore.
(global-set-key [C-c C-e] 'python-shell-send-buffer)

;; Elpy
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (highlight-indentation-mode -1))

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")


;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)
(define-key python-mode-map (kbd "C-c r m") 'python-insert-breakpoint)

(push "~/.virtualenv/v/bin" exec-path)
(setenv "PATH" (concat "~/.virtualenv/v/bin" ":" (getenv "PATH")))

;; Pymacs
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport 't)
; add the name of modules you want to autoimport
(setq ropemacs-autoimport-modules '("os" "shutil"))

(defcustom python-autopep8-path (executable-find "autopep8")
  "Autopep8 executable path."
  :group 'python
  :type 'string)

;; Probably want to switch to yapf, plus this is in elpy
(defun python-autopep8 ()
  "Automatically formats Python code to conform to the PEP 8 style guide.
$ autopep8 --in-place --aggressive <filename>"
  (interactive)
  (when (eq major-mode 'python-mode)
    (shell-command
     (format "%s --in-place --aggressive %s" python-autopep8-path
             (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t)))

(global-set-key [C-c C-a] 'python-autopep8)

;; Autopep8 before save
;(eval-after-load 'python
;  '(if python-autopep8-path
;       (add-hook 'before-save-hook 'python-autopep8)))

(defmacro after (mode &rest body)
  "After MODE is loaded, execute BODY."
  `(eval-after-load ,mode
     '(progn ,@body)))

(after 'auto-complete
       (add-to-list 'ac-dictionary-directories "~/.emacs.d/dict")
       (setq ac-use-menu-map t)
       (define-key ac-menu-map "\C-n" 'ac-next)
       (define-key ac-menu-map "\C-p" 'ac-previous))

(after 'auto-complete-config
       (ac-config-default)
       (when (file-exists-p (expand-file-name "~/.emacs.d/lisp/pymacs"))
         (ac-ropemacs-initialize)
         (ac-ropemacs-setup)))

(after 'auto-complete-autoloads
       (autoload 'auto-complete-mode "auto-complete" "enable auto-complete-mode" t nil)
       (add-hook 'python-mode-hook
                 (lambda ()
                   (require 'auto-complete-config)
                   (add-to-list 'ac-sources 'ac-source-ropemacs)
                   (auto-complete-mode))))

;; Not sure this section is compatible with pymacs/elpy.  It's a bit
;; of support for interactive pdb in a compile buffer from
;; https://www.masteringemacs.org/article/compiling-running-scripts-emacs.
(require 'python)

(defun python--add-debug-highlight ()
  "Add a highlighter for use by `python--pdb-breakpoint-string'."
  (highlight-lines-matching-regexp "## DEBUG ##\\s-*$" 'hi-red-b))

(add-hook 'python-mode-hook 'python--add-debug-highlight)

(defvar python--pdb-breakpoint-string "import pdb; pdb.set_trace() ## DEBUG ##"
  "Python breakpoint string used by `python-insert-breakpoint'.")

(defun python-insert-breakpoint ()
  "Insert a python breakpoint using `pdb'."
  (interactive)
  (back-to-indentation)
  ;; this preserves the correct indentation in case the line above
  ;; point is a nested block
  (split-line)
  (insert python--pdb-breakpoint-string))
(define-key python-mode-map (kbd "<f5>") 'python-insert-breakpoint)

(defadvice compile (before ad-compile-smart activate)
  "Advise `compile' to set the argument COMINT to t if breakpoints are present in `python-mode' files."
  (when (derived-mode-p major-mode 'python-mode)
    (save-excursion
      (save-match-data
        (goto-char (point-min))
        (if (re-search-forward (concat "^\\s-*" python--pdb-breakpoint-string "$")
                               (point-max) t)
            ;; set COMINT argument to `t'.
            (ad-set-arg 1 t))))))

; You'd think this would set my fill column to 92.

;;; What I really want is 92 chars for comments and docstrings and 99 chars for code.
;;; Also, this doesn't work.
(set-fill-column 92)
;;; Neither does this:
(set-default 'fill-column 92)

(require 'live-py-mode)

;; ExuberantCtags stuff
(defun create-tags (dir-name)
  "Create tags file in DIR-NAME."
  (interactive "DDirectory: ")
  (eshell-command
   (format "find %s -type f -name \"*.[ch]\" | etags -" dir-name)))

(defadvice find-tag (around refresh-etags activate)
  "Rerun etags and reload tags if tag not found.
If buffer is modified, ask about save before running etags."
  (let ((extension (file-name-extension (buffer-file-name))))
    (condition-case err ad-do-it
      (error (and (buffer-modified-p)
                  (not (ding))
                  (y-or-n-p "Buffer is modified, save it? ")
                  (save-buffer))
             (er-refresh-etags extension)
             ad-do-it))))

(defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently.
Maybe EXTENSION is the extension type of files to run etags on."
  (interactive)
  (shell-command (format "etags *.%s" (or extension "el")))
  (let ((tags-revert-without-query t))  ; don't query, revert silently
    (visit-tags-table default-directory nil)))

; (flycheck-define-checker python-prospector
;   "A Python syntax and style checker using Prospector.
; See URL `http://prospector.readthedocs.org/en/latest/index.html'."
;   :command ("prospector" "-s" "medium" "--profile-path" "/Users/gentry/tpg-code/metrics" "--profile" "tpg-prospector" "--max-line-length" "99" "-M" "-o" "emacs" source-inplace)
;   :error-patterns
;   ((error line-start
;           (file-name) ":" (one-or-more digit) " :" (one-or-more digit) ":" (optional "\r") "\n"
;           (one-or-more " ") "L" line ":" column " "
;           (message (minimal-match (one-or-more not-newline)) "E" (one-or-more digit) (optional "\r") "\n"
;                    (one-or-more not-newline) (optional "\r") "\n" line-end))
;    (warning line-start
;           (file-name) ":" (one-or-more digit) " :" (one-or-more digit) ":" (optional "\r") "\n"
;           (one-or-more " ") "L" line ":" column " "
;           (message (minimal-match (one-or-more not-newline)) "D" (one-or-more digit) (optional "\r") "\n"
;                    (one-or-more not-newline)) (optional "\r") "\n" line-end)
;    (warning line-start
;           (file-name) ":" (one-or-more digit) " :" (one-or-more digit) ":" (optional "\r") "\n"
;           (one-or-more " ") "L" line ":" column
;           (message (minimal-match (one-or-more not-newline)) (not digit) (one-or-more digit) (optional "\r") "\n"
;                    (one-or-more not-newline)) (optional "\r") "\n" line-end))

;   :modes python-mode)
;(add-to-list 'flycheck-checkers 'python-prospector)


(provide 'my-python)
;;; my-python ends here
