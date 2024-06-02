(require 'flycheck)
(defun flycheck-python-needs-module-p (checker)
  "Determines whether CHECKER needs to be invoked through Python.
Previous versions of Flycheck called pylint and flake8 directly;
this check ensures that we don't break existing code."
  (not (string-match-p (rx (or "pylint" "flake8" "pylint3")
                           (or "-script.pyw" ".exe" ".bat" "")
                           eos)
                       (flycheck-checker-executable checker))))
