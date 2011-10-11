;;; timestamp.el -- update/insert time stamp string at point

;; Copyright (C) 1990 Norikazu Aruga
;; Copyright (C) 2000 Noah Friedman

;; Author: Norikazu Aruga <nori@lec.com>
;; Maintainer: Noah Friedman <friedman@splode.com>
;; Created: 1990-01-08

;; $Id: timestamp.el,v 1.2 2000/08/08 09:51:38 friedman Exp $

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; Noah Friedman's branch is based on
;; version 1.04 (1994-02-07) from Norikazu Aruga

;; COMMANDS
;;
;;  update-time-stamp		Update the time stamp string around point.
;;				Prefix argument says to insert a new time
;;				stamp instead, after point.
;;				If the cursor has not moved, successive
;;				executions of this command will replace
;;				the time stamp just inserted with the next
;;				type in a cyclic fashion.
;;				You can also specify the type of the time
;;				stamp as its argument.

;; TIME STAMP TYPE
;;
;;	0	mm/dd/yy             (e.g. 06/18/90)       U.S. style
;;	1	dd-Mmm-yy            (e.g. 18-Jun-90)
;;	2	Monthname dd, yyyy   (e.g. June 18, 1990)
;;	3	Month dd, yyyy       (e.g. Jun 18, 1990)
;;	4	dd Month yyyy        (e.g. 18 Jun 1990)
;;	5	dd/mm/yy             (e.g. 18/06/90)       European style
;;	6	yyyy-mm-dd           (e.g. 1990-06-18)     ISO style

;; USER OPTIONS
;;
;;  time-stamp-default-type	The default type of the time stamp string
;;				you want `update-time-stamp' to use.  It must
;;				be a number ranging from 0 to 6.

;; It is suggested that you include the following line in your .emacs file.
;;
;;   (define-key global-map "\e+" 'update-time-stamp)

;;; Code:


;;;###autoload
(defvar time-stamp-default-type 4
  "*The type of the time stamp string you want.  Numeric value.
This type is used as the default type by `update-time-stamp'.")

;;; No user options below.

;; Here's the variable that holds the various forms of time stamp strings.
;; If you should change the value of this variable, you'd want to modify
;; the DOC string of the function `update-time-stamp.'
(defconst time-stamp-string-forms
  '((monthpad0 "/" daypad0 "/" yearab)	; 12/21/90   (U.S. style)
    (daypad0 "-" monthname "-" yearab)	; 21-Dec-90
    (monthfullname " " day ", " year)	; December 21, 1990
    (monthname " " day ", " year)	; Dec 21, 1990
    (day " " monthname " " year)	; 21 Dec 1990
    (daypad0 "/" monthpad0 "/" yearab)	; 21/12/90   (European style)
    (year "-" monthpad0 "-" daypad0))	; 1990-12-21 (ISO style)
  "List of patterns describing the forms of the time stamp.
Each form must consist of pre-defined keywords and/or string constants.
The keywords are:

	day		numerical value of the day: 1 - 31
	daypad		two-digit value of the day, blank-padded:  1 - 31
	daypad0		two-digit value of the day, zero-padded: 01 - 31
	month		numerical value of the month: 1 - 12
	monthpad	two-digit value of the month, blank-padded:  1 - 12
	monthpad0	two-digit value of the month, zero-padded: 01 - 12
	monthname	the abbreviated name of the month: Jan - Dec
	monthfullname	the (full) name of the month: January - December
	year		numerical value of the year: e.g. 1990
	yearab		two-digit value of the year: e.g. 90 (meaning 1990)")

(defvar time-stamp-last-update-values nil
  "List of the two values concerning the last time-stamp update:
the starting location and the type of the time stamp. (local) timestamp.el")
(make-variable-buffer-local 'time-stamp-last-update-values)

(defconst time-stamp-date-string-elts
  '((day           "%d" 'string-to-number)
    (daypad        "%e")
    (daypad0       "%d")
    (monthpad      "%_m")
    (monthpad0     "%02m")
    (month         "%m" 'string-to-number)
    (monthfullname "%B")
    (monthname     "%b")
    (year          "%Y")
    (yearab        "%y")))

(defun time-stamp-date-string (&optional type)
  "Return today's date in the format specified in TYPE."
  (mapconcat #'(lambda (x)
                 (cond ((stringp x) x)
                       ((symbolp x)
                        (let* ((elt (assq x time-stamp-date-string-elts))
                               (tm (format-time-string (nth 1 elt)))
                               (cvt (nth 2 elt)))
                          (if cvt
                              (funcall cvt tm)
                            tm)))))
             (nth (or type 0) time-stamp-string-forms)
             ""))

(defconst time-stamp-concat-form-elts
  '((day           "[1-3]?[0-9]")
    (daypad        "[ 1-3][0-9]")
    (daypad0       "[0-3][0-9]")
    (monthname     "\\(Jan\\|Feb\\|Mar\\|Apr\\|May\\|Jun\\|Jul\\|Aug\\|Sep\\|Oct\\|Nov\\|Dec\\)")
    (month         "1?[0-9]")
    (monthpad      "[ 1][0-9]")
    (monthpad0     "[01][0-9]")
    (monthfullname "\\(January\\|February\\|March\\|April\\|May\\|June\\|July\\|August\\|September\\|October\\|November\\|December\\)")
    (year          "[1-9]?[0-9]?[0-9]?[0-9]")
    (yearab        "[0-9][0-9]")))

(defun time-stamp-concat-form (form)
  "Return the string that is to be used to match the time stamp in a buffer.
The format of the string is determined from the first argument FORM, which
must be an element of time-stamp-string-forms."
  (mapconcat #'(lambda (x)
                 (cond ((stringp x) x)
                       ((symbolp x)
                        (nth 1 (assq x time-stamp-concat-form-elts)))))
             form ""))


;;;###autoload
(defun update-time-stamp (&optional insert-type)
  "Update the time stamp around point.  If the optional second argument
INSERT-TYPE (prefix argument, if interactive) is given, then insert a new
time stamp instead, after point.  INSERT-TYPE specifies the type (format)
of the time stamp.  See below for more details.

If you successively execute this command, the effect is to replace the
time stamp with the one of the next `type' as you go on.  This way you
can get the type of the time stamp you want without giving a prefix
argument.  If you *do* give a prefix argument, then the time stamp will
be replaced with the one you specify.  If you want to change the format
of the time stamp at point, update it first, then reissue this command,
giving the type you want as its argument.

Types of the time stamps recognized are:

	0	mm/dd/yy             (e.g. 06/18/90)       U.S. style
	1	dd-Mmm-yy            (e.g. 18-Jun-90)
	2	Monthname dd, yyyy   (e.g. June 18, 1990)
	3	Month dd, yyyy       (e.g. Jun 18, 1990)
	4	dd Month yyyy        (e.g. 18 Jun 1990)
	5	dd/mm/yy             (e.g. 18/06/90)       European style
	6	yyyy-mm-dd           (e.g. 1990-06-18)     ISO style

See the variables time-stamp-string-forms and time-stamp-default-type,
for more information."
  (interactive "*P")
  (save-match-data
    (if (eq last-command 'update-time-stamp)
        (let* ((beg (car time-stamp-last-update-values))
               (otype (car (cdr time-stamp-last-update-values)))
               (ntype (if insert-type
                          (if (listp insert-type)
                              time-stamp-default-type
                            (prefix-numeric-value insert-type))
                        (time-stamp-incr-type otype))))
          (goto-char beg)
          (if (looking-at (time-stamp-concat-form
                           (nth otype time-stamp-string-forms)))
              (progn
                (delete-region beg (match-end 0)) ; replace it with a new one
                (insert (time-stamp-date-string ntype))
                (setcdr time-stamp-last-update-values (list ntype))
                (message "%d" ntype))))
      ;; else
      (if insert-type
          (let ((opoint (point))
                (type (if (listp insert-type) ; C-u -> use the default type
                          time-stamp-default-type
                        (prefix-numeric-value insert-type))))
            (insert (time-stamp-date-string type))
            (setq time-stamp-last-update-values (list opoint type)))
        ;; No prefix arg -> update it.
        (let ((opoint (point))
              (lim (save-excursion (beginning-of-line) (point)))
              (beg nil) (end nil)
              (type nil))
          (while (and (not end) (or (not type) (not (bolp))))
            (skip-chars-backward "\-/0-9A-Za-z" lim)
            (let ((forms time-stamp-string-forms))
              (setq type 0)
              (while forms
                (if (looking-at (time-stamp-concat-form (car forms)))
                    (setq beg (point) end (match-end 0)  forms nil)
                  (setq forms (cdr forms) type (1+ type)))))
            (skip-chars-backward "^\-/0-9A-Za-z\n" lim))
          (if (and beg end)
              (delete-region beg end)
            ;; Parsing failed.  Just insert it using the default type (= 0).
            ;; Leave point where the insertion leaves it.
            (setq beg opoint type time-stamp-default-type))
          (goto-char beg)
          (insert (time-stamp-date-string type))
          (setq time-stamp-last-update-values (list beg type))
          (and end (goto-char opoint)))))))

(defun time-stamp-incr-type (type)
  (let ((len (length time-stamp-string-forms)))
    (if (>= type (1- len)) 0 (1+ type))))

(provide 'timestamp)

;;; timestamp.el ends here
