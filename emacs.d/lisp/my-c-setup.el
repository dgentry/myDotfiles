;;; my-c-setup.el --- Stuff for C programming, especially at Blastwave

;;; Commentary:

;;; Code:
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


;;; Projectile
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

(add-hook 'c-mode-common-hook
	  (function
	   (lambda nil
	     (if (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
		 (c-set-style "blastwave"))
               (c-guess))))

;;; Clang-format

;; clang-format can be triggered using C-c C-f
;; Create clang-format file using google style
;; clang-format -style=google -dump-config > .clang-format
(require 'clang-format)

(global-set-key (kbd "<C-iso-lefttab>") 'clang-format-buffer)

(defun clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
  (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
    (clang-format-buffer)))

(defun clang-format-buffer-smart-on-save ()
  "Add auto-save hook for clang-format-buffer-smart."
   (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))

(global-set-key (kbd "C-c C-f") 'clang-format-buffer-smart)
(add-hook 'c-mode-hook #'clang-format-buffer-smart-on-save)
(add-hook 'c++-mode-hook #'clang-format-buffer-smart-on-save)

(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode t)


;;; Flycheck
(req-package flycheck
             :config
             (progn
               (global-flycheck-mode)))

;; Use "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON" to create compilation database

;;; RTAGS
;;;;;;;;;;;;;;;;;;;;
(req-package rtags
  :config
  (progn
    (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
    (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed!"))

    (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
    (define-key c-mode-base-map (kbd "M-,") 'rtags-find-references-at-point)
    (define-key c-mode-base-map (kbd "M-?") 'rtags-display-summary)
    (rtags-enable-standard-keybindings)

    (setq rtags-use-helm t)

    ;; Shutdown rdm when leaving emacs.
    (add-hook 'kill-emacs-hook 'rtags-quit-rdm)
    ))

;; TODO: Has no coloring! How can I get coloring?
(req-package helm-rtags
  :require helm rtags
  :config
  (progn
    (setq rtags-display-result-backend 'helm)
    ))

;; Use rtags for auto-completion.
(req-package company-rtags
  :require company rtags
  :config
  (progn
    (setq rtags-autostart-diagnostics t)
    (rtags-diagnostics)
    (setq rtags-completions-enabled t)
    (push 'company-rtags company-backends)
    ))

;; Live code checking.
(req-package flycheck-rtags
  :require flycheck rtags
  :config
  (progn
    ;; ensure that we use only rtags checking
    ;; https://github.com/Andersbakken/rtags#optional-1
    (defun setup-flycheck-rtags ()
      (flycheck-select-checker 'rtags)
      (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
      (setq-local flycheck-check-syntax-automatically nil)
      (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
      )
    (add-hook 'c-mode-hook #'setup-flycheck-rtags)
    (add-hook 'c++-mode-hook #'setup-flycheck-rtags)
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;


;(rtags-enable-standard-keybindings)
;(setq rtags-display-result-backend 'ivy)

;; (define-key c-mode-base-map (kbd "M-.") (function rtags-find-symbol-at-point))
;; (define-key c-mode-base-map (kbd "M-,") (function rtags-find-references-at-point))

;;(require 'company)
(req-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    ;; was "M-/"
    (global-set-key (kbd "C-<tab>") 'company-complete-common-or-cycle)
    (setq company-idle-delay 0)))

;(setq rtags-completions-enabled t)

;(require 'flycheck-rtags)
;(defun my-flycheck-rtags-setup ()
;  (rtags-xref-enable)
;  (flycheck-select-checker 'rtags)
;  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
;  (setq-local flycheck-check-syntax-automatically nil))

(add-hook 'c-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'c++-mode-hook #'my-flycheck-rtags-setup)
(add-hook 'objc-mode-hook #'my-flycheck-rtags-setup)
;; (push 'company-rtags company-backends)

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

;;; Irony
(req-package irony
  :config
  (progn
    ;; If irony server was never installed, install it.
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                      irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  ))

  ;; I use irony with company to get code completion.
  (req-package company-irony
    :require company irony
    :config
    (progn
      (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

  ;; I use irony with flycheck to get real-time syntax checking.
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

(provide 'my-c-setup)
;;; my-c-setup.el ends here
