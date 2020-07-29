;;; package --- Summary

;;; Commentary:
;;; this file is for public consumption.  if you make changes, use
;;; M-x add-change to document what you did.  and byte-compile it.


;;; Code:

;; Greetings

;;
;; spud functions
;;

(defun other-window-backward (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (if n
      (other-window (- n))  ;if n is non-nil
    (other-window (- n))))  ;if n is nil

(global-set-key "\C-x\C-p" 'other-window-backward)

(defun eval-current-buffer ()
  "Old name for 'eval-buffer'."
  (interactive)
  (eval-buffer))

(defun kill-buffer-other-window ()
  "[spud] Kill the buffer in the other window."
  (interactive)
  (kill-buffer (window-buffer (next-window))))
(define-key global-map "\C-x4k" 'kill-buffer-other-window)

;; Put mail-, text-, and TeX-modes into an auto-fill-like (but better)
;; minor mode.
(add-hook 'mail-mode-hook
 (function (lambda () (turn-on-visual-line-mode))))
(add-hook 'text-mode-hook
 (function (lambda () (turn-on-visual-line-mode))))
(add-hook'TeX-mode-hook
 (function (lambda () (turn-on-visual-line-mode))))

;; be notified when mail comes in
(defun display-mail ()
  "[spud] Like 'display-time' but only displays mail.
For people who don't care what time it is."
  (interactive)
  (defvar display-time-process)
  (display-time)
  (set-process-filter display-time-process 'display-mail-filter))

(defun display-mail-filter (proc string)
  "[spud] Process filter used by PROC ('display-mail').
Wraps 'display-time-filter' used by 'display-time' if STRING is 'Mail'."
  (defvar display-time-string "")
  (if (string-match "Mail" string)
      (setq display-time-string "Mail"))
  ;; Force redisplay of all buffers' mode lines to be considered.
  (with-current-buffer (set-buffer (other-buffer))
    (set-buffer-modified-p (buffer-modified-p)))
  ;; Do redisplay right now, if no input pending.
  (sit-for 0))

;; allow M-ESC (eval-expression) to work.
(put 'eval-expression 'disabled nil)

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
  "Preserve the coding system, substituting the -unix variant."
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-dos$" coding-str)
      (setq coding-str
            (concat (substring coding-str 0 (match-beginning 0)) "-unix"))
      (message "CODING: %s" coding-str)
      (set-buffer-file-coding-system (intern coding-str)) )))

(add-hook 'find-file-hooks 'no-dos-please-we-are-unixish)

(provide 'spud)
;;; spud ends here
