(setq load-path
      (append (list nil
		    "~/.emacs.d/pymacs/"
		    "~/.emacs.d/ropemacs"
		    "~/.emacs.d/ropemode"
		    )
              load-path))

; Damn this is annoying
;(defadvice py-execute-buffer (around python-keep-focus activate)
;  "return focus to python code buffer"
;  (save-excursion ad-do-it))

(add-to-list 'load-path "~/.emacs.d/python-mode.el-6.0.11")
(setq py-shell-name "ipython")
(require 'python-mode)
(setq py-mode-map python-mode-map)

(setq py-python-command-args '("--colors" "Linux"))

(setenv "PYMACS_PYTHON" "/usr/local/bin/ipython")

(require 'pymacs)
(setq pymacs-load-path '("~/.emacs.d/ropemode"
			 "~/.emacs.d/ropemacs"))
;(pymacs-load "ropemacs" "rope-")

;(add-hook 'python-mode-hook
;          '(lambda () (eldoc-mode 1)) t)

(defvar server-buffer-clients)
(when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
  (server-start)
  (defun fp-kill-server-with-buffer-routine ()
    (and server-buffer-clients (server-done)))
  (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))

;
; Make flymake work for python.  From
;   http://www.plope.com/Members/chrism/flymake-mode

(when (load "flymake" t)
  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/pycheckers.py" (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pycheckers-init)))
(add-hook 'find-file-hook 'flymake-find-file-hook)


(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))

(require 'anything)
(require 'anything-ipython)
(when (require 'anything-show-completion nil t)
  (use-anything-show-completion 'anything-ipython-complete
				'(length initial-pattern)))

(autoload 'pylookup-lookup "pylookup")
(autoload 'pylookup-update "pylookup")
(setq pylookup-program "~/.emacs.d/pylookup/pylookup.py")
(setq pylookup-db-file "~/.emacs.d/pylookup/pylookup.db")
;(global-set-key "\C-ch" 'pylookup-lookup)

;(autoload 'autopair-global-mode "autopair" nil t)
;(autopair-global-mode)
;(add-hook 'lisp-mode-hook #'(lambda () (setq autopair-dont-activate t)))

;(add-hook 'python-mode-hook
;          #'(lambda () (push '(?' . ?')
;			     (getf autopair-extra-pairs :code))
; (setq autopair-handle-action-fns
;      (list #'autopair-default-handle-action
;            #'autopair-python-triple-quote-action))))

(provide 'python-programming)
