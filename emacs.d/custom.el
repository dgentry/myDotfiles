(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#1d2127" "#aa4450" "#858253" "#d0770f" "#86aed5" "#8686ae" "#5b8583" "#fdfdd5"])
 '(column-number-mode t)
 '(company-backends
   (quote
    (company-bbdb company-eclim company-semantic company-xcode company-cmake company-capf company-files
                  (company-dabbrev-code company-gtags company-etags company-keywords)
                  company-oddmuse company-dabbrev)))
 '(company-idle-delay nil)
 '(company-quickhelp-color-background "#b0b0b0")
 '(company-quickhelp-color-foreground "#232333")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (peter-dark-gray)))
 '(custom-safe-themes
   (quote
    ("bf5bdab33a008333648512df0d2b9d9710bdfba12f6a768c7d2c438e1092b633" "a4b062aa2d99859d1449440d7f40547efdaf3fec73e9862b4c3f45a18cff44c8" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "93931a63b1331d1df90cbb13566a108d33886697713248192be92223c294adf4" "834dd2f8d07bee7897b8119afa1f97aa24f1864ba232eb769c3236ea236ca99a" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "0eccc893d77f889322d6299bec0f2263bffb6d3ecc79ccef76f1a2988859419e" "bbf40cfdfd1c45f7b1797bef0ce4942f8f51a3e87b99408df3e0bb2b85a53e15" "eedf8564559559e709f1fb7745eb5a6eaadd4f0d129cc5cb6782387d3973c919" "06d1470ff3bc2165e9db268d6fe351429edd981f5228e398952df6d7a55483a5" "250fae92fc374120524b1ea522c376109f520bc48db049a4599caaa7197e5cc2" "35171876147648909d5f476dce2d318e3661dfc5e0cad84ae821012159d91382" "dfb96249c145cf2c38ca1f26f457618a6fcd4f20293d961d49529ebff6caa291" "24b4b0460e1cac413d602a3312f0ab1263fbc2d653dc3046cbf7963142aaa962" "3a14e65edbd90d77765f3d304502e8c93a067a456345f7ae02d2a7292b57c415" "2af0723c918af964e01342501a21facaaa9c22a0312678642c6244e2733b1360" "98a378cf12acab6991c4b78b0a775bd6f33982492ac814202dce85c13d373eec" "19f10406e536fe7e2912001ed9ea04a54f4836464bde7429748e7ddda33bc9d3" "ea9e77466eb18f40b677821b08b0f8336e6b78045374118ec05492e6b0d25e3d" "c7a0e76111b31d650fa08aa4315ce7ffa259da7e6d3d6e967258a2fe18c78ab1" "ed4fe28ab82755c632c9c0489ec061192122977366f738f7831a580e96accfea" "5811271e86287f73d0db235da5da3098765d90e42707a3b579f7fcbb835a2692" "6f93b8bfcb3281d683cd2bea1cf8e609008b0fe438a748dd1eb60da127a6b8cc" "7d5548bb9d18099d38d6ce8c03587dc86ab534afab547f59d014f86c46fbbff0" "3714d59a603f2d1a7a9d60d39809be3c36daf0202af436359105c8a46171a5c6" "3f3d4b4a07b542e40961568385754e64f47b10747f1c06fa114e79264e2adf04" "cbeb012853a479d8be356da506bac2b7acfb59fdc0ba7efe938e413e0a2f8e07" "a15c04e1129eb81e5b4483d3f92e2c5d18f93aabceca4d82d72458c6c5aa9f8f" "b05a42255b34315d2ef3394d35e88160eb29dc58edf46458f7641bcf57af9f74" "a894203aec1650e8a5d13ae734070fb43db4388dd797a7fb998685e3d5b29dab" "96dd041ef7916ee191bc5fbd8212efe4c5ca8872f5ac2463b62a8bab746f5b71" "c4fc8942f7bb5b2c93139340de8327dd56995709b1eba6fa0921c30b71c45927" "868e7235999a13e6dc248736837ecd99558fb7b4de39c68dd5b27da1466986dc" "c0f5c3e07b24b9e59f5be5b0d7c12bfff5650e37ee720bf7e3091e3ad1be2076" "442a25a78d51614611251491f10b5a6a520203fbd58db1d64ee10da969576dee" "055a0d678dc74d3b525398f3b53820e299264b9bf9983fccacfb1579405af46d" "d04e38552aceb69ad77d87766b04b3b98ad6c457a8e470a66537cccae6386001" "cfcb967a5be49b6b915905b4f17b7de40e64e94494cb06dccd99f27bf4af8da5" "0308b6bf2af13d7cb4ba21c5a886460ca1530cfbc2673fb08a8b3559486bdb56" "e3bba75f0a04e74e8a09ad2b40d93098732d35607b3c9c680874d8c97a1a54de" "22a796445e9267a45ed0c87f1fe86151e37a45566edb3121b34a0970a9b5faa0" "fda4fdfec90d8c48ff6cacd950a809489a625c2b21f98aa81047f8b791b9ce21" "1c8fec4461ca96ea967252fe6ee34e4da85ce057dd38138521f7d34688cff9a0" "94f2b9caa9e961135befa32c376d60b52903827963e5f2c77ad807c105f1f615" "cdbb4b82f6d346c3da30e5dc65b94f947ec171db645d60a33aeca33d29c1f0eb" "2ceaad76e66dc3c1cf9a82af99d79b8cdef0ac66ca249ba947b172796df91720" "a3f978e2f2f6598c9fe9f9286d28c0dc2387a9264de9729a56d8ae9d05b0a2a1" "e6c678727ebf4f77631a258c55126c0bc306e7bb6ea9912ae54edeab344c3c19" "833d3c34f753d6ae6ae57bfe6cc11543177ce1a91aac4a0cd99599402fe547ff" "1290b1c370421ce0522e3b422756e5853573c27c66806cd0b1ba6bd2000605b8" "1e5c4cd9428aa3e370a3a8dfc48486ee2be496ea0277e984204ac8008c2bfeff" "fd33285869d99632758facb7201a0f67481fe9cb08ba6f2e75896f141e54db38" "408b6aece1c31214dd795c4b2a062ce30bf693f540cfa8afc8cacba7ffc8e654" "b71ca3dd8591277588af9975ccf667e479272120baa998e0550d80ed433d9bcc" "f1aa9a3cdfc04c30c8634359b91f4fa905fd50a9ae5e465bbbec6002fb057d62" "d8241148eab34655a07a2c6e984aea2fa25621281a9d9df4ade68d67d4570f2d" "02e40965cd489a689cdf6fb9680ac09a6e769d94e5e9663d3db8af8eb6b27576" "5598e69d230f39f46be6f1c135531855b59d338a73b966ae395d715a25827034" "3f56681a9b906da1eed8a8fe15e3601a219722681c6eee906525dbf8a605a6dd" "e0eaeb9b2f22fdbfb77cd9b5116c1cda0012ccb7815abf88bf5bead45dc6bbb5" "bbfd2017f89ea387efcc57ca38ee85c39d56a67ad28abd7cdd06989ec5716748" "4fdff588726e600ccc74465629037c74cb074d0c784f0a7aae5691e11fb27fa3" "bf554d25065cfb8ebbade2d5049e804c8b87f19658cae837816ceb9663fd8eab" "f3e5a3bbdc57cb37ca55c00fc266f0d3a77d8365cb3af6750309c9c0517e8cbd" "4ccc389f572e5061b6352e6c4436ffacb16a60f1662a80af82f81d9c8fce0043" "b58b0f5cdae127d5f6e8fc702c3b20fe931a4c42767410fc5cf1d0ebcd3155fb" "64416da3109b2294b395afb04a5061a0230b8015dc11bfa186964c8a49c651da" "40e31f5912090d09d0ec9d1cd16cde9138c03958a3bd975b9c03fa5d7a5683dd" "e58b51aac9b8a9c7a4b209542222ecb7673854a96619cbf0aff1c2f905e731b5" "f6fb7c69beae813220658411490166cb6e050d65ccb0578dfdf7e5416ef27223" "fa8e5fa143207d1760a3db8225a32fe2c2b8a6d7243d1d0a8429de6d1ec3a519" "08a242063b8f68bd37ae4bf482d271ff56c03a3e461a36bbd2b1c554084217cf" "5256899c05dd4d774876d4329a82f40fb0874426108680289729a814e1db6617" "60ecc26ee26e94af5a843063f0f9d69de2ffaddacae24f2b1aff5487b66cb87f" "b2388520d931630df6d0040b14d77a73fe17c0ece9df36fa4ad4a6fecba7782d" "1e71138b934ad4061f18c3b02ea4c19507cfc842b1f148ad774986a0354f5752" "3eca2c8e74320b5130322dc23cbeb4f7a5df73611732c0baced4169174ad4dd6" "58fe07b087dafd4631d89cf8b01f1c3ff1f3b83e9bb6e829d7ed6e09a990e104" "197af1af7bbe3755d6be61b1ac56601be8b8c880928a255f1b60b8d6b3724360" "02a06346f8eef16ab42daf452b42981e60dc1efbe02eaca68b8fbdec6b5d3ab4" "c5373043298f571de67e98563fec5dced9f35a88ae92bd4f59bc86616113a17a" "1c082c9b84449e54af757bcae23617d11f563fc9f33a832a8a2813c4d7dfb652" "bf390ecb203806cbe351b966a88fc3036f3ff68cd2547db6ee3676e87327b311" "9399db70f2d5af9c6e82d4f5879b2354b28bc7b5e00cc8c9d568e5db598255c4" "3adb42835b51c3a55bc6c1e182a0dd8d278c158769830da43705646196fc367e" "2757944f20f5f3a2961f33220f7328acc94c88ef6964ad4a565edc5034972a53" "e1ad20f721b90cc8e1f57fb8150f81e95deb7ecdec2062939389a4b66584c0cf" "d890583c83cb36550c2afb38b891e41992da3b55fecd92e0bb458fb047d65fb3" "53772fbefe0276c0edf80ca2c94713fcdc8b93e245a6d87819c2909634e4c519" "85968e61ff2c490f687a8159295efb06dd05764ec37a5aef2c59abbd485f0ee4" "905cee72827a1ac7ad75d7407bfb222ad519f9ebcd9d1f70f00e1115a8448cf6" "2a9039b093df61e4517302f40ebaf2d3e95215cb2f9684c8c1a446659ee226b9" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "9feaea563860526d1a80cfd4bdb96fafd008439dbf9f891aac1a769bcd2574d3" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "2e58db4abfd74aafe50f0663af0a675c3e8f56e54f5d31d5172c9f5fa1d8ae9f" "d21f86f7de21e02c4523324ff7c505c1f86abc95c025efc441cd6b17bbdce62a" "48b2155a4338fac70b5063e6c6ac6d54a385bdc7d137873204128f9e36de5b29" "f905d4bed2f04a7d0de31ef0792398ce78a9935c7313a207b8e03cf34a57830f" "663b5df8a22e4e9dec463c07653f5bd7f4a694df47c10c8516ee8eb6ef888d4f" "679296765d5008ce28a1a296dc46faafaaf5af962faa165f5c22277ad6372fc2" "a2afb83e8da1d92f83543967fb75a490674a755440d0ce405cf9d9ae008d0018" "7dcce1d65f86e4b45214ac76af46cf363d1fedd9af79898fb395ba84b5cc1831" "7c7f1cbb8fc38f5472af61c935b2a5413b821a28225245ef315782bffe27914c" "883e6e38cf9e78ec5b237625321cf0216c6bb21ebd5a6c413160f8a41c9a2815" "3c620ddc828bace45497217e8818c67ef59c3c03579b1b987bae38cf307c0e0c" "d8fbe863d6d1d73f867edf932cbbe0733596e861d2c904dc6a49eaac5e86b650" "47f364f0a3129f72c1762ca4ee826eee38047222776fd7693f57188657aced61" "517556f356ce97889b3c8b378330a44df2b63448c3e69e436c71bdbbe7100e9f" "87530d8c479b2ef5ed8a6d415a81b551da8547e1b0e9b2e67ddcc9b71ce3177a" "45770f3ec1b2690c5ccb83a60d3dfb8e9ee635a0c20941693da5f603ac9ec210" "0079b9127c95e786009aadbafb0c72e20b90c123ec831a080525124da80f753e" "9bf750ec77fd315f0362acd775ec72795340165acfccd19b916a928204960e19" "05e544fb210a0f5dba5fb91f065156bcd95fe17afb4d41d35c74db980f4364b2" "c159f24906b4cb70fc5f6e227938b5513549c1cbf49ca8cfc8a1321f32e62486" "b0fe28500e208f5347284d0c14e34462ceb95bd954759c9c7ceb264fda6df308" "1b1048fa713ab782b786441f7e0bfa5ac537a14d60ff50cf6bcf0e82c3798179" "046dfc446989a7efeae506a8ae04e0e14767b022ea6b5fc14dc5e3107791a693" "855af93a8ab78fa875fab92885854ce4854b82307c9c6e4cf8a72db0fde8d6bf" "cc6d00b0745bdc19a57f80dd991802d27c57774270c5a7ec459723bc6efa3b5f" "842d912c45f4626503eec61a44147ecb345424da2024a6d9278fea64823d900e" "84a8a7f51cfb0aa260cd2d9cef616af5a1d9064bba36a4e417f45fe5df35652e" "4a89809d4e7e9862b7d57b4a25ba165db9f0480579f3258ad193b5b5e7452f33" "c773e93266b344351984192ee4ad3ce4f2776518ebf7d0eb38910bd20e8ffb29" "d995a0d239edb9e15c084664ab9ef6bf5945e30f1bbddf2fa5f50d617a71c658" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "71f90c426587457050168c16510e7dc064074a9e39b6425fb67cd9f3e1647946" "baa756581b579be2f463bdbf593b41000eae7cb3cb6fc454f322536217c2e674" "e8825f26af32403c5ad8bc983f8610a4a4786eb55e3a363fa9acb48e0677fe7e" "cdd26fa6a8c6706c9009db659d2dffd7f4b0350f9cc94e5df657fa295fffec71" "f2755fc8f0b4269cc45032715b8e11ea2d768aae47b8bb2a256ca1c8fdeb3628" "392395ee6e6844aec5a76ca4f5c820b97119ddc5290f4e0f58b38c9748181e8d" "73c69e346ec1cb3d1508c2447f6518a6e582851792a8c0e57a22d6b9948071b4" "6c2be59a8c2ad57740ceceec1b70854770ed9556ee355e98d38e1cc1243b6d03" "494943c59803ff6b509c0dc5a9f6d5d7604f2dd1e8637605b274084038c33539" "e08cf6a643018ccf990a099bcf82903d64f02e64798d13a1859e79e47c45616e" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "cd736a63aa586be066d5a1f0e51179239fe70e16a9f18991f6f5d99732cabb32" "eec08f7474a519de14f12bff9eef27a9c2f89422b00a2a37bd7d94ed4fcccae4" "3a3de615f80a0e8706208f0a71bbcc7cc3816988f971b6d237223b6731f91605" "ecba61c2239fbef776a72b65295b88e5534e458dfe3e6d7d9f9cb353448a569e" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "b013ed8ee4f85ecd576753ee81bba3e00e0ed49edc010fad34d440788e3253f2" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "edea0b35681cb05d1cffe47f7eae912aa8a930fa330f8c4aeb032118a5d0aabf" "efbe8f0a87281bcfa5e560d5ca10268c735de3a3bb160b54c520d02609aed9d8" "2cf6c29ecb592518bf34a54fe53ecd2e9f68d47c630dcc424393bcfc194b5ba4" "021720af46e6e78e2be7875b2b5b05344f4e21fad70d17af7acfd6922386b61e" "42b9d85321f5a152a6aef0cc8173e701f572175d6711361955ecfb4943fe93af" "9a58c408a001318ce9b4eab64c620c8e8ebd55d4c52327e354f24d298fb6978f" "dcb9fd142d390bb289fee1d1bb49cb67ab7422cd46baddf11f5c9b7ff756f64c" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3edbdd0ad45cb8f7c2575c0ad8f6625540283c6e928713c328b0bacf4cfbb60f" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(custom-theme-directory "~/.emacs.d/themes")
 '(display-line-numbers-grow-only t)
 '(doom-molokai-brighter-comments t)
 '(exec-path-from-shell-shell-name "/usr/local/bin/zsh")
 '(exec-path-from-shell-variables (quote ("PATH" "MANPATH" "IDF_PATH")))
 '(fci-rule-color "#62686E")
 '(frame-resize-pixelwise t)
 '(fringe-mode nil nil (fringe))
 '(global-hl-line-mode t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#FCE8C3" "#519F50" "#2C78BF" "#918175")))
 '(imenu-list-position (quote right))
 '(imenu-list-size 40)
 '(inhibit-startup-screen t)
 '(irony-additional-clang-options
   (quote
    ("-I/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/")))
 '(irony-completion-availability-filter (quote (available deprecated not-accessible)))
 '(ivy-count-format "(%d/%d) ")
 '(ivy-height 25)
 '(ivy-use-selectable-prompt t)
 '(jdee-db-active-breakpoint-face-colors (cons "#1d2127" "#dd8844"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1d2127" "#858253"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1d2127" "#494952"))
 '(line-spacing 2)
 '(linum-delay t)
 '(linum-format "%4d │ ")
 '(lsp-document-sync-method (quote full))
 '(lsp-ui-doc-enable nil)
 '(lsp-ui-flycheck-live-reporting nil)
 '(lsp-ui-sideline-enable nil)
 '(mac-mouse-wheel-smooth-scroll nil)
 '(magit-diff-use-overlays nil)
 '(modern-c++-font-lock-global-mode t)
 '(mouse-wheel-progressive-speed nil)
 '(nrepl-message-colors
   (quote
    ("#336c6c" "#205070" "#0f2050" "#806080" "#401440" "#6c1f1c" "#6b400c" "#23733c")))
 '(package-selected-packages
   (quote
    (nimbus-theme nord-theme kaolin-themes darktooth-theme faff-theme danneskjold-theme spacemacs-theme lab-themes ivy-xref lsp-ui company-lsp cquery swift-mode solarized-theme farmhouse-theme espresso-theme flatui-theme anti-zenburn-theme flycheck-rtags company-rtags doom-themes atom-one-dark-theme zeno-theme habamax-theme srcery-theme ivy-purpose quickrun counsel-projectile dracula-theme modern-cpp-font-lock all-the-icons-ivy ag git-timemachine doom-modeline ivy-rtags rtags imenu-list flycheck-irony powerline gruvbox-theme flycheck-pos-tip rainbow-mode yasnippet multiple-cursors flycheck-dialyxir exec-path-from-shell markdown-mode+ highlight-indent-guides jade-mode ace-window git diminish rust-mode yaml-mode csharp-mode pug-mode dockerfile-mode sudo-edit projectile fill-column-indicator company-irony irony counsel f ivy clang-format flycheck company-c-headers smart-mode-line magit company cmake-ide cmake-font-lock)))
 '(pdf-view-midnight-colors (quote ("#232333" . "#c7c7c7")))
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8")
 '(powerline-display-buffer-size nil)
 '(powerline-display-hud nil)
 '(powerline-display-mule-info nil)
 '(powerline-gui-use-vcs-glyph t)
 '(python-shell-interpreter "python3")
 '(ring-bell-function (quote ignore))
 '(rtags-diagnostics-summary-in-mode-line nil)
 '(safe-local-variable-values
   (quote
    ((projectile-project-compilation-dir . "build/")
     (projectile-project-compilation-cmd . "make -j 4")
     (projectile-compilation-dir . "build")
     (projectile-project-compilation-dir . "build")
     (projectile-project-compilation-cmd . "make -C build/ -j 4"))))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 101)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(sml/theme (quote respectful))
 '(sml/vc-mode-show-backend t)
 '(subatomic-high-contrast t)
 '(subatomic-more-visible-comment-delimiters t)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tetris-x-colors
   [[229 192 123]
    [97 175 239]
    [209 154 102]
    [224 108 117]
    [152 195 121]
    [198 120 221]
    [86 182 194]])
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(vc-annotate-background "#202020")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (list
    (cons 20 "#858253")
    (cons 40 "#9e7e3c")
    (cons 60 "#b77a25")
    (cons 80 "#d0770f")
    (cons 100 "#d47c20")
    (cons 120 "#d88232")
    (cons 140 "#dd8844")
    (cons 160 "#c08767")
    (cons 180 "#a3868a")
    (cons 200 "#8686ae")
    (cons 220 "#92708e")
    (cons 240 "#9e596f")
    (cons 260 "#aa4450")
    (cons 280 "#914550")
    (cons 300 "#794651")
    (cons 320 "#614751")
    (cons 340 "#62686E")
    (cons 360 "#62686E")))
 '(vc-annotate-very-old-color nil)
 '(visible-bell t)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(when
      (or
       (not
        (boundp
         (quote ansi-term-color-vector)))
       (not
        (facep
         (aref ansi-term-color-vector 0)))))
 '(window-divider-default-right-width 1)
 '(window-divider-mode t)
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "SFMono Nerd Font"))))
 '(aw-leading-char-face ((t (:foreground "red" :height 2.0))))
 '(rtags-errline ((t (:inherit flycheck-error))))
 '(rtags-fixitline ((t (:inherit flycheck-info))))
 '(rtags-warnline ((t (:inherit flycheck-warning)))))
