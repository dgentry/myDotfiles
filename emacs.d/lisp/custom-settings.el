;;; package --- Summary
;; It's just my custom-set variables, OK?
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#000000" "#8b0000" "#00ff00" "#ffa500" "#7b68ee" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(before-save-hook '(delete-trailing-whitespace))
 '(custom-safe-themes
   '("5911347880082b409c6c413af292acf89ef0f63eaf6601b8cffdf415ca15ba4c" "2cfa8e91f9b27914deb23dbc7915c2a5af589fd6a1cd531650e8c503cb6eefa7" "07f3e02affd947d56e78253f6055b2b39f1c32a925940908aa6cc88975d48117" "f402157ef91ab99cbcabbda2e2b827de15938bbe1a337fd961a3d33a83ae9ccf" "a0d9281cf41e8a226f0539a7f54e4812fdeaaec36c751b84671df97a54013465" "2ea9afebc23cca3cd0cd39943b8297ce059e31cb62302568b8fa5c25a22db5bc" "9939e735844cb24144d29ddf03fadf86a2d455758afeeee30372258e8a6401bb" "a4ef58c2fb31b065ad09fa3029adba5eb518e42ef104cf9acf7c409abf40ca55" "ec38d891ab6805f112b47c18149190a50bf1e2967b6e9fc84453989b6f67b2f6" "7de92d9e450585f9f435f2d9b265f34218cb235541c3d0d42c154bbbfe44d4dd" "c02b12444e027c332e58a7fb46ffd870df9e00123fd61e675288439b22c3c2a1" "b80d4f6dee7691fc5a437d760164c3eba202944b3f977d5b47bbb6b76cba0806" "dc11cee30927281fe3f5c77372119d639e77e86aa794dce2a6ff019afdfbec9e" "2a2d603924ef972c0a3afb98564fd0f77e5073878903ab984ee15d3970436419" "c2066e04bbaf085943d30ce019436f63fd655455630325e777c0bbb8a3373fa9" "143d897548e5a7efb5cf92c35bd39fe7c90cbd28f9236225ad3e80e1b79cef8a" "0ec7094cc0a201c1d6f7c37f2414595d6684403b89b6fd74dcc714b5d41cd338" "604b434a2a076b1663cdfe0eeeef9d86a79294d0d1c88a65cf9167e3c7f00ddc" default))
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(elpy-rpc-python-command "python3")
 '(elpy-shell-display-buffer-after-send t)
 '(elpy-syntax-check-command "flake8")
 '(emms-mode-line-icon-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };"))
 '(fci-rule-color "#383838")
 '(gnus-logo-colors '("#0d7b72" "#adadad") t)
 '(gnus-mode-line-image-cache
   '(image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };") t)
 '(org-agenda-files '("~/1.org"))
 '(package-selected-packages
   '(gptel fill-column-indicator ag all-the-icons anti-zenburn-theme arduino-cli-mode arduino-mode artbollocks-mode auto-compile auto-package-update autopair bash-completion bind-key bitbake bug-hunter calmer-forest-theme clang-format cmake-font-lock cmake-ide cmake-mode cmake-project color-theme-modern company company-rtags concurrent counsel counsel-projectile csound-mode cyberpunk-theme diminish doom-modeline dream-theme dumb-jump el-get eldoc-eval elpy exec-path-from-shell exotica-theme f find-file-in-project flycheck flycheck-rtags flycheck-swiftx flycheck-yamllint flymake-cursor flymake-go flymake-json flymake-shellcheck flymake-yaml flymake-yamllint focus fold-dwim forecast fuzzy git-commit git-commit-insert-issue git-messenger git-walktree gnu-elpa-keyring-update go-mode google-maps google-this haml-mode hc-zenburn-theme helm-rtags hl-sentence idle-require iedit impatient-mode impatient-showdown irony irony-eldoc ivy ivy-rtags ivy-xref jedi jedi-core jedi-direx jenkins-watch jinja2-mode json-mode labburn-theme let-alist live-py-mode madhat2r-theme magit markdown-mode metar mo-git-blame modern-cpp-font-lock monochrome-theme mood-one-theme multi-web-mode multiple-cursors night-owl-theme nimbus-theme noctilux-theme northcode-theme nose nova-theme nyan-mode nyx-theme ob-ipython ob-shell on-screen org org-beautify-theme org-plus-contrib overcast-theme ox-html5slide ox-minutes ox-reveal ox-tufte paganini-theme plan9-theme planet-theme projectile pydoc request-deferred reveal-in-osx-finder reykjavik-theme rtags selectric-mode seti-theme shrink-whitespace smart-compile soothe-theme sorcery-theme sos speech-tagger sphinx-doc spotify sublimity super-save swift-helpful swift-mode swift-playground-mode swiper ten-hundred-mode theme-changer tramp tree-sitter use-package vagrant virtualenv visible-mark visual-fill-column warm-night-theme wordsmith-mode writegood-mode writeroom-mode xkcd xterm-color yafolding yaml yaml-mode ycmd zen-and-art-theme zenburn-theme zerodark-theme zweilight-theme))
 '(python-fill-docstring-style 'pep-257-nn))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))) t)
 '(flymake-warnline ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold))) t)
 '(makefile-space ((t (:background "color-236"))))
 '(mode-line ((t (:background "#002000" :foreground "white" :box 1 :weight bold :height 0.9))))
 '(mode-line-buffer-id ((t (:background "black" :foreground "#60ff40" :weight bold :height 0.9))))
 '(org-document-info ((t (:foreground "blue"))))
 '(org-document-title ((t (:foreground "blue" :weight bold)))))


(provide 'custom-settings)
;;; custom-settings.el ends here
