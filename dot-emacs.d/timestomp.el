(provide 'timestomp)

(defun insert-timestomp ()
  "Insert the current time into the buffer between a couple of dotted lines"
  (interactive)
  (if (not (bolp))
      (insert "\n"))
  (let ((now (current-time)))
    (insert "-----\n"
	    (format-time-string "%e %B %Y %I:%M:%S %p" now)
	    "\n\n"))
  (setq p (point))
  (insert "\n\n")
  (goto-char p))
	


