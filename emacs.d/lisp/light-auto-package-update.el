;;; package -- light-auto-package-update

;; Lightweight check to see if auto-update is due

;;; Commentary:

;; auto-package-update is great, but it uses 18% of my init time when
;; fully loaded, so this is a stripped down check of
;; .last-package-update-day.  If it's a week or more, we load and
;; use the full auto-package-update.
;;
;; This uses ~5% of my init time.

;;; Code:

(eval-when-compile
  (require 'use-package))

(defvar update-day-file "~/.emacs.d/.last-package-update-day")

(defun read-last-update-day ()
  "Read update-day-file contents."
  (when (file-exists-p update-day-file)
    (with-temp-buffer
      (insert-file-contents update-day-file)
      (string-to-number (buffer-string)))))

(defun should-update-packages-p ()
  "Return non-nil when an update is due."
  (or
   (not (file-exists-p update-day-file))
   (let* ((last-update-day (read-last-update-day))
          (days-since (- (time-to-days (current-time)) last-update-day)))
     (>=
      (/ days-since 7)
      1))))

(if (should-update-packages-p)
  (use-package auto-package-update
    :hook (auto-package-update-before . (lambda () (message "Auto-updating packages now.")))
    :init
    ;; This doesn't seem to be working, so I customize-variable-ed it
    (setq auto-package-update-delete-old-versions t)
    ;; If interactive, should ask, but not if batch
    (setq auto-package-update-prompt-before-update nil)
    (auto-package-update-at-time "02:27")
    (auto-package-update-maybe)))
(provide 'light-auto-package-update)
;;; light-auto-package-update.el ends here
