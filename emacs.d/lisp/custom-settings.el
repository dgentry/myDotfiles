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
 '(custom-safe-themes
   (quote
    ("f402157ef91ab99cbcabbda2e2b827de15938bbe1a337fd961a3d33a83ae9ccf" "a0d9281cf41e8a226f0539a7f54e4812fdeaaec36c751b84671df97a54013465" "2ea9afebc23cca3cd0cd39943b8297ce059e31cb62302568b8fa5c25a22db5bc" "9939e735844cb24144d29ddf03fadf86a2d455758afeeee30372258e8a6401bb" "a4ef58c2fb31b065ad09fa3029adba5eb518e42ef104cf9acf7c409abf40ca55" "ec38d891ab6805f112b47c18149190a50bf1e2967b6e9fc84453989b6f67b2f6" "7de92d9e450585f9f435f2d9b265f34218cb235541c3d0d42c154bbbfe44d4dd" "c02b12444e027c332e58a7fb46ffd870df9e00123fd61e675288439b22c3c2a1" "b80d4f6dee7691fc5a437d760164c3eba202944b3f977d5b47bbb6b76cba0806" "dc11cee30927281fe3f5c77372119d639e77e86aa794dce2a6ff019afdfbec9e" "2a2d603924ef972c0a3afb98564fd0f77e5073878903ab984ee15d3970436419" "c2066e04bbaf085943d30ce019436f63fd655455630325e777c0bbb8a3373fa9" "143d897548e5a7efb5cf92c35bd39fe7c90cbd28f9236225ad3e80e1b79cef8a" "0ec7094cc0a201c1d6f7c37f2414595d6684403b89b6fd74dcc714b5d41cd338" "604b434a2a076b1663cdfe0eeeef9d86a79294d0d1c88a65cf9167e3c7f00ddc" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(elpy-rpc-python-command "python3")
 '(elpy-shell-display-buffer-after-send t)
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
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
\"#######..#\" };")))
 '(fci-rule-color "#383838")
 '(gnus-logo-colors (quote ("#0d7b72" "#adadad")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
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
\"###########.######\" };")) t)
 '(org-agenda-files (quote ("~/1.org")))
 '(package-selected-packages
   (quote
    (impatient-showdown company bind-key cmake-font-lock cmake-ide cmake-mode cmake-project anti-zenburn-theme dream-theme hc-zenburn-theme labburn-theme zenburn-theme impatient-mode tramp iedit csharp-mode csound-mode visible-mark nyan-mode color-theme-modern gnu-elpa-keyring-update arduino-mode org-plus-contrib magit git-messenger git-walktree git-commit-insert-issue git-commit arduino-cli-mode artbollocks-mode cyberpunk-theme madhat2r-theme monochrome-theme mood-one-theme night-owl-theme nimbus-theme noctilux-theme northcode-theme nova-theme nyx-theme org-beautify-theme overcast-theme paganini-theme plan9-theme planet-theme reykjavik-theme seti-theme soothe-theme sorcery-theme warm-night-theme zen-and-art-theme zerodark-theme zweilight-theme calmer-forest-theme bug-hunter auto-compile ag all-the-icons auto-package-update autopair bash-completion clang-format company-rtags counsel counsel-projectile diminish doom-modeline dumb-jump el-get eldoc-eval elpy exec-path-from-shell exotica-theme f flycheck flycheck-rtags flycheck-swiftx flymake-cursor flymake-shell flymake-shell focus fold-dwim forecast google-maps google-this haml-mode helm-rtags hl-sentence idle-require irony irony-eldoc ivy ivy-rtags ivy-xref jedi jedi-core jedi-direx jenkins-watch jinja2-mode let-alist live-py-mode markdown-mode metar mo-git-blame modern-cpp-font-lock multiple-cursors nose on-screen ox-html5slide ox-minutes ox-reveal ox-tufte projectile pydoc reveal-in-osx-finder rtags selectric-mode shrink-whitespace smart-compile sos speech-tagger sphinx-doc spotify sublimity super-save swift-helpful swift-mode swift-playground-mode swiper theme-changer use-package vagrant virtualenv wordsmith-mode writegood-mode writeroom-mode xkcd xterm-color yafolding yaml-mode ycmd)))
 '(python-fill-docstring-style (quote pep-257-nn)))


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
