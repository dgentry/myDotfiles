;;; package --- Summary

;;; Commentary:
;;; this file is for public consumption.  if you make changes, use
;;; M-x add-change to document what you did.  and byte-compile it.


;;; Code:

;; Greetings

(setq inhibit-splash-screen t)
(switch-to-buffer "*Hello*")
(insert "Hello " (capitalize (user-login-name)) ", welcome to Emacs!\n\n")

;; spud-quote-spuds is (was) a list of people with .quotes files

;; c-mode stuff

(setq c-indent-level 4
      c-continued-statement-offset 4)

;; cool key bindings

(define-key global-map "\C-xt" 'occur)
(define-key global-map "\C-s" 'isearch-forward-regexp)
(define-key global-map "\C-r" 'isearch-backward-regexp)
(define-key global-map "\M-\C-r" 'isearch-backward)
(global-set-key "\M-\C-s" 'tags-search)
(global-set-key "\M-," 'tags-loop-continue)
(global-set-key "\M-%" 'query-replace-regexp)

(define-key global-map "\C-x4k" 'kill-buffer-other-window)
(define-key global-map "\C-x\C-k" 'compile)
; C-x` is already next-error
(global-set-key "\C-c`" 'compile-goto-error)

(setq compilation-ask-about-save nil)
;(setq compilation-read-command nil)
(global-set-key "\C-x!" 'compile)

(global-set-key "\C-c\C-]" 'indent-rigidly)

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

(defun spud-member (elt list)
  "[spud] Non-recursive definition of member.
Return non-nil if ELT is an element of LIST.  Comparison done with equal.
The value is the tail of LIST whose car is ELT."
  (while (and list
	      (not (equal elt (car list))))
    (setq list (cdr list)))
  list)

(defun kill-buffer-other-window ()
  "[spud] Kill the buffer in the other window."
  (interactive)
  (kill-buffer (window-buffer (next-window))))

;; make rmail not backup the mail file
(add-hook
 'rmail-mode-hook
 (function
  (lambda ()
    (make-local-variable 'make-backup-files)
    (setq make-backup-files nil))))

;; put mail, text, TeX-mode, and news-reply modes into auto-fill sub-mode
(add-hook
 'mail-mode-hook
 (function (lambda () (auto-fill-mode 1))))
(add-hook
 'text-mode-hook
 (function (lambda () (auto-fill-mode 1))))
(add-hook
 'news-reply-mode-hook
 (function (lambda () (auto-fill-mode 1))))
(add-hook
'TeX-mode-hook
(function (lambda () (auto-fill-mode 1))))

;;; be notified when mail comes in
(defun display-mail ()
  "[spud] Like 'display-time' but only displays mail.
For people who don't care what time it is."
  (interactive)
  (display-time)
  (set-process-filter display-time-process 'display-mail-filter))

(defun display-mail-filter (proc string)
  "[spud] Process filter used by PROC ('display-mail').
Wraps 'display-time-filter' used by 'display-time' if STRING is 'Mail'."
  (if (string-match "Mail" string)
      (setq display-time-string "Mail")
    (setq display-time-string ""))
  ;; Force redisplay of all buffers' mode lines to be considered.
  (save-excursion (set-buffer (other-buffer)))
  (set-buffer-modified-p (buffer-modified-p))
  ;; Do redisplay right now, if no input pending.
  (sit-for 0))

;; allow M-ESC to work

(put 'eval-expression 'disabled nil)

;; Use shellcheck to find "compilation" errors.
;(add-to-list compilation-error-regexp-alist '
;	     (shellcheck "^In \\([^: \n	]+\\) line \\([0-9]+\\):" 1 2))


; Deal with alternate coding systems/line-endings
(defun unix-file ()
      "Change the current buffer to Latin 1 with Unix line-ends."
      (interactive)
      (set-buffer-file-coding-system 'iso-latin-1-unix t))
    (defun dos-file ()
      "Change the current buffer to Latin 1 with DOS line-ends."
      (interactive)
      (set-buffer-file-coding-system 'iso-latin-1-dos t))
    (defun mac-file ()
      "Change the current buffer to Latin 1 with Mac line-ends."
      (interactive)
      (set-buffer-file-coding-system 'iso-latin-1-mac t))

(defun no-dos-please-we-are-unixish ()
  "Preserve the coding system, substituting the -unix variant of the -dos coding system in use."
     (let ((coding-str (symbol-name buffer-file-coding-system)))
       (when (string-match "-dos$" coding-str)
         (setq coding-str
               (concat (substring coding-str 0 (match-beginning 0)) "-unix"))
         (message "CODING: %s" coding-str)
         (set-buffer-file-coding-system (intern coding-str)) )))

(add-hook 'find-file-hooks 'no-dos-please-we-are-unixish)

(provide 'spud)
;;; spud ends here
