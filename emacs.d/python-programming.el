(require 'python)
(defun python--add-debug-highlight ()
  "Adds a highlighter for use by `python--pdb-breakpoint-string'"
  (highlight-lines-matching-regexp "## DEBUG ##\\s-*$" 'hi-red-b))

(add-hook 'python-mode-hook 'python--add-debug-highlight)

(defvar python--pdb-breakpoint-string "import pdb; pdb.set_trace() ## DEBUG ##"
  "Python breakpoint string used by `python-insert-breakpoint'")

(defun python-insert-breakpoint ()
  "Inserts a python breakpoint using `pdb'"
  (interactive)
  (back-to-indentation)
  ;; this preserves the correct indentation in case the line above
  ;; point is a nested block
  (split-line)
  (insert python--pdb-breakpoint-string))
(define-key python-mode-map (kbd "<f5>") 'python-insert-breakpoint)

(defadvice compile (before ad-compile-smart activate)
  "Advises `compile' so it sets the argument COMINT to t
if breakpoints are present in `python-mode' files"
  (when (derived-mode-p major-mode 'python-mode)
    (save-excursion
      (save-match-data
        (goto-char (point-min))
        (if (re-search-forward (concat "^\\s-*" python--pdb-breakpoint-string "$")
                               (point-max) t)
            ;; set COMINT argument to `t'.
            (ad-set-arg 1 t))))))


(add-hook 'shell-mode-hook 'compilation-shell-minor-mode)

(setq load-path
      (append (list nil
		    "~/.emacs.d/pymacs/"
		    "~/.emacs.d/ropemacs"
		    "~/.emacs.d/ropemode"
		    "~/.emacs.d/deferred-0.3.1"
		    )
              load-path))

; Damn this is annoying
;(defadvice py-execute-buffer (around python-keep-focus activate)
;  "return focus to python code buffer"
;  (save-excursion ad-do-it))

(add-to-list 'load-path "~/.emacs.d/python-mode.el-6.0.11")
(setq py-shell-name "ipython")
;(require 'python-mode)
(setq py-mode-map python-mode-map)

(setq py-python-command-args '("--colors" "Linux"))

;(setenv "PYMACS_PYTHON" "/Library/Frameworks/Python.framework/Versions/2.7/bin/ipython")

(require 'pymacs)
(setq pymacs-load-path '("~/.emacs.d/ropemode"
			 "~/.emacs.d/ropemacs"))

(defvar server-buffer-clients)
(when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
  (server-start)
  (defun fp-kill-server-with-buffer-routine ()
    (and server-buffer-clients (server-done)))
  (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))

;
; Make flymake work for python.  From
;   http://www.plope.com/Members/chrism/flymake-mode

;(when (load "flymake" t)
;  (defun flymake-pycheckers-init ()
;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;                       'flymake-create-temp-inplace))
;           (local-file (file-relative-name
;                        temp-file
;                        (file-name-directory buffer-file-name))))
;      (list "~/.emacs.d/pycheckers.py" (list local-file))))
;
;  (add-to-list 'flymake-allowed-file-name-masks
;	       '("\\.py\\'" flymake-pycheckers-init)))
;(add-hook 'find-file-hook 'flymake-find-file-hook)


;(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

;(require 'anything)
;(require 'anything-ipython)
;(when (require 'anything-show-completion nil t)
;  (use-anything-show-completion 'anything-ipython-complete
;				'(length initial-pattern)))

(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")
(setq pylookup-program "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file "~/.emacs.d/pylookup/pylookup.db")
;(global-set-key "\C-ch" 'pylookup-lookup)

(require 'autopair)
;(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
(add-hook 'lisp-mode-hook #'(lambda () (setq autopair-dont-activate t)))

(add-hook 'python-mode-hook
          #'(lambda () (push '(?' . ?')
			     (getf autopair-extra-pairs :code))
 (setq autopair-handle-action-fns
      (list #'autopair-default-handle-action
            #'autopair-python-triple-quote-action))))

(provide 'python-programming)
