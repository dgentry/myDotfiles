;; Use "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON" to create compilation database
;; (use-package irony
;;   :ensure t
;;   :defer t
;;   :hook ( ((c++-mode c-mode objc-mode) . irony-mode)
;;           (irony-mode . my-irony-mode-hook)
;;           (irony-mode . irony-cdb-autosetup-compile-options))
;;   :config
;;   ;; If irony server was never installed, install it.
;;   (unless (irony--find-server-executable) (call-interactively #'irony-install-server))
;;   ;; Use compilation database first, clang_complete as fallback.
;;   (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
;;                                                   irony-cdb-clang-complete))
;;   (defun my-irony-mode-hook ()
;;     (define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
;;     (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))

;;   ;; Use irony with company to get code completion.
;;   (use-package company-irony
;;     :requires company irony
;;     :config
;;     (add-to-list 'company-backends 'company-irony))

;;   ;; Use irony with flycheck to get real-time syntax checking.
;;   (use-package flycheck-irony
;;     :requires flycheck irony
;;     :hook (flycheck-mode flycheck-irony-setup))

;;   ;; Eldoc shows argument list of the function you are currently writing in the echo area.
;;   (use-package irony-eldoc
;;     :requires eldoc irony
;;     :hook (irony-mode . irony-eldoc)))


;(require 'ycmd)
;; Specify the ycmd server command and path to the ycmd directory *inside* the
;; cloned ycmd directory
;; Neither of the following two lines seems to work
;(defvar ycmd-server-command '("python" "~/myDotfiles/ycmd/ycmd"))
;(set-variable ’ycmd-server-command '("python" "~/myDotfiles/ycmd/ycmd"))
;(defvar ycmd-extra-conf-whitelist '("~/.ycm_extra_conf.py"))
;(defvar ycmd-global-config "~/.ycm_extra_conf.py")
;(add-hook 'after-init-hook #'global-ycmd-mode)

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
