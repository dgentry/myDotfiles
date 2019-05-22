;;; package -- my init.el
;;;
;;; Commentary:
;;;     This commentary is only here to shut up some flychecker thing.
;;; Code:
;;;     Same with this "Code:"

;; This just adds one directory to the path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; This adds directories recursively
;(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
;  (normal-top-level-add-subdirs-to-load-path))

(require 'spud)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Packages
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(add-to-list 'package-pinned-packages '(rtags . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(ivy-rtags . "melpa-stable") t)

(defun sort-words ()
  "Sort the words in the region using 'sort-regexp-fields'."
  (interactive)
  (progn
    (setq here (point))
    (goto-char (region-end))
    (insert " ")
    (goto-char here)
    (sort-regexp-fields 'nil "[-a-zA-Z0-9]+" "\\&" (region-beginning) (region-end))
    (goto-char (region-end))))

(when (eq system-type 'darwin)
  ;; use all the special keys on the mac keyboard
  (setq ;mac-option-modifier nil
        ;ns-function-modifier 'super
        ;mac-right-command-modifier 'hyper
        ;mac-right-option-modifier 'alt
        mac-left-ctrl-modifier 'meta))

(setq packages-i-want
;;      '(ace-window ag all-the-icons autopair autopair bash-completion clang-format counsel counsel-projectile csharp-mode diminish doom-modeline dumb-jump elpy exec-path-fromp-shell f flycheck flycheck-rtags flymake-shell focus fold-dwim forecast google-maps google-this hl-sentence idle-require ivy ivy-rtags ivy-xref jedi jedi-core jedi-direx live-py-mode markdown-mode metar modern-cpp-font-lock multiple-cursors nose on-screen ox-reveal projectile pydoc reveal-in-osx-finder rtags seclusion-mode selectric-mode shrink-whitespace smart-compile sos sphinx-doc spinner spotify sublimity super-save swiper theme-changer vagrant virtualenv wordsmith-mode writegood-mode xkcd xterm-color yafolding yaml-mode ycmd))
       '(ace-window ag all-the-icons auto-package-update autopair bash-completion clang-format counsel counsel-projectile csharp-mode diminish doom-modeline dumb-jump eldoc-eval elpy exec-path-from-shell exotica-theme f flycheck flycheck-rtags flymake-shell focus fold-dwim forecast google-maps google-this hl-sentence idle-require irony irony-eldoc ivy ivy-rtags ivy-xref jedi jedi-core jedi-direx live-py-mode markdown-mode metar modern-cpp-font-lock multiple-cursors nose on-screen ox-html5slide ox-minutes ox-reveal ox-tufte projectile pydoc reveal-in-osx-finder rtags seclusion-mode selectric-mode shrink-whitespace smart-compile sos sphinx-doc spinner spotify sublimity super-save swiper theme-changer use-package vagrant virtualenv wordsmith-mode  writegood-mode xkcd xterm-color yafolding yaml-mode ycmd))

(setq package-load-list '(all))     ;; List of packages to load

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox nyx wheatgrass)))
 '(custom-safe-themes
   (quote
    ("3cd4f09a44fe31e6dd65af9eb1f10dc00d5c2f1db31a427713a1784d7db7fdfc" "565aa482e486e2bdb9c3cf5bfb14d1a07c4a42cfc0dc9d6a14069e53b6435b56" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" "585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "08a89acffece58825e75479333109e01438650d27661b29212e6560070b156cf" "0bff60fb779498e69ea705825a2ca1a5497a4fccef93bf3275705c2d27528f2f" "04589c18c2087cd6f12c01807eed0bdaa63983787025c209b89c779c61c3a4c4" "ae3a3bed17b28585ce84266893fa3a4ef0d7d721451c887df5ef3e24a9efef8c" "8dc7f4a05c53572d03f161d82158728618fb306636ddeec4cce204578432a06d" "b135596aa34a746437e2f55c65053803ae0fa1d73d32bdcf77af1ca33e32d2c7" "d1ba97c2fbdcbdaa73c93ae92763c0ee3d5aec401aa4bd99a6bd1688aed43ce4" default)))
 '(org-agenda-files (quote ("~/1.org")))
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (doom-modeline nyan-mode cherry-blossom-theme green-phosphor-theme green-screen-theme gruvbox-theme klere-theme nyx-theme calmer-forest-theme req-package ace-window ag all-the-icons auto-package-update autopair bash-completion clang-format counsel counsel-projectile csharp-mode diminish doom-modeline dumb-jump eldoc-eval elpy exec-path-from-shell exotica-theme f flycheck flycheck-rtags flymake-shell focus fold-dwim forecast google-maps google-this hl-sentence idle-require irony irony-eldoc ivy ivy-rtags ivy-xref jedi jedi-core jedi-direx live-py-mode markdown-mode metar modern-cpp-font-lock multiple-cursors nose on-screen ox-html5slide ox-minutes ox-reveal ox-tufte projectile pydoc reveal-in-osx-finder rtags seclusion-mode selectric-mode shrink-whitespace smart-compile sos sphinx-doc spinner spotify sublimity super-save swiper theme-changer use-package vagrant virtualenv wordsmith-mode writegood-mode xkcd xterm-color yafolding yaml-mode ycmd dark-mint-theme))))

;; This is supposed to load all packages in the list, but it fails if
;; package-refresh-contents hasn't finished.  You can hand-run the
;; (Packagex-refresh-contents) and then run this to load everything.
(dolist (package package-selected-packages)
   (unless (package-installed-p package)
     (package-install package)))
;   (require package))

(load-theme 'dg-bigbook-board t)

(unless (package-installed-p 'org)  ;; Make sure the Org package is
  (package-install 'org))           ;; installed, install it if not
;; (setq org-...)                   ;; Your custom settings

(require 'use-package)
(setq use-package-always-ensure t)
(use-package auto-package-update
             :config
             (setq auto-package-update-delete-old-versions t)
             (setq auto-package-update-hide-results t)
             (auto-package-update-maybe))

(use-package req-package
  :ensure t
  :config (req-package--log-set-level 'debug))

(use-package ag)
(use-package f)

;; projectile
(use-package projectile
  :ensure t
  :config
  ;; :bind-keymap (("C-c p" . projectile-command-map))
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))


;; Comment out if you've already loaded this package...
(require 'cl)


;; Make the mouse work in emacs and iterm2
(require 'mwheel)
;(require 'mouse)
;(xterm-mouse-mode t)
(mouse-wheel-mode t)
;(global-set-key [mouse-4] 'next-line)
;(global-set-key [mouse-5] 'previous-line)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

;; For the ChromeOS Edit with Emacs extension
(require 'edit-server)
(edit-server-start)

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
;(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; turn on font-lock (syntax highlighting) mode
(global-font-lock-mode t)

;; disable visual feedback on selections, because damn it's annoying.
(setq-default transient-mark-mode nil)

;; always end files with a newline
(setq require-final-newline t)

;; stop at the end of the file instead of just adding lines
(setq next-line-add-newlines nil)

; Deal with whitespace
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Make python, etc.,to  space indents only
(setq indent-tabs-mode nil)
;; This seems to be required for js2 mode (javascript)
(setq-default indent-tabs-mode nil)

;; Get rid of the damn menu bar
;; It would be better for it to be conditional on in-terminal (not GUI)
(menu-bar-mode -1)

(autoload 'git-status "git" "Entry point into git-status mode." t)

(require 'timestomp)
(global-set-key "\C-ct" 'insert-timestomp)

(defun other-window-backward (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (if n
      (other-window (- n))  ;if n is non-nil
    (other-window (- n))))  ;if n is nil

(global-set-key "\C-x\C-p" 'other-window-backward)

; Flymake colors for dark background
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "chocolate3"))))
 '(font-lock-string-face ((t (:foreground "LightSalmon"))))
 '(org-document-info ((t (:foreground "blue"))))
 '(org-document-title ((t (:foreground "blue" :weight bold)))))


(global-set-key "\C-c;" 'comment-region)

(defun eval-current-buffer ()
  "Old name, I guess."
  (interactive)
  (eval-buffer))

;; Auto modes based on file extensions
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Org mode stuff
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(add-hook 'org-mode-hook '(local-set-key "\C-ct" 'org-todo))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-startup-indented t)  ; Cleaner Outline View
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)
(setq org-todo-keywords
      '((sequence "TODO" "STARTED" "WAITING" "DONE")))
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("computer" . ?l) ("phone" . ?p) ("reading" . ?r)))

;; Reveal.js + Org mode
(require 'ox-reveal)
(setq org-reveal-root "file:///Users/gentry/myDotfiles/reveal.js/")
(setq org-reveal-title-slide nil)

(add-hook 'after-init-hook #'global-flycheck-mode)

;; (require 'multi-web-mode)
;; (setq mweb-default-major-mode 'html-mode)
;; (setq mweb-tags
;;   '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;     (js-mode  "<script[^>]*>" "</script>")
;;     (css-mode "<style[^>]*>" "</style>")))
;; (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;; (multi-web-global-mode 1)

(add-hook 'html-mode-hook
        (lambda ()
          ;; Default indentation is usually 2 spaces, changing to 4.
          (set (make-local-variable 'sgml-basic-offset) 4)))

;; ExuberantCtags stuff
;; (defun create-tags (dir-name)
;;   "Create tags file in DIR-NAME."
;;   (interactive "DDirectory: ")
;;   (eshell-command
;;    (format "find %s -type f -name \"*.[ch]\" | etags -" dir-name)))

;; (defadvice find-tag (around refresh-etags activate)
;;   "Rerun etags and reload tags if tag not found.
;; If buffer is modified, ask about save before running etags."
;;   (let ((extension (file-name-extension (buffer-file-name))))
;;     (condition-case err ad-do-it
;;       (error (and (buffer-modified-p)
;;                   (not (ding))
;;                   (y-or-n-p "Buffer is modified, save it? ")
;;                   (save-buffer))
;;              (er-refresh-etags extension)
;;              ad-do-it))))

;; (defun er-refresh-etags (&optional extension)
;;   "Run etags on all peer files in current dir and reload them silently.
;; Maybe EXTENSION is the extension type of files to run etags on."
;;   (interactive)
;;   (shell-command (format "etags *.%s" (or extension "el")))
;;   (let ((tags-revert-without-query t))  ; don't query, revert silently
;;     (visit-tags-table default-directory nil)))


;; This seems to be required for js2 mode (javascript)
(setq-default indent-tabs-mode nil)

;;; Programming Stuff

(require 'smart-compile)
(require 'dumb-jump)

(dumb-jump-mode)
(setq dumb-jump-default-project "~/blastnet")

(require 'my-c-setup)

(defun my-py ()
  "Stuff I want for python programming."
  (interactive)
  (message "my-py")
  (require 'my-python)
  (set-fill-column 92)
  (require 'live-py-mode)
  (python-mode)
  (message "my-py done.")
)


(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq frame-title-format  "")
(setq icon-title-format  "")

(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envq "PKG_CONFIG_PATH")
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
;(global-set-key (kbd "M-x") 'counsel-M-x)
;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
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

;; ;; Ivy-xref
(require 'ivy-xref)
(setq xref-show-xrefs-function #'ivy-xref-show-xrefs)


;; magit
;;(setq vc-handled-backends nil)
(global-set-key (kbd "C-c g") 'magit-status)
(global-set-key (kbd "C-c M-g") 'magit-dispatch-popup)

;; cmake-ide
;(cmake-ide-setup)
;; Use launchd's rdm instead.
;(defun cmake-ide-maybe-start-rdm ()
;  "Foo."
;  (interactive))

(req-package irony
  :config
  (progn
    ;; If irony server was never installed, install it.
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'objc-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                      irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  ))

  ;; Use irony with company to get code completion.
  (req-package company-irony
    :require company irony
    :config
    (progn
      (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

  ;; Use irony with flycheck to get real-time syntax checking.
  (req-package flycheck-irony
    :require flycheck irony
    :config
    (progn
      (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

  ;; Eldoc shows argument list of the function you are currently writing in the echo area.
  (req-package irony-eldoc
    :require eldoc irony
    :config
    (progn
      (add-hook 'irony-mode-hook #'irony-eldoc)))


;; Projectile
(require 'projectile)
(require 'counsel-projectile)
;;(projectile-mode)
;;(counsel-projectile-mode)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)


;(require 'ycmd)
;; Specify the ycmd server command and path to the ycmd directory *inside* the
;; cloned ycmd directory
;; Neither of the following two lines seems to work
;(defvar ycmd-server-command '("python" "~/myDotfiles/ycmd/ycmd"))
;(set-variable ’ycmd-server-command '("python" "~/myDotfiles/ycmd/ycmd"))
;(defvar ycmd-extra-conf-whitelist '("~/.ycm_extra_conf.py"))
;(defvar ycmd-global-config "~/.ycm_extra_conf.py")
;(add-hook 'after-init-hook #'global-ycmd-mode)

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

(setq make-backup-files t          ; backup of a file the first time it is saved.
      backup-by-copying t          ; don't clobber symlinks
      version-control t            ; version numbers for backup files
      delete-old-versions t        ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6          ; oldest versions to keep of new numbered backup (def: 2)
      kept-new-versions 9          ; newest versions to keep of new numbered backup (def: 2)
      auto-save-default t          ; auto-save every buffer that visits a file
      auto-save-timeout 20         ; number of seconds idle before auto-save (default: 30)
      auto-save-interval 200       ; number of keystrokes between auto-saves (default: 300)
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
  "Ignore ARG."
  (projectile-save-project-buffers))

(advice-add 'projectile-compile-project :before #'projectile-compile-project--save-project-buffers)

;; multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Doom modeline
;(require 'doom-modeline)
;(doom-modeline-init)
;(setq doom-modeline-major-mode-icon nil)

;; Line numbers
(setq linum-format "%d ")
(add-hook 'prog-mode-hook 'linum-mode)

;; Theme switcher
(setq my-themes '(calmer-forest klere nyx gruvbox))
(setq my-theme-index 0)

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
  (if (ignore-errors (load-theme theme :no-confirm))
      (mapcar #'disable-theme (remove theme custom-enabled-themes))
    (message "Unable to find theme file for ‘%s’" theme)))
(global-set-key (kbd "C-\\") 'my-cycle-theme)


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

(defun newline-without-break-of-line ()
  "Add a line."
  (interactive)
  (end-of-line)
  (newline-and-indent))
(global-set-key (kbd "<M-return>") 'newline-without-break-of-line)

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

(provide 'init)
;;; init.el ends here
