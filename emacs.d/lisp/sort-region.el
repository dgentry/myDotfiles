;; Helpful for alphabetizing selected-package list (written for custom packages)
;; It would probably be useful to sort the enclosing s-exp instead of the region
(defun sort-words-region ()
  "Sort the words in the region using 'sort-regexp-fields'."
  (interactive)
  (defvar sw-here (point))
  (progn
    (goto-char (region-end))
    (insert " ")
    (goto-char sw-here)
    (sort-regexp-fields 'nil "[-a-zA-Z0-9]+" "\\&" (region-beginning) (region-end))
    (goto-char (region-end))))
