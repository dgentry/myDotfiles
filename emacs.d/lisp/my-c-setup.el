;;; my-c-setup.el --- Stuff for C programming, especially at Blastwave

;;; Commentary:

;;; Code:
;;

;; LLVM coding style guidelines in emacs
;; Maintainer: LLVM Team, http://llvm.org/

(defun llvm-lineup-statement (langelem)
  (let ((in-assign (c-lineup-assignments langelem)))
    (if (not in-assign)
        '++
      (aset in-assign 0
            (+ (aref in-assign 0)
               (* 2 c-basic-offset)))
      in-assign)))

;; Add a cc-mode style for editing LLVM C and C++ code
(c-add-style "blastwave"
             '("gnu"
	       (fill-column . 100)
	       (c++-indent-level . 4)
	       (c-basic-offset . 4)
	       (indent-tabs-mode . nil)
	       (c-offsets-alist . ((arglist-intro . ++)
				   (innamespace . 0)
				   (member-init-intro . ++)
				   (statement-cont . llvm-lineup-statement)))))

;; Files in projects with .clang-format in projectile root
;; automatically get blastwave coding style.
(require 'f)
(require 'projectile)

(add-hook 'c-mode-common-hook
	  (function
	   (lambda nil
	     (if (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
		 (c-set-style "blastwave"))
               (c-guess))))

;; clang-format

(global-set-key (kbd "<C-iso-lefttab>") 'clang-format-buffer)

(defun clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
  (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (clang-format-buffer)))

(defun clang-format-buffer-smart-on-save ()
  "Add auto-save hook for clang-format-buffer-smart."
   (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))

(add-hook 'c-mode-hook #'clang-format-buffer-smart-on-save)
(add-hook 'c++-mode-hook #'clang-format-buffer-smart-on-save)

(provide 'my-c-setup)
;;; my-c-setup.el ends here
