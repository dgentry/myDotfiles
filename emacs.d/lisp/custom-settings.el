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
   '("b6c6582ad05b711ea541e9fceda143545e197313ea4af70dfc8b0f2e4e0ae5ed" "c6506a953fc7f2e6c6211197f14be026a309ce97075c952f7831cddb4e882c57" "a77735fe0193d57476298d982de95c51f1625da7aa4a07473be8143cf3326dc2" "ccfb67bfee9c42dc655fa8bfd0a65505a96995d25db0b21e8d75f06c32e5c10b" "68aa705cb8f28f3c740941c4733cc1a6f01bd0d6944bd52b6681061452dfb641" "34139649cce43fcd45f786f28c0662dac4cb36e121f5afabc8781d780e0ce7bb" "5dc61089503c63b0a5e50ae42c3def1a6b6a837f865964bbe73b2ba47fe70d76" "36c635fa58ea510e5b22994cad254ad35bc80eac9ef23ba229b99640d929dc2e" "25ee5541a6162f6cb4d2bbbcbfbe848dad71df2b9b30162d977f24901c41a57d" "069f0e31dfb204dc093ca68cd7a7a7ba15cc1f2bea6fee19f22acecef8aa0dd5" "5b0e01ff47e4ae765d81b20ec5a0f8d293c5e24647295ca0bc37b4cfa5331cd8" "a445c4e4d883699d5ea3e13d024201ea5ce037c842a2be6ad4e0ca9ed9a04937" "6570e0037a9b0ba4da9545d703972e85223f32abc9bb58821ac07af57646d1af" "4837875afa6affa5b65725de3c97056f3b49bf1b489de2b7078628d251a48109" "407490f2b898da3df7fb10ce38cdb1f463f44398e147c35beb541f464b646bfa" "4a7cff736ff83c6f57bb7faa30acb7c93c2a526deef07c020b73e59017e601dd" "864460e676878fcbe912302c1cdeb9cdbccb8dad6c2b339be5dbbb58551b41a2" "d412e20b2c33dcf0d61d7415b632b7d9259654147510114ed1dde3ee1ac3637b" "3a3e1308140d6fccffcac45f31e5dbb1fa16be0dc3bc661785fbc9b088a5a8ed" "6550aef52e142c906f3b57182545eeabcacde12f3f9383f6d08303c283de045f" "ca1115d65d377a7277f97ec2959f4e223e3dca702e4172ac545725694c7d62c1" "9fcf7499122517deebc34f8fa3bee578d806ae812e79d61ef6a20176cb8600e1" "c2baf19449098cdfe2e31e391a0b564c0c35071793c4c26066a939f83e38105e" "5a63e8d1eb2985c049855bc52fe1cfb9aec594f5e4ddb7b8d0280b30cc7296d1" "c252d8992fb9d0c5362a52826801194c4273c7fcea1b1b47ecf48ff52a7cc15d" "4456242a3a5f247cb5a511309945a9e315744a69cdf643a088425c35efe7ab9a" "0e47dae5cf4a4c4c2050380c76d3e3b5184e760ea97f357b8e64a6dd76d863bd" "52d69126aa1dbc8c06c5e239744cd533574c7245e14e503a81ae71e63e0fc6c6" "5911347880082b409c6c413af292acf89ef0f63eaf6601b8cffdf415ca15ba4c" "2cfa8e91f9b27914deb23dbc7915c2a5af589fd6a1cd531650e8c503cb6eefa7" "07f3e02affd947d56e78253f6055b2b39f1c32a925940908aa6cc88975d48117" "f402157ef91ab99cbcabbda2e2b827de15938bbe1a337fd961a3d33a83ae9ccf" "a0d9281cf41e8a226f0539a7f54e4812fdeaaec36c751b84671df97a54013465" "2ea9afebc23cca3cd0cd39943b8297ce059e31cb62302568b8fa5c25a22db5bc" "9939e735844cb24144d29ddf03fadf86a2d455758afeeee30372258e8a6401bb" "a4ef58c2fb31b065ad09fa3029adba5eb518e42ef104cf9acf7c409abf40ca55" "ec38d891ab6805f112b47c18149190a50bf1e2967b6e9fc84453989b6f67b2f6" "7de92d9e450585f9f435f2d9b265f34218cb235541c3d0d42c154bbbfe44d4dd" "c02b12444e027c332e58a7fb46ffd870df9e00123fd61e675288439b22c3c2a1" "b80d4f6dee7691fc5a437d760164c3eba202944b3f977d5b47bbb6b76cba0806" "dc11cee30927281fe3f5c77372119d639e77e86aa794dce2a6ff019afdfbec9e" "2a2d603924ef972c0a3afb98564fd0f77e5073878903ab984ee15d3970436419" "c2066e04bbaf085943d30ce019436f63fd655455630325e777c0bbb8a3373fa9" "143d897548e5a7efb5cf92c35bd39fe7c90cbd28f9236225ad3e80e1b79cef8a" "0ec7094cc0a201c1d6f7c37f2414595d6684403b89b6fd74dcc714b5d41cd338" "604b434a2a076b1663cdfe0eeeef9d86a79294d0d1c88a65cf9167e3c7f00ddc" default))
 '(diary-entry-marker 'font-lock-variable-name-face)
 '(elpy-formatter 'black)
 '(elpy-rpc-python-command "python3")
 '(elpy-rpc-virtualenv-path "~/.venvs/ah")
 '(elpy-shell-display-buffer-after-send t)
 '(elpy-syntax-check-command "/Users/gentry/.venvs/ah/bin/flake8")
 '(emms-mode-line-icon-image-cache
   '(image :type xpm :ascent center :data "/* XPM */\12static char *note[] = {\12/* width height num_colors chars_per_pixel */\12\"    10   11        2            1\",\12/* colors */\12\". c #358d8d\",\12\"# c None s None\",\12/* pixels */\12\"###...####\",\12\"###.#...##\",\12\"###.###...\",\12\"###.#####.\",\12\"###.#####.\",\12\"#...#####.\",\12\"....#####.\",\12\"#..######.\",\12\"#######...\",\12\"######....\",\12\"#######..#\" };"))
 '(enable-remote-dir-locals t)
 '(fci-rule-color "#383838")
 '(gnus-logo-colors '("#0d7b72" "#adadad") t)
 '(gnus-mode-line-image-cache
   '(image :type xpm :ascent center :data "/* XPM */\12static char *gnus-pointer[] = {\12/* width height num_colors chars_per_pixel */\12\"    18    13        2            1\",\12/* colors */\12\". c #358d8d\",\12\"# c None s None\",\12/* pixels */\12\"##################\",\12\"######..##..######\",\12\"#####........#####\",\12\"#.##.##..##...####\",\12\"#...####.###...##.\",\12\"#..###.######.....\",\12\"#####.########...#\",\12\"###########.######\",\12\"####.###.#..######\",\12\"######..###.######\",\12\"###....####.######\",\12\"###..######.######\",\12\"###########.######\" };") t)
 '(org-agenda-files '("~/1.org"))
 '(org-babel-python-command "python3")
 '(org-hidden-keywords '(author date email subtitle title))
 '(package-selected-packages
   '(rust-mode ag all-the-icons anti-zenburn-theme arduino-cli-mode arduino-mode artbollocks-mode auto-package-update autopair bash-completion bitbake bug-hunter clang-format cmake-font-lock cmake-ide cmake-mode cmake-project color-theme-modern company-rtags concurrent counsel-projectile crux csound-mode cyberpunk-theme diminish doom-modeline dream-theme dumb-jump el-get eldoc-eval ellama elpy exec-path-from-shell exotica-theme fill-column-indicator find-file-in-project flycheck-rtags flycheck-swiftx flycheck-yamllint flymake-cursor flymake-go flymake-shellcheck flymake-yaml flymake-yamllint focus fold-dwim forecast fuzzy git-commit-insert-issue git-messenger git-walktree gnu-elpa-keyring-update gnuplot go-mode google-maps google-this haml-mode hc-zenburn-theme helm-rtags highlight-doxygen hl-sentence hlinum idle-require iedit irony irony-eldoc ivy-hydra ivy-rtags ivy-xref jedi jedi-core jedi-direx jenkins-watch jinja2-mode labburn-theme let-alist llm madhat2r-theme magit-gh-pulls magithub metar mo-git-blame modern-cpp-font-lock monochrome-theme mood-one-theme multi-web-mode multiple-cursors night-owl-theme nimbus-theme noctilux-theme northcode-theme nose nova-theme nyan-mode nyx-theme ob-ipython ob-shell on-screen org org-beautify-theme org-plus-contrib org-re-reveal overcast-theme ox-html5slide ox-minutes ox-reveal ox-tufte paganini-theme plan9-theme planet-theme pydoc request-deferred reveal-in-osx-finder reykjavik-theme selectric-mode seq seti-theme shrink-whitespace smart-compile soothe-theme sorcery-theme sos speech-tagger sphinx-doc spotify sublimity super-save swift-helpful swift-mode swift-playground-mode ten-hundred-mode theme-changer tramp tree-sitter vagrant virtualenv visible-mark visual-fill-column warm-night-theme wordsmith-mode writegood-mode writeroom-mode xkcd yafolding yaml-mode yaml-pro ycmd zen-and-art-theme zenburn-theme zerodark-theme zweilight-theme))
 '(projectile-auto-discover t)
 '(projectile-tags-command "ctags-exuberant -Re -f \"%s\" %s \"%s\"")
 '(python-fill-docstring-style 'pep-257-nn)
 '(python-interpreter "/Users/gentry/.venvs/ah/bin/python3")
 '(python-shell-interpreter "~/.venvs/ah/bin/python3")
 '(python-shell-virtualenv-root "~/.virtualenv/3")
 '(safe-local-variable-values
   '((sh-indent-comment . t)
     (projectile-project-compilation-cmd . "cargo rustc -- -C link-arg=--script=./linker.ld")
     (pyvenv-virtualenvwrapper-python . /Volumes/more/gentry/.venvs/3/bin/python3)
     (projectile-project-compilation-cmd . "./build-chem.sh && scripts/send-image-to boofles.zapto.org:80 && ssh -p 80 boofles.zapto.org swupdate-cdi-tmp.sh")
     (projectile-project-compilation-cmd . "./build-chem.sh")
     (projectile-project-compilation-cmd . "./build-chem.sh && scripts/send-image-to boofles.zapto.org:80 && ssh -p 80 boofles.zapto.org swupdate-one-chem.sh t14.local cdi-tmp/*.swu")
     (projectile-project-compilation-cmd . "./build-chem-dev.sh && scripts/send-image-to localhost:2223 && ssh -p 2223 localhost swupdate-one-chem.sh t14.local 'cdi-tmp/*update*'")
     (projectile-project-compilation-cmd . "rm -rf build && rm -rf mucomm/build && (find . -name CMakeCache.txt -print0 | xargs -0 rm -f) && mkdir -p build && cmake -B build && make -C build -j30 && cd mucomm/test && make -j30 && ./test_read_config")
     (projectile-project-compilation-cmd . "./build-chem-dev.sh && scripts/send-image-to localhost:2223 && ssh -p 2223 localhost 'swupdate-one-chem.sh t14.local cdi-tmp/*update*.swu'")
     (projectile-project-compilation-cmd . "rm -rf build && rm -rf mucomm/build && (find . -name CMakeCache.txt -print0 | xargs -0 rm -f) && mkdir -p build && cmake -B build && make -C build -j30 && cd mucomm/test && make && ./test_read_config")
     (projectile-project-compilation-cmd . "rm -rf build && rm -rf mucomm/build && (find . -name CMakeCache.txt -print0 | xargs -0 rm -f) && mkdir -p build && cmake -B build && make -C build -j30")
     (projectile-project-compilation-cmd . "rm -rf build && cmake -B build && make -C build -j30 && cd mucomm/test_mucomm && pwd")
     (bite-me . 101)
     (eval progn
           (defun my-project-specific-function nil))
     (projectile-project-compilation-cmd . "./build-chem-dev.sh")
     (projectile-project-name . "CHEM OS")
     (projectile-project-compilation-cmd . "./build-chem-dev.sh && ./scripts/send-image-to boofles.zapto.org")
     (projectile-project-compilation-cmd . "./build-chem-dev.sh && pwd")
     (projectile-project-compilation-cmd . "./build-chem-dev.sh && scripts/sendto boofles.zapto.org")
     (projectile-project-name . "CHEM IU")
     (projectile-project-compilation-cmd . "mkdir -p build && cmake --build build && make -C build -j30 && pwd && cd mucomm/test && make -j30")
     (projectile-project-compilation-cmd . "mkdir -p build && cmake --build build && make -C build -j20 && pwd && cd mucomm/test && make")
     (projectile-project-compilation-cmd . "mkdir -p build && cmake --build build && make -C build -j20 && pwd && cd mucomm/test && make && ./test_readConfig")
     (projectile-project-compilation-cmd . "cmake --build build && make -C build -j20 && pwd && cd mucomm/test && make && ./test_readConfig")
     (projectile-project-name . "Vschem-iu")
     (secret-ftp-password . "yeahright")))
 '(warning-suppress-types '((use-package))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(apropos-misc-button ((t (:inherit (font-lock-constant-face button) :foreground "gainsboro"))))
 '(flymake-errline ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))) t)
 '(flymake-error ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))))
 '(flymake-warning ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold))))
 '(flymake-warnline ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold))) t)
 '(font-lock-constant-face ((t (:foreground "dodgerblue"))))
 '(makefile-space ((t (:background "color-236"))))
 '(mode-line ((t (:background "#002000" :foreground "white" :box 1 :weight bold :height 0.9))))
 '(mode-line-buffer-id ((t (:background "black" :foreground "#60ff40" :weight bold :height 0.9))))
 '(org-document-info ((t (:foreground "deepskyblue"))))
 '(org-document-title ((t (:foreground "cornflowerblue" :weight bold)))))


(provide 'custom-settings)
;;; custom-settings.el ends here
