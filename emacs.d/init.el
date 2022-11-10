;;; package -- my init.el
;;;
;;; Commentary:
;;;     This commentary is only here to shut up some flychecker thing.
;;; Code:
;;;     Same with this "Code:"

;;
;; Early Startup
;;

(defvar saved-start-time nil "Save current time for performance report at the end.")
;; Separate setq so subsequent evaluations of this file work correctly
(setq saved-start-time (float-time))
;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d gcs.  gc-cons-threshold %d"
                     (format "%.2f seconds"
                             (float-time (- (float-time) saved-start-time)))
                             gcs-done
                             gc-cons-threshold)))
;; Even on a rPi with 2 GB of memory, 50 MB is reasonable and
;; eliminates gc during init.  We'll set it back to something
;; reasonable at EOF
(setq gc-cons-threshold (* 150 1000 1000))

;; This adds just one directory to the path.  No trailing "/"
(add-to-list 'load-path "~/.emacs.d/lisp")
(setq load-prefer-newer t)

; These lines must be BEFORE any usage (thus loading) of org-mode,
; lest we load the built in and the updated org mode simultaneously.
(add-to-list 'load-path "~/.emacs.d/elpa/org-latest")
(require 'org-loaddefs)

;; Custom settings elsewhere for readability
(setq custom-file "~/.emacs.d/lisp/custom-settings.el")
(load custom-file t)

(setq user-full-name "Dennis Gentry"
      user-mail-address "dennis.gentry@gmail.com")
(setq inhibit-splash-screen t)

;; Nostalgic Spud.el
(require 'spud)

;; Make defadvice shut up when it redefines a function lest it pollute
;; my startup messages.
;; (setq ad-redefinition-action 'accept)

;;
;; Package Stuff
;;
(require 'package)

;; Emacs 26.1 can't reach package archives without this
(if (equal package--emacs-version-list '(26 1))
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
			 ("elpy" . "https://jorgenschaefer.github.io/packages/")))

(package-initialize)

(unless package-archive-contents
  (message "Init.el is Loading package archives. . .")
  (package-refresh-contents)
  (message "Init.el done."))

;; Use-package
(unless (package-installed-p 'use-package)
  (message "Init.el installing use-package.")
  (package-install 'use-package)
  (message "Use-package installed."))

(eval-when-compile
  (require 'use-package))
; Use-package-always-ensure ought to cause packages to be loaded from
; elpa if they aren't already present.
(setq use-package-always-ensure t)

;; This is my own lighter-weight auto-package-update
(require 'light-auto-package-update)

(use-package auto-compile
  :defer t
  :config (auto-compile-on-load-mode))

;; Silver Searcher
(use-package ag
  :defer t)

;;;
;;; Keyboard, Mouse, and Window Stuff
;;;

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
;(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; In iterm2 Prefs, edit profile/Keys, and check Left Alt Key to Esc+, which
;; makes it usable as a Meta key.

;; Make the mouse work in emacs with iterm2
(require 'mwheel)
(require 'mouse)
;; I tend not to want this on Ubuntu
;; (xterm-mouse-mode t)
(mouse-wheel-mode t)
(global-set-key [mouse-5] 'previous-line)
(global-set-key [mouse-4] 'next-line)
(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

;; Get rid of the damn menu bar
(menu-bar-mode -1)

;;
;; GUI-only
;;
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq frame-title-format  "")
(setq icon-title-format  "")

(defvar my-default-font-height (face-attribute 'default :height))

(defun my-default-font-size ()
  "Restore the original font size for the current frame."
  (interactive)
  (set-face-attribute 'default (selected-frame) :height my-default-font-height))

(defun my-increase-font-size ()
  "Increase the font size for the current frame."
  (interactive)
  (let ((size (face-attribute 'default :height)))
    (set-face-attribute 'default (selected-frame) :height (+ size 10))))

(defun my-decrease-font-size ()
  "Decrease the font size for the current frame."
  (interactive)
  (let ((size (face-attribute 'default :height)))
    (set-face-attribute 'default (selected-frame) :height (- size 10))))

(global-set-key (kbd "s-0") 'my-default-font-size)
(global-set-key (kbd "s-+") 'my-increase-font-size)
(global-set-key (kbd "s--") 'my-decrease-font-size)
;;
;; End of GUI Only
;;

;; multiple cursors
;(use-package multiple-cursors
;  :bind (;((kbd "C-S-c C-S-c") . mc/edit-lines)
;         ("\C-c>" . mc/mark-next-like-this)
;         ;("\C->" . mc/mark-next-like-this)
;         ;("\C-<" . mc/mark-previous-like-this)
;         ;("\C-c\C-<") 'mc/mark-all-like-this)
;         )

;; Doom modeline
;;(use-package doom-modeline
;;  :config
;;  (doom-modeline-mode))

;; Make two windows side-by-side
(bind-key "C-x |" 'split-window-horizontally)

;;
;; "New style" custom-themes (alternative to older color-themes)
;;

;; Don't pollute .emacs.d
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;; Yet make the .el for each theme loadable (not necessary for custom-themes from elpa)
(let ((basedir "~/.emacs.d/themes/"))
  (dolist (f (directory-files basedir))
    (if (and (not (or (equal f ".") (equal f "..")))
             (file-directory-p (concat basedir f)))
        (add-to-list 'custom-theme-load-path (concat basedir f)))))

;; Theme switcher
;; restore cathode?
(defvar more-themes '(arjen billw simple-1 calm-forest goldenrod
                      clarity comidia jsc-dark dark-laptop
                      euphoria hober late-night lawrence lethe
                      ld-dark matrix gentrix midnight oswald
                      renegade retro-green retro-orange
                      salmon-font-lock subtle-hacker
                      taming-mr-arneson taylor tty-dark pok-wob
                      word-perfect arjen dark-green euphoria
                      calmer-forest nyx)
  "Longer list of my themes.")

(defvar my-themes '(gentrix dark-green late-night calmer-forest
                    oswald arjen euphoria nyx lethe tty-dark
                    simple-1 billw comidia renegade)
  "Short list of my themes.")

;; A simple (load-theme 'dark-green) didn't work.
(add-hook 'after-init-hook (lambda () (load-theme 'gentrix)))

(defvar my-theme-index 0 "Which of my themes is active.")

(defun my-cycle-theme ()
  "Step to the next theme."
  (interactive)
 (setq my-theme-index (% (1+ my-theme-index) (length my-themes)))
 (my-load-indexed-theme))

(defun my-load-indexed-theme ()
  "Load the theme that theme-index points to."
  (my-try-load-theme (nth my-theme-index my-themes)))

(defun my-try-load-theme (theme)
  "Take a crack at loading THEME."
  (message "Loading %s" theme)
  (if (ignore-errors (load-theme theme))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))
(global-set-key (kbd "C-\\") 'my-cycle-theme)



;;;
;;; File Stuff
;;;

;; always end files with a newline
(setq require-final-newline t)

; But not with extra whitespace anywhere
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; stop at the end of the file instead of just adding lines
(setq next-line-add-newlines nil)

(defun newline-without-break-of-line ()
  "Add a line."
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key "\M-\r" 'newline-without-break-of-line)


;; Backups and auto saves
;; I don't think this actually does much except make the directories.
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))

(defvar --autosave-directory (concat user-emacs-directory "autosaves/"))
(if (not (file-exists-p --autosave-directory))
    (make-directory --autosave-directory t))
(setq auto-save-file-name-transforms `((".*" ,--autosave-directory t)))

(setq make-backup-files t          ; backup of a file the first time it is saved.
      backup-by-copying t          ; don't clobber symlinks
      version-control t            ; version numbers for backup files
      delete-old-versions t        ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 4          ; oldest versions to keep of new numbered backup (def: 2)
      kept-new-versions 4          ; newest versions to keep of new numbered backup (def: 2)
      auto-save-default t          ; auto-save every buffer that visits a file
      auto-save-timeout 20         ; number of seconds idle before auto-save (default: 30)
      auto-save-interval 200       ; number of keystrokes between auto-saves (default: 300)
      )

;; I wonder if this file is still there at google?
;(load-file "/home/build/public/google/util/google.el")


;;
;; Appearance (Font, Face, and Color) Stuff
;;

;; Quiet!
(setq ring-bell-function 'ignore)
(setq visible-bell t)

;; Don't use tabs for indenting.
(setq-default indent-tabs-mode nil)

`(setq show-trailing-whitespace t)

;; turn on font-lock (syntax highlighting) mode
(global-font-lock-mode t)

;; disable visual feedback on selections, because damn it's annoying.
;; Try less obnoxious region face at some point
(setq-default transient-mark-mode nil)

;; In the meantime, settle for visible mark.
;; (require 'visible-mark)
;; (defface visible-mark-active
;;   '((((type tty) (class mono)))
;;     (t (:background "pale green")))
;;   "Mark color when mark is active"
;;   :group 'visible-mark)
;; (defface visible-mark-face1
;;   '((((type tty) (class mono)))
;;     (t (:background "grey70")))
;;     "First mark history face"
;;     :group 'visible-mark)
;; (setq visible-mark-max 2)
;; (setq visible-mark-faces `(visible-mark-active visible-mark-face1))

;; (global-visible-mark-mode 1) ;; or add (visible-mark-mode) to specific hooks

;; Highlight line -- nice idea but even with face-foreground nil it messes with (whitens) faces.
;; (global-hl-line-mode 1)
;; (set-face-background 'hl-line "#080808")
;; (set-face-foreground 'highlight nil)

;; XTERM 256 color
;; (Don't forget to "setenv TERM xterm-256color")
(use-package xterm-color
  :hook (comint-preoutput-filter-functions . xterm-color-filter)
  :config
  (setq comint-output-filter-functions
        (remove 'ansi-color-process-output comint-output-filter-functions)))

(use-package eshell
  :requires xterm-color
  :config
  (add-hook 'eshell-mode-hook
	    (lambda () (setq xterm-color-preserve-properties t))))

(setq use-package-verbose t)

;;
;; Auto modes based on file extensions
;;

(use-package markdown-mode
  :requires impatient-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc -s -o foo.html"))

;;
;; Markdown -> HTML Themes
;;
(defvar md-themes '("amelia" "cerulean" "cyborg" "journal" "readable" "simplex" "slate" "spacelab" "spruce" "superhero" "united"))
(defvar md-theme "amelia")

(defun md-next-theme ()
   "Step to the next markdown theme in the md-themes list."
   (interactive)
   (message (format "Markdown theme was %s" md-theme))
   (setq md-theme (cadr (member md-theme md-themes)))
   (if (eq md-theme nil)
      (setq md-theme "amelia"))
   (message (format "Markdown theme is now %s" md-theme))
   ;; Will this cause the display to update?  I hope so.
   ;; (markdown-html (current-buffer))
   ;; No.  It inserts some crap in the current buffer.
   )
(bind-key "C-c ?" 'md-next-theme)


(defun markdown-html (buffer)
  "Render BUFFER (markdown) as html for impatient-mode using global md-theme."
  ;; format <theme> <buffer>
  (princ (with-current-buffer buffer
           (format "<!DOCTYPE html><html><title>%s</title><xmp theme=\"%s\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>"
                   (file-name-nondirectory buffer-file-name)
                   md-theme
                   (buffer-substring-no-properties (point-min) (point-max))))
         (current-buffer)))

(defun imp-md-setup ()
  "Set up impatient-mode for markdown."
  (impatient-mode)
  (imp-set-user-filter 'markdown-html)
  (httpd-start)
  (browse-url (format "http://localhost:8080/imp/live/%s/" (buffer-name))))

(require 'ox-publish)
(setq org-publish-project-alist
      '(
        ("org-notes"
         :base-directory "~/txt/"
         :base-extension "org"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         )
        ("org-static"
         :base-directory "~/txt/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org" :components ("org-notes" "org-static"))
        ))

(add-hook 'markdown-mode-hook 'imp-md-setup)
(add-hook 'org-mode-hook 'imp-md-setup)

;;
;; Org mode stuff
;;
(use-package org
  :defer t
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c t" . org-todo)
         ("C-c b" . org-iswitchb))
  :mode ("\\.org$" . org-mode)
  :config
  (setq org-log-done t)
  (setq org-todo-keywords '((sequence "TODO" "STARTED" "WAITING" "DONE")))
  (setq org-tag-alist
        '(("@work" . ?w) ("@home" . ?h) ("computer" . ?l) ("phone" . ?p) ("reading" . ?r)))
  (setq org-startup-indented t)  ; Cleaner Outline View

  ;; Reveal.js + Org mode
  (use-package ox-reveal
    :config
    (setq org-reveal-root "file:///home/gentry/myDotfiles/reveal.js/")
    (setq org-reveal-title-slide nil)))

;; Timestampery
;(provide 'timestomp)

(defun insert-timestomp ()
  "Insert the current time into the buffer prefixed by a dotted line."
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

(global-set-key "\C-ct" 'insert-timestomp)
(define-key global-map "\e+" 'update-time-stamp)

;;;
;;; Writing Stuff
;;;
(use-package artbollocks-mode
  :defer t
  :load-path  "~/elisp/artbollocks-mode"
  :config
  (progn
    (setq artbollocks-weasel-words-regex
          (concat "\\b" (regexp-opt
                         '("one of the"
                           "should"
                           "just"
                           "sort of"
                           "a lot"
                           "probably"
                           "maybe"
                           "perhaps"
                           "I think"
                           "really"
                           "pretty"
                           "nice"
                           "action"
                           "utilize"
                           "leverage") t) "\\b"))
    (setq artbollocks-jargon t)))

;;; Stefan Monnier <foo at acm.org>.  The opposite of fill-paragraph.
(defun unfill-paragraph (&optional region)
  "Make a multi-line paragraph (or REGION) into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))
(define-key global-map "\M-Q" 'unfill-paragraph)


;;;
;;; Programming Stuff
;;;

(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\C-c\C-]" 'indent-rigidly)
(global-set-key "\C-c]" 'indent-code-rigidly)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Line numbers
(setq linum-format "%3d│ ")
;(setq linum-format "%d|")
(add-hook 'prog-mode-hook 'linum-mode)
; If we can ever get rid of the leading space on the line numbers,
; switch to modern line number mode.
; (add-hook 'prog-mode-hook 'display-line-numbers-mode)

(autoload 'git-status "git" "Entry point into git-status mode." t)

;; Flycheck
(use-package flycheck
  :defer t
  :bind (("C-c n" . flycheck-next-error)
         ("C-c p" . flycheck-previous-error))
  :config
  (global-flycheck-mode))

;; Dumb-jump
(use-package dumb-jump
  :defer t
  :config
  (dumb-jump-mode)
  (setq dumb-jump-default-project "~/Projects"))

;;; Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-keymap-prefix (kbd "C-c p"))
  :config
  ;(setq projectile-completion-system 'ivy)
  (projectile-global-mode))

(use-package counsel-projectile
  :defer t
  :config
  (counsel-projectile-mode))

(defun projectile-compile-project--save-project-buffers (arg)
  "Ignore ARG."
  (projectile-save-project-buffers))

(advice-add 'projectile-compile-project :before #'projectile-compile-project--save-project-buffers)

;; I'd call this multiedit instead of iedit.  It's cheap "refactoring."
(use-package iedit
  :defer t
  :bind (("C-;" . iedit-dwim)))
;;; From https://www.masteringemacs.org/article/iedit-interactive-multi-occurrence-editing-in-your-buffer
(defun iedit-dwim (arg)
  "Start iedit but use \\[narrow-to-defun] to limit its scope unless ARG is nil."
  (interactive "P")
  (if arg
      (iedit-mode)
    (save-excursion
      (save-restriction
        (widen)
        ;; this function determines the scope of `iedit-start'.
        (if iedit-mode
            (iedit-done)
          ;; `current-word' can of course be replaced by other
          ;; functions.
          (narrow-to-defun)
          (iedit-start (current-word) (point-min) (point-max)))))))

;;
;; Compilation
;;
(setq compilation-scroll-output 'first-error)
(setq compilation-ask-about-save nil)
;; 'compilation-environment' is a list of env vars.  Each element is a
;; string like "envvar=value". These env vars override the usual ones.
;; (setq compilation-environment "GCC=/whatever")
;;
;; Skip warning and info messages.  (1 = skip only info).  Set to 0
;; (skip nothing) for my own code.
(setq compilation-set-skip-threshold 2)
;; Don't revisit the same place in the same file, even if another message points to it.
(setq compilation-skip-visited t)

;; Smart-compile uses the 'smart-compile-alist' of rules to come up with a compilation command
(use-package smart-compile
  :defer t
  :bind (("C-x C-k" . smart-compile)
         ("C-c `" . compile-goto-error)
         ;; C-x` is already next-error
         ("C-x !" . compile)))

;; For the cases where the compilation regexp misses a file, or you're
;; not in an official *compilation* buffer:
(defun visit-file-named-at-point ()
  "Visit the file whose name is under cursor."
  (interactive)
  ;; Don't allow colons in filenames because *compilation* uses those to delimit line and column numbers
  (setq thing-at-point-file-name-chars (replace-regexp-in-string ":" "" thing-at-point-file-name-chars))
  (find-file (thing-at-point 'filename)))
(global-set-key "\C-c\C-o" 'visit-file-named-at-point)

;(setq compilation-read-command nil)

; Allow colorized compilation
(ignore-errors
  (require 'ansi-color)
  (defun my-colorize-compilation-buffer ()
    (when (eq major-mode 'compilation-mode)
      (ansi-color-apply-on-region compilation-filter-start (point-max))))
  (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))

;; Colorize compilation buffer
;; Superseded by xterm-color setup, I think, but stopped working recently, so see above:
;(require 'ansi-color)
;(defun colorize-compilation-buffer ()
;  "Uh."
;  (read-only-mode nil)
;  (ansi-color-apply-on-region compilation-filter-start (point))
;  (read-only-mode t))
;(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Delete the .elc after saving a file.  Don't bother byte-compiling
;; because it's not all that much faster and causes weird
;; versionitis problems.
(add-hook 'emacs-lisp-mode-hook 'esk-remove-elc-on-save)
(defun esk-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

;;
;; Code formatting
;;

;; LLVM coding style guidelines in emacs
;; Maintainer: LLVM Team, http://llvm.org/
(defun llvm-lineup-statement (langelem)
  "Apparently 'this might as well have a documentation string including LANGELEM'."
  (let ((in-assign (c-lineup-assignments langelem)))
    (if (not in-assign)
        '++
      (aset in-assign 0
            (+ (aref in-assign 0)
               (* 2 c-basic-offset)))
      in-assign)))

;; Add a c-mode style for editing LLVM C and C++ code
;; Personal preference is probably closer to Google style
;; TODO: Only load when editing c-like
;; (c-add-style "gentry"
;;              '("gnu"
;; 	       (fill-column . 100)
;; 	       (c++-indent-level . 4)
;; 	       (c-basic-offset . 4)
;; 	       (indent-tabs-mode . nil)
;; 	       (c-offsets-alist . ((arglist-intro . ++)
;; 				   (innamespace . 0)
;; 				   (member-init-intro . ++)
;; 				   (statement-cont . llvm-lineup-statement)))))

;;; Clang-format

;; clang-format can be triggered using C-c C-f
;; Create clang-format file using google style:
;;   $ clang-format -style=google -dump-config > .clang-format
(use-package clang-format
  :requires projectile
  :bind (;("C-i" . clang-format-buffer)
         ("C-c C-f" . clang-format-buffer-smart))
  :hook (((c-mode c++-mode) . clang-format-buffer-smart)
         (before-save . clang-format-buffer-smart)
         ;; Files in projects with .clang-format in projectile root
         ;; automatically get gentry coding style.
         (c-mode-common . set-clang-style))
  :config
  (defun set-clang-style ()
    ".clang-format defaults to gentry, else c-guess"
    (if (file-exists-p (expand-file-name ".clang-format" (projectile-project-root)))
	(c-set-style "gentry"))
    (c-guess))
  (defun clang-format-buffer-smart ()
    "Format buffer if .clang-format exists in the projectile root."
    (message "Clang format checking for .clang-format file")
    (when (file-exists-p (expand-file-name ".clang-format" (projectile-project-root)))
      (message "Clang format formatting.")
      (clang-format-buffer))))

(use-package modern-cpp-font-lock
  :defer t
  :config
  (modern-c++-font-lock-global-mode t))


;;
;; TAGS (specifically ExuberantCtags now) stuff
;;
(defun create-tags (dir-name)
  "Create tags file in DIR-NAME."
  (interactive "DDirectory: ")
  (eshell-command
   (format "find %s -type f -name \"*.[ch]\" | etags -" dir-name)))

(defadvice find-tag (around refresh-etags activate)
  "Rerun etags and reload tags if tag not found.
If buffer is modified, ask about save before running etags."
  (let ((extension (file-name-extension (buffer-file-name))))
    (condition-case err ad-do-it
      (error (and (buffer-modified-p)
                  (not (ding))
                  (y-or-n-p "Buffer is modified, save it? ")
                  (save-buffer))
             (er-refresh-etags extension)
             ad-do-it))))

(defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently.
Maybe EXTENSION is the extension type of files to run etags on."
  (interactive)
  (shell-command (format "etags *.%s" (or extension "el")))
  (let ((tags-revert-without-query t))  ; don't query, revert silently
    (visit-tags-table default-directory nil)))

;; Maps in case RTAGS doesn't load and remap these)
(global-set-key (kbd "M-C-s") 'tags-search)
(global-set-key (kbd "M-,") 'tags-loop-continue)

;;
;; RTAGS
;;
(use-package rtags
  :disabled
  :hook (kill-emacs . rtags-quit-rdm) ;; Shutdown rdm when leaving emacs.
  :config
  (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
  (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed!"))

  (define-key c-mode-base-map "\M-." 'rtags-find-symbol-at-point)
  (define-key c-mode-base-map "\M-," 'rtags-find-references-at-point)
  (define-key c-mode-base-map "\M-?" 'rtags-display-summary)
  (rtags-enable-standard-keybindings)

  (setq rtags-completions-enabled t)
  ;; Ivy or helm
  ;;(setq rtags-display-result-backend 'ivy)
  (setq rtags-use-helm t))

;; TODO: Has no coloring! How can I get coloring?
(use-package helm-rtags
  :defer t
  :requires helm rtags
  :config
  (setq rtags-display-result-backend 'helm))

;; Use rtags for auto-completion.
(use-package company-rtags
  :requires company rtags
  :config
  (setq rtags-autostart-diagnostics t)
  (rtags-diagnostics)
  (setq rtags-completions-enabled t)
  (push 'company-rtags company-backends))

;; Live code checking.
(use-package flycheck-rtags
  :requires flycheck rtags
  :hook ((c-mode c++-mode objc-mode) . setup-flycheck-rtags)
  :config
  ;; ensure that we use only rtags checking
  ;; https://github.com/Andersbakken/rtags#optional-1
  (defun setup-flycheck-rtags ()
    (rtags-xref-enable)
    (flycheck-select-checker 'rtags)
    (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
    (setq-local flycheck-check-syntax-automatically nil)
    (rtags-set-periodic-reparse-timeout 1.0)))  ;; Run flycheck this many seconds after being idle.

(use-package company
  :defer t
  :hook (after-init . global-company-mode)
  :bind ("C-c >" . company-complete-common-or-cycle)
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 2
        company-show-numbers t
        company-tooltip-limit 20
        company-dabbrev-downcase nil
        company-backends '(company-gtags))
  (global-company-mode))

;; When you need environment vars propagated into emacs
;;(require 'exec-path-from-shell)
;;(when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize)
;;  (exec-path-from-shell-copy-envq "PKG_CONFIG_PATH")
;;  (exec-path-from-shell-copy-env "IDF_PATH"))

;;; Search/Replace keybindings
(define-key global-map (kbd "C-x t") 'occur)
(define-key global-map (kbd "C-s") 'isearch-forward-regexp)
(define-key global-map (kbd "C-r") 'isearch-backward-regexp)
(define-key global-map (kbd "M-C-r") 'isearch-backward)
(global-set-key (kbd "M-%") 'query-replace-regexp)

;; Ivy
;; (ivy, swiper, counsel)
(use-package ivy
  :bind (;; I'm gonna give swiper until August 2020
         ;;("\C-s" . swiper) ; Couldn't take it past 28 July
         ("C-c C-r" . ivy-resume)
         ([<f6>] . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ([<f1> f] . counsel-describe-function)
         ([<f1> v] . counsel-describe-variable)
         ([<f1> l] . counsel-find-library)
         ([<f2> i] . counsel-info-lookup-symbol)
         ([<f2> u] . counsel-unicode-char)
         ;;("C-c g" . counsel-git)
         ("C-c j" . counsel-git-grep)
         ("C-c k" . counsel-ag)
         ("C-x l" . counsel-locate)
         ;("C-S-o" . counsel-rhythmbox)
         ;(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
         )
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)

  ;; Ivy-xref
  (use-package ivy-xref
    :config (setq xref-show-xrefs-function 'ivy-xref-show-xrefs)))

;; Magit
;; Use magit instead of (emacs' built in) vc
(setq vc-handled-backends nil)
; "C-c g" overrides counsel-git above
(use-package magit
  :defer t
  :bind (("C-c g" . magit-status)
         ("C-c C-g" . magit-dispatch-popup)))

(defun sm-try-smerge ()
  "If there are likely merge conflicts in the file, enable smerge."
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (smerge-mode 1))))
(add-hook 'find-file-hook 'sm-try-smerge t)

;; On entering smerge-mode, disable flycheck.  The problem here,
;; though, is that flycheck doesn't get turned back on after you're
;; done with smerge-mode.
(add-hook 'smerge-mode-hook (lambda () (flycheck-mode -1)))

;; YAS -- Snippets
;; Too slow, and I don't really use them.
;; (yas-global-mode 1)

;; Diminish (reduce mode-line length/clutter)
;(use-package diminish
;  :config
;  (diminish 'irony-mode))
  ;(diminish 'flycheck-mode)
  ;(diminish 'company-mode)
  ;(diminish 'ivy-mode)
  ;(diminish 'abbrev-mode)
  ;(diminish 'eldoc-mode)
  ;(diminish 'yas-minor-mode)


(use-package flycheck
  :hook (after-init . global-flycheck-mode))

;;
;; Python stuff
;;

; TODO: Only elpy-enable on load of a .py
(use-package elpy
  :bind (("C-c C-a" . python-autopep8))
  :config
  (require 'my-python-setup))

;;
;; C-like language stuff
;;
(defun my-cpp-find-other-file--get-filename (filename)
  "Find the .c/.cpp corresponding to FILENAME.h and vice versa."
  (cond ((string-suffix-p ".h" filename) (replace-regexp-in-string "\\.h" ".cpp" filename))
        ((string-suffix-p ".c" filename) (replace-regexp-in-string "\\.c" ".h" filename))
        ((string-suffix-p ".cpp" filename) (replace-regexp-in-string "\\.cpp" ".h" filename))
        (t nil)))

(defun my-cpp-find-other-file--impl (findfile projectilefindfile)
  "Non-interactive function to find FINDFILE using PROJECTILEFINDFILE."
  (let ((filename (my-cpp-find-other-file--get-filename(buffer-file-name))))
    (if (file-exists-p filename)
        (funcall findfile filename)
      (funcall projectilefindfile))))

(defun my-cpp-find-other-file ()
  "Interactive version."
  (interactive)
  (my-cpp-find-other-file--impl 'find-file 'projectile-find-other-file))

(defun my-cpp-find-other-file-other-window ()
  "Interactive version."
  (interactive)
  (my-cpp-find-other-file--impl 'find-file-other-window
                                   'projectile-find-other-file-other-window))


(add-hook 'c++-mode-hook (lambda ()
                           (local-unset-key (kbd "M-o"))
                           (local-set-key (kbd "M-o") 'my-cpp-find-other-file)
                           (local-unset-key (kbd "C-M-o"))
                           (local-set-key (kbd "C-M-o") 'my-cpp-find-other-file-other-window)))

;; Arduino
;;(use-package arduino-mode
;;  :defer t)

;; HTML
(add-hook 'html-mode-hook
          (lambda ()
            ;; Default indentation is usually 2 spaces, changing to 4.
            (set (make-local-variable 'sgml-basic-offset) 4)))

(message (format "\nHello %s, welcome to Emacs!\n" (capitalize (user-login-name))))
(message (format "Emacs took %.2f s to run init.el.\n\n" (- (float-time) saved-start-time)))

;; For composing in emacs then pasting into a word processor,
;; this un-fills all the paragraphs (i.e. turns each paragraph
;; into one very long line) and removes any blank lines that
;; previously separated paragraphs.
;;
(defun wp-munge () "Un-fill paragraphs and remove blank lines." (interactive)
  (let ((save-fill-column fill-column))
    (set-fill-column 1000000)
    (mark-whole-buffer)
    (fill-individual-paragraphs (point-min) (point-max))
    ;(delete-matching-lines "^$")
    (set-fill-column save-fill-column) ))

;;(message (format "Gc-cons-threshold %d" start-gc-consthreshold))
;; Restore original, but x2
(setq gc-cons-threshold (* 800000 2))

(provide 'init)
;;; init.el ends here
