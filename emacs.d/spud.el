;;; this file is for public consumption.  if you make changes, use
;;; M-x add-change to document what you did.  and byte-compile it.

;;; Greetings

(insert "Hello " (capitalize (user-login-name)) ", welcome to Emacs!\n\n")

;;; spud-quote-spuds is a list of people with .quotes files


;;; c-mode stuff

(setq c-indent-level 4
      c-continued-statement-offset 4)

;;; cool key bindings

(define-key global-map "\C-xt" 'occur)
(define-key global-map "\C-s" 'isearch-forward-regexp)
(define-key global-map "\C-r" 'isearch-backward-regexp)
(define-key global-map "\M-\C-s" 'isearch-forward)
(define-key global-map "\M-\C-r" 'isearch-backward)
(define-key global-map "\C-x4k" 'kill-buffer-other-window)
(define-key global-map "\C-x\C-k" 'compile)
(define-key global-map "\C-c]" 'indent-code-rigidly)

;;; spud functions

;(defun add-hook (hook-var hook-fun)
;  "[spud] Two arguments, HOOK-VAR and HOOK-FUN.  Adds HOOK-FUN to the list
;of hooks in HOOK-VAR if it is not already present.  add-hook is very tolerant;
;HOOK-VAR need not be previously defined, its value doesn't have to be a list,
;lambda expressions are cool, etc."
;  (or (boundp hook-var)
;      (set hook-var nil))
;  (let ((hook-var-val (symbol-value hook-var)))
;    (or (listp hook-var-val)
;	(setq hook-var-val (cons hook-var-val nil)))
;    (if (eq (car hook-var-val) 'lambda)
;	(setq hook-var-val (cons hook-var-val nil)))
;    (or (spud-member hook-fun hook-var-val)
;	(set hook-var (cons hook-fun hook-var-val)))))

;; non-recursive definition of member

(defun spud-member (elt list)
  "[spud] Returns non-nil if ELT is an element of LIST.  Comparison done
with EQUAL.  The value is actually the tail of LIST whose car is ELT."
  (while (and list
	      (not (equal elt (car list))))
    (setq list (cdr list)))
  list)

;; thing to kill the buffer in the other window

(defun kill-buffer-other-window ()
  "[spud] Kill the buffer in the other window."
  (interactive)
  (kill-buffer (window-buffer (next-window))))

;; hook to make rmail not backup the mail file

(add-hook
 'rmail-mode-hook
 (function
  (lambda ()
    (make-local-variable 'make-backup-files)
    (setq make-backup-files nil))))

;; hook to put mail mode into auto-fill sub-mode

(add-hook
 'mail-mode-hook
 (function (lambda () (auto-fill-mode 1))))

(add-hook
 'text-mode-hook
 (function (lambda () (auto-fill-mode 1))))

;; hook to put news-reply-mode into auto-fill sub-mode

(add-hook
 'news-reply-mode-hook
 (function (lambda () (auto-fill-mode 1))))

(add-hook
'TeX-mode-hook
(function (lambda () (auto-fill-mode 1))))

;;; stuff to be notified when mail comes in

(defun display-mail ()
  "[spud] Like display-time but only displays mail.
For people who don't care what time it is."
  (interactive)
  (display-time)
  (set-process-filter display-time-process 'display-mail-filter))

(defun display-mail-filter (proc string)
  "[spud] A process filter used by  display-mail  in place of
display-time-filter  used by  display-time."
  (if (string-match "Mail" string)
      (setq display-time-string "Mail")
    (setq display-time-string ""))
  ;; Force redisplay of all buffers' mode lines to be considered.
  (save-excursion (set-buffer (other-buffer)))
  (set-buffer-modified-p (buffer-modified-p))
  ;; Do redisplay right now, if no input pending.
  (sit-for 0))

;;; allow M-ESC to work

(put 'eval-expression 'disabled nil)

(provide 'spud)
