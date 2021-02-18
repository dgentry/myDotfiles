;;(package-initialize)
;; Custom settings
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path "~/.emacs.d/lisp/")

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq frame-title-format  "")
(setq icon-title-format  "")

;; MELPA
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-pinned-packages '(rtags . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(ivy-rtags . "melpa-stable") t)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-selected-packages)
  (unless (package-installed-p package)
    (package-install package)))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "PKG_CONFIG_PATH")
  (exec-path-from-shell-copy-env "IDF_PATH"))
(setq mac-option-key-is-meta t)
(setq mac-right-option-modifier nil)

;; Ivy
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)

;; Ivy-xref
(require 'ivy-xref)
(setq xref-show-xrefs-function #'ivy-xref-show-xrefs)


;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
;;(eval-after-load 'flycheck
;;  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;; RTAGS
(require 'rtags)
(require 'ivy-rtags)
(require 'rtags-xref)
(rtags-enable-standard-keybindings)
(setq rtags-display-result-backend 'ivy)

;; (define-key c-mode-base-map (kbd "M-.") (function rtags-find-symbol-at-point))
;; (define-key c-mode-base-map (kbd "M-,") (function rtags-find-references-at-point))

(require 'company)

(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(global-company-mode)
(global-set-key (kbd "<C-tab>") 'company-complete)

(require 'flycheck-rtags)
(require 'company-rtags)
(defun my-flycheck-rtags-setup ()
  (rtags-xref-enable)
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))

(add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)
(push 'company-rtags company-backends)

;; (require 'company)
;; (global-set-key [C-tab] 'company-complete)
;; (global-company-mode)

;; (require 'cquery)
;; (require 'company-lsp)
;; (setq cquery-executable "/usr/local/bin/cquery"
;;       company-transformers nil
;;       company-lsp-async t
;;       company-lsp-cache-candidates nil)

;; (defun cquery-hook ()
;;   (lsp-cquery-enable)
;;   (lsp-ui-mode)
;;   (push 'company-lsp company-backends))

;; (add-hook 'c-mode-hook #'cquery-hook)
;; (add-hook 'c++-mode-hook #'cquery-hook)

;; magit
;;(setq vc-handled-backends nil)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c M-g") 'magit-dispatch-popup)

;; cmake-ide
(cmake-ide-setup)
;; Use launchd's rdm instead.
(defun cmake-ide-maybe-start-rdm ()
  "Foo."
  (interactive))

;; Irony and company
;; (require 'irony)
;; (require 'company)
;; (require 'company-irony)
;; (if (not (file-exists-p irony-user-dir))
;;     (make-directory irony-user-dir t))

;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-irony))
;; (global-set-key [C-tab] 'company-complete)
;; (global-company-mode)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)



;; Projectile
(require 'projectile)
(require 'counsel-projectile)
(projectile-mode)
(counsel-projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; mode-style
(c-add-style "ekkono"
	     '("bsd"
	       (c-basic-offset . 4)     ; Guessed value
	       (c-offsets-alist
		(block-close . 0)       ; Guessed value
		(case-label . 0)        ; Guessed value
		(class-close . 0)       ; Guessed value
		(defun-block-intro . +) ; Guessed value
		(defun-close . 0)       ; Guessed value
		(defun-open . 0)        ; Guessed value
		(inclass . +)           ; Guessed value
		(innamespace . 0)       ; Guessed value
		(namespace-close . 0)   ; Guessed value
		(statement . 0)         ; Guessed value
		(statement-block-intro . +) ; Guessed value
		(statement-case-intro . +) ; Guessed value
		(statement-cont . +)       ; Guessed value
		(substatement . +)      ; Guessed value
		(topmost-intro . 0)     ; Guessed value
		(topmost-intro-cont . 0) ; Guessed value
		(arglist-close . c-lineup-close-paren)
		(arglist-cont-nonempty . c-lineup-arglist)
		(c . c-lineup-C-comments)
		(comment-intro . c-lineup-comment)
		(cpp-macro . -1000)
		(inher-cont . c-lineup-multi-inher)
		(string . -1000))))
(c-add-style "blastwave"
             '("bsd"
               (c-basic-offset . 4)     ; Guessed value
               (c-offsets-alist
                (block-close . 0)       ; Guessed value
                (case-label . +)        ; Guessed value
                (defun-block-intro . +) ; Guessed value
                (defun-close . 0)       ; Guessed value
                (statement . 0)         ; Guessed value
                (statement-block-intro . +) ; Guessed value
                (statement-case-intro . +) ; Guessed value
                (topmost-intro . 0)        ; Guessed value
                (arglist-close . c-lineup-close-paren)
                (arglist-cont-nonempty . c-lineup-arglist)
                (c . c-lineup-C-comments)
                (comment-intro . c-lineup-comment)
                (cpp-macro . -1000)
                (inher-cont . c-lineup-multi-inher)
                (string . -1000))))

(setq c-default-style "blastwave")

;; clang-format
(require 'f)
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

;; No tabs
(setq-default indent-tabs-mode nil)

;; Backups and auto saves
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))

(defvar --autosave-directory (concat user-emacs-directory "autosaves/"))
(if (not (file-exists-p --autosave-directory))
    (make-directory --autosave-directory t))
(setq auto-save-file-name-transforms `((".*" ,--autosave-directory t)))

(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; Compilation
(setq compilation-scroll-output 'first-error)

;; Xterm mouse mode
(xterm-mouse-mode)

;; YAS
(yas-global-mode 1)

;; Diminish
(require 'diminish)
(diminish 'irony-mode)
(diminish 'flycheck-mode)
(diminish 'company-mode)
(diminish 'ivy-mode)
(diminish 'abbrev-mode)
(diminish 'eldoc-mode)
(diminish 'yas-minor-mode)

;; ace-window
(require 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)

(defun projectile-compile-project--save-project-buffers (arg)
  (projectile-save-project-buffers))

(advice-add 'projectile-compile-project :before #'projectile-compile-project--save-project-buffers)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Doom modeline
(require 'doom-modeline)
(doom-modeline-init)
(setq doom-modeline-major-mode-icon nil)

;; Line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Theme switcher
;;(setq peter/themes '(spacemacs-light gruvbox-light-hard))
;;(setq peter/themes-index 0)

;;(defun peter/cycle-theme ()
;;  (interactive)
;;  (setq peter/themes-index (% (1+ peter/themes-index) (length peter/themes)))
;;  (peter/load-indexed-theme))

;; (defun peter/load-indexed-theme ()
;;   (peter/try-load-theme (nth peter/themes-index peter/themes)))

;; (defun peter/try-load-theme (theme)
;;   (if (ignore-errors (load-theme theme :no-confirm))
;;       (mapcar #'disable-theme (remove theme custom-enabled-themes))
;;     (message "Unable to find theme file for ‘%s’" theme)))
;; (global-set-key (kbd "C-\\") 'peter/cycle-theme)
;; (peter/load-indexed-theme)

(defun peter/cpp-find-other-file--get-filename (filename)
  (cond ((string-suffix-p ".h" filename) (replace-regexp-in-string "\\.h" ".cpp" filename))
        ((string-suffix-p ".c" filename) (replace-regexp-in-string "\\.c" ".h" filename))
        ((string-suffix-p ".cpp" filename) (replace-regexp-in-string "\\.cpp" ".h" filename))
        (t nil)))

(defun peter/cpp-find-other-file--impl (findfile projectilefindfile)
  (let ((filename (peter/cpp-find-other-file--get-filename(buffer-file-name))))
    (if (file-exists-p filename)
        (funcall findfile filename)
      (funcall projectilefindfile))))

(defun peter/cpp-find-other-file ()
  (interactive)
  (peter/cpp-find-other-file--impl 'find-file 'projectile-find-other-file))

(defun peter/cpp-find-other-file-other-window ()
  (interactive)
  (peter/cpp-find-other-file--impl 'find-file-other-window
                                   'projectile-find-other-file-other-window))


(add-hook 'c++-mode-hook (lambda ()
                           (local-unset-key (kbd "M-o"))
                           (local-set-key (kbd "M-o") 'peter/cpp-find-other-file)
                           (local-unset-key (kbd "C-M-o"))
                           (local-set-key (kbd "C-M-o") 'peter/cpp-find-other-file-other-window)))

(defun newline-without-break-of-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key (kbd "<M-return>") 'newline-without-break-of-line)

(defvar peter/default-font-height (face-attribute 'default :height))

(defun peter/default-font-size ()
  "Restore the original font size for the current frame."
  (interactive)
  (set-face-attribute 'default (selected-frame) :height peter/default-font-height))

(defun peter/increase-font-size ()
  "Increase the font size for the current frame."
  (interactive)
  (let ((size (face-attribute 'default :height)))
    (set-face-attribute 'default (selected-frame) :height (+ size 10))))

(defun peter/decrease-font-size ()
  "Decrease the font size for the current frame."
  (interactive)
  (let ((size (face-attribute 'default :height)))
    (set-face-attribute 'default (selected-frame) :height (- size 10))))

(global-set-key (kbd "s-0") 'peter/default-font-size)
(global-set-key (kbd "s-+") 'peter/increase-font-size)
(global-set-key (kbd "s--") 'peter/decrease-font-size)

(provide 'init)
;;; init.el ends here
