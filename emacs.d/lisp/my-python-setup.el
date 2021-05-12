;;; My-python-setup -- This is my python programming setup.
;;; Commentary:
;;;                    There are many like it, but this one is mine.
;;; Code:

(use-package live-py-mode
  :defer t)
;; Called from use-package elpy's configure, so elpy stuff is available
(elpy-enable)

; Should only be for python, and not sure I use this anymore.
(global-set-key [C-c C-e] 'python-shell-send-buffer)

;; Have elpy use Flycheck instead of flymake
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Auto-format code on save
(add-hook 'elpy-mode-hook (lambda ()
                            (add-hook 'before-save-hook
                                      'elpy-format-code nil t)))

;; Maybe restore ipython once I get ipython working consistently
;; (elpy-use-ipython)

;; Fixing a key binding bug in elpy
;(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)

;; Hey, where did python-mode-map go?
;(define-key python-mode-map (kbd "C-c r m") 'python-insert-breakpoint)

;; Use my most likely virtualenv
(push "~/.virtualenvs/3/bin" exec-path)
(setenv "PATH" (concat "~/.virtualenvs/3/bin" ":" (getenv "PATH")))

(defcustom python-autopep8-path (executable-find "autopep8")
  "Autopep8 executable path."
  :group 'python
  :type 'string)

;; ; Probably just want to switch to yapf in elpy
;; (defun python-autopep8 ()
;;   "Automatically formats Python code to conform to the PEP 8 style guide.
;; $ autopep8 --in-place --aggressive <filename>"
;;   (interactive)
;;   (when (eq major-mode 'python-mode)
;;     (shell-command
;;      (format "%s --in-place --aggressive %s" python-autopep8-path
;;              (shell-quote-argument (buffer-file-name))))
;;     (revert-buffer t t t)))


;; support for interactive pdb in a compile buffer from
;; https://www.masteringemacs.org/article/compiling-running-scripts-emacs.
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


;; ExuberantCtags stuff
(defun create-tags (dir-name)
  "Create tags file in DIR-NAME."
  (interactive "DDirectory: ")
  (eshell-command
   (format "find %s -type f -name \"*.[ch]\" | ctags -" dir-name)))

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

;; Standard Jedi.el setting
;(add-hook 'python-mode-hook 'jedi:setup)
;(setq jedi:complete-on-dot t)

(provide 'my-python-setup)
;;; my-python-setup ends here
