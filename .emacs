;; (normal-top-level-add-to-load-path ~/.emacs.d)
(setq load-path (cons "~/.emacs.d" load-path))

;; For the ChromeOS Edit with Emacs extension
(require 'edit-server)
(edit-server-start)

(define-key global-map "\e+" 'update-time-stamp)

;; Red Hat Linux default .emacs initialization file  ; -*- mode: emacs-lisp -*-

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)


;; turn on font-lock mode
(global-font-lock-mode t)

;; enable visual feedback on selections
;;(setq-default transient-mark-mode t)

;; always end a file with a newline
(setq require-final-newline t)

;; stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(setq show-trailing-whitespace t)

;; Make python, etc., space indentable
(setq indent-tabs-mode nil)



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

(load-file "~/.emacs.d/python-mode-1.0/python-mode.el")

(require 'erin)
(require 'timestomp)

(setq load-path (cons "~/.emacs.d/ruby-mode" load-path))
(require 'ruby-mode)
(setq load-path (cons "~/.emacs.d/rails" load-path))
(require 'rails)


(global-set-key "\C-ct" 'insert-timestomp)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(face-font-family-alternatives (quote (("Inconsolata" "Monospace" "courier" "fixed") ("courier" "CMU Typewriter Text" "fixed") ("Sans Serif" "helv" "helvetica" "arial" "fixed") ("helv" "helvetica" "arial" "fixed")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defun deperfinate ()
  (interactive)
  (delete-matching-lines "^.+'s Self Assessment\\s *$")
  (delete-matching-lines "^Accomplishments: Please summarize")
  (delete-matching-lines "^General Feedback: Please summarize your overall impression of ")
  (delete-matching-lines "^Peer Assessments of .+$")
  (delete-matching-lines "^Strengths: What do you consider to be")
  (delete-matching-lines "^Areas for Development: What are the major.+areas that you think .+$")
  (delete-matching-lines "^submitted.+at.+$")
  (delete-matching-lines "Not yet completed")
  (replace-regexp "^\\(.+)\\) 's Peer Assessment of .+$" "                    -- \\1")
)

(global-set-key "\C-x/" 'deperfinate)

;
;
;
(defun other-window-backward (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (if n
      (other-window (- n))  ;if n is non-nil
    (other-window (- n))))  ;if n is nil


(global-set-key "\C-x\C-p" 'other-window-backward)
