(setq load-path
      (append (list nil
		    "~/.emacs.d/python-mode-1.0/"
		    "~/.emacs.d/pymacs/"
		    "~/.emacs.d/ropemacs-0.6"
		    )
              load-path))
(setq python-python-command "ipython")

(defadvice py-execute-buffer (around python-keep-focus activate)
  "return focus to python code buffer"
  (save-excursion ad-do-it))

(require 'ipython)
(setq py-python-command-args '( "--colors" "Linux"))

(require 'python-mode)

(setenv "PYMACS_PYTHON" "python2.7") 
(require 'pymacs)
(setq pymacs-load-path '("~/.emacs.d/ropemode"
			 "~/.emacs.d/ropemacs"))
;(pymacs-load "ropemacs" "rope-")


(add-hook 'python-mode-hook
          '(lambda () (eldoc-mode 1)) t)


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


(provide 'python-programming)
