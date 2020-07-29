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
 '(custom-enabled-themes (quote (wheatgrass manoj-dark)))
 '(custom-safe-themes
   (quote
    ("2a2d603924ef972c0a3afb98564fd0f77e5073878903ab984ee15d3970436419" "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed" "9939e735844cb24144d29ddf03fadf86a2d455758afeeee30372258e8a6401bb" "0ec7094cc0a201c1d6f7c37f2414595d6684403b89b6fd74dcc714b5d41cd338" "b89a4f5916c29a235d0600ad5a0849b1c50fab16c2c518e1d98f0412367e7f97" "7de92d9e450585f9f435f2d9b265f34218cb235541c3d0d42c154bbbfe44d4dd" "f99f3196e57ca189f0444b7c75d18e819ab9edc975c8bc33667c9cc89f67c1b3" "907f14b0dd5f5ccca58bda546bc8de76677588403303d075dc8314f0ce43050e" "10551f0a24d0ac97a109f02178e9e34b448ee12a52357911cf3362a6b249cae6" "a4ef58c2fb31b065ad09fa3029adba5eb518e42ef104cf9acf7c409abf40ca55" "ec38d891ab6805f112b47c18149190a50bf1e2967b6e9fc84453989b6f67b2f6" "c02b12444e027c332e58a7fb46ffd870df9e00123fd61e675288439b22c3c2a1" "b80d4f6dee7691fc5a437d760164c3eba202944b3f977d5b47bbb6b76cba0806" "a0d9281cf41e8a226f0539a7f54e4812fdeaaec36c751b84671df97a54013465" "c2066e04bbaf085943d30ce019436f63fd655455630325e777c0bbb8a3373fa9" "ee9dba353d2a630336fb6d128207d6b8e3c58755863891eae937ec7abff23624" "b067e308e28279400419efbbabb35bb1a2508efbdcc7185f2a95e701713af528" "e21cc649ea89ef6df06d79a0efeb359d4d43cd362581c4d8b060a39878057cbc" "325c84384a0489f36e7941ffc1a4a594a8b6ce0485f7d7f5af545a5fbd7f1965" "a858c4dc3eeae2daf10cb42cf76b40793758cf0d0be42b9342c6c59faad4d6d3" "2d5c40e709543f156d3dee750cd9ac580a20a371f1b1e1e3ecbef2b895cf0cd2" "143d897548e5a7efb5cf92c35bd39fe7c90cbd28f9236225ad3e80e1b79cef8a" "dc11cee30927281fe3f5c77372119d639e77e86aa794dce2a6ff019afdfbec9e" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "d8a7a7d2cffbc55ec5efbeb5d14a5477f588ee18c5cddd7560918f9674032727" "72c530c9c8f3561b5ab3bf5cda948cd917de23f48d9825b7a781fe1c0d737f2f" "fb09acc5f09e521581487697c75b71414830b1b0a2405c16a9ece41b2ae64222" "0e8c264f24f11501d3f0cabcd05e5f9811213f07149e4904ed751ffdcdc44739" "a02c000c95c43a57fe1ed57b172b314465bd11085faf6152d151385065e0e4b1" "cdc2a7ba4ecf0910f13ba207cce7080b58d9ed2234032113b8846a4e44597e41" "e26e879d250140e0d4c4d5ab457c32bcb29742599bd28c1ce31301344c6f2a11" "deb7ae3a735635a85c984ece4ce70317268df6027286998b0ea3d10f00764c9b" "0973b33d2f15e6eaf88400eee3dc8357ad8ae83d2ca43c125339b25850773a70" "abd7719fd9255fcd64f631664390e2eb89768a290ee082a9f0520c5f12a660a8" "1127f29b2e4e4324fe170038cbd5d0d713124588a93941b38e6295a58a48b24f" "b71da830ae97a9b70d14348781494b6c1099dbbb9b1f51494c3dfa5097729736" "ff8c6c2eb94e776c9eed9299a49e07e70e1b6a6f926dec429b99cf5d1ddca62a" "701b4b4e7989329a0704b92fc17e6600cc18f9df4f2466617ec91c932b5477eb" "4e7e04c4b161dd04dc671fb5288e3cc772d9086345cb03b7f5ed8538905e8e27" "6a674ffa24341f2f129793923d0b5f26d59a8891edd7d9330a258b58e767778a" "ff6a8955945028387ed1a2b0338580274609fbb0d40cd011b98ca06bd00d9233" "daeaa8249f0c275de9e32ed822e82ff40457dabe07347fe06afc67d962a3b1e9" "b48599e24e6db1ea612061252e71abc2c05c05ac4b6ad532ad99ee085c7961a7" "c51e302edfe6d2effca9f7c9a8a8cfc432727efcf86246002a3b45e290306c1f" "d422c7673d74d1e093397288d2e02c799340c5dabf70e87558b8e8faa3f83a6c" "cc2f32f5ee19cbd7c139fc821ec653804fcab5fcbf140723752156dc23cdb89f" "a5a2954608aac5c4dcf9659c07132eaf0da25a8f298498a7eacf97e2adb71765" "68b847fac07094724e552eeaf96fa4c7e20824ed5f3f225cad871b8609d50ace" "1c10e946f9a22b28613196e4c02b6508970e3b34660282ec92d9a1c293ee81bb" "80a23d559a5c5343a0882664733fd2c9e039b4dbf398c70c424c8d6858b39fc5" "1342a81078bdac27f80b86807b19cb27addc1f9e4c6a637a505ae3ba4699f777" "44f5578eccb2cde3b196dfa86a298b75fe39ceff975110c091fa8c874c338b50" "2ea9afebc23cca3cd0cd39943b8297ce059e31cb62302568b8fa5c25a22db5bc" "f19d195fa336e9904303eea20aad35036b79cfde72fa6e76b7462706acd52920" "bce1c321471d37b875f99c83cb7b451fd8386001259e1c0909d6e078ea60f00b" "45482e7ddf47ab1f30fe05f75e5f2d2118635f5797687e88571842ff6f18b4d5" "938f120eeda938eef2c36b4cc9609d1ad91b3a3666cd63a4be5b70b739004942" "53de65a1e7300e0f1a4f8bf317530a5008e9d06a0e2f8863b80dc56d77f844cf" "a621dd9749f2651e357a61f8d8d2d16fb6cacde3b3784d02151952e1b9781f05" "1a2cde373eff9ffd5679957c7ecfc6249d353e1ee446d104459e73e924fe0d8a" "63aff36a40f41b28b0265ac506faa098fd552fac0a1813b745ba7c27efa5a943" "57d7e8b7b7e0a22dc07357f0c30d18b33ffcbb7bcd9013ab2c9f70748cfa4838" "d9e811d5a12dec79289c5bacaecd8ae393d168e9a92a659542c2a9bab6102041" "11e5e95bd3964c7eda94d141e85ad08776fbdac15c99094f14a0531f31a156da" "880f541eabc8c272d88e6a1d8917fe743552f17cedd8f138fe85987ee036ad08" "76935a29af65f8c915b1b3b4f6326e2e8d514ca098bd7db65b0caa533979fc01" "62a6731c3400093b092b3837cff1cb7d727a7f53059133f42fcc57846cfa0350" "0f302165235625ca5a827ac2f963c102a635f27879637d9021c04d845a32c568" "2047464bf6781156ebdac9e38a17b97bd2594b39cfeaab561afffcbbe19314e2" "aae40caa1c4f1662f7cae1ebfbcbb5aa8cf53558c81f5bc15baefaa2d8da0241" "aaf783d4bfae32af3e87102c456fba8a85b79f6e586f9911795ea79055dee3bf" "9d9b2cf2ced850aad6eda58e247cf66da2912e0722302aaa4894274e0ea9f894" "ec0c9d1715065a594af90e19e596e737c7b2cdaa18eb1b71baf7ef696adbefb0" "5c5de678730ceb4e05794431dd65f30ffe9f1ed6c016fa766cdf909ba03e4df4" "b6f06081b007b57be61b82fb53f27315e2cf38fa690be50d6d63d2b62a408636" "995d0754b79c4940d82bd430d7ebecca701a08631ec46ddcd2c9557059758d33" "70b2d5330a8dd506accac4b51aaa7e43039503d000852d7d152aec2ce779d96d" "011d4421eedbf1a871d1a1b3a4d61f4d0a2be516d4c94e111dfbdc121da0b043" "6b4f7bde1ce64ea4604819fe56ff12cda2a8c803703b677fdfdb603e8b1f8bcb" "6c0d748fb584ec4c8a0a1c05ce1ae8cde46faff5587e6de1cc59d3fc6618e164" "335ad769bcd7949d372879ec10105245255beec6e62213213835651e2eb0b8e0" "4bcdfc98cf64ce6145684dc8288fd87489cfa839e07f95f6c791d407624d04f8" "31772cd378fd8267d6427cec2d02d599eee14a1b60e9b2b894dd5487bd30978e" "8e7044bfad5a2e70dfc4671337a4f772ee1b41c5677b8318f17f046faa42b16b" "b5cff93c3c6ed12d09ce827231b0f5d4925cfda018c9dcf93a2517ce3739e7f1" "3ed2e1653742e5059e3d77af013ee90c1c1b776d83ec33e1a9ead556c19c694b" "1f126eb4a1e5d6b96b3faf494c8c490f1d1e5ad4fc5a1ce120034fe140e77b88" "cb39485fd94dabefc5f2b729b963cbd0bac9461000c57eae454131ed4954a8ac" "0ca71d3462db28ebdef0529995c2d0fdb90650c8e31631e92b9f02bd1bfc5f36" "fc1137ae841a32f8be689e0cfa07c872df252d48426a47f70dba65f5b0f88ac4" "aad7fd3672aad03901bf91e338cd530b87efc2162697a6bef79d7f8281fd97e3" "fe349b21bb978bb1f1f2db05bc87b2c6d02f1a7fe3f27584cd7b6fbf8e53391a" "b4fd44f653c69fb95d3f34f071b223ae705bb691fb9abaf2ffca3351e92aa374" "9a3c51c59edfefd53e5de64c9da248c24b628d4e78cc808611abd15b3e58858f" "09feeb867d1ca5c1a33050d857ad6a5d62ad888f4b9136ec42002d6cdf310235" "a455366c5cdacebd8adaa99d50e37430b0170326e7640a688e9d9ad406e2edfd" "f831c1716ebc909abe3c851569a402782b01074e665a4c140e3e52214f7504a0" "ed92c27d2d086496b232617213a4e4a28110bdc0730a9457edf74f81b782c5cf" "5eb4b22e97ddb2db9ecce7d983fa45eb8367447f151c7e1b033af27820f43760" "4c8372c68b3eab14516b6ab8233de2f9e0ecac01aaa859e547f902d27310c0c3" "8530b2f7b281ea6f263be265dd8c75b502ecd7a30b9a0f28fa9398739e833a35" "1a094b79734450a146b0c43afb6c669045d7a8a5c28bc0210aba28d36f85d86f" "3fe4861111710e42230627f38ebb8f966391eadefb8b809f4bfb8340a4e85529" "5c83b15581cb7274085ba9e486933062652091b389f4080e94e4e9661eaab1aa" "da8e6e5b286cbcec4a1a99f273a466de34763eefd0e84a41c71543b16cd2efac" "77515a438dc348e9d32310c070bfdddc5605efc83671a159b223e89044e4c4f1" "a513bb141af8ece2400daf32251d7afa7813b3a463072020bb14c82fd3a5fe30" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "59e82a683db7129c0142b4b5a35dbbeaf8e01a4b81588f8c163bd255b76f4d21" "24fc62afe2e5f0609e436aa2427b396adf9a958a8fa660edbaab5fb13c08aae6" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "d8dc153c58354d612b2576fea87fe676a3a5d43bcc71170c62ddde4a1ad9e1fb" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "3cd4f09a44fe31e6dd65af9eb1f10dc00d5c2f1db31a427713a1784d7db7fdfc" "565aa482e486e2bdb9c3cf5bfb14d1a07c4a42cfc0dc9d6a14069e53b6435b56" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" "585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "08a89acffece58825e75479333109e01438650d27661b29212e6560070b156cf" "0bff60fb779498e69ea705825a2ca1a5497a4fccef93bf3275705c2d27528f2f" "04589c18c2087cd6f12c01807eed0bdaa63983787025c209b89c779c61c3a4c4" "ae3a3bed17b28585ce84266893fa3a4ef0d7d721451c887df5ef3e24a9efef8c" "8dc7f4a05c53572d03f161d82158728618fb306636ddeec4cce204578432a06d" "b135596aa34a746437e2f55c65053803ae0fa1d73d32bdcf77af1ca33e32d2c7" "d1ba97c2fbdcbdaa73c93ae92763c0ee3d5aec401aa4bd99a6bd1688aed43ce4" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
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
    (arduino-mode org-plus-contrib magit git-messenger git-walktree git-commit-insert-issue git-commit arduino-cli-mode artbollocks-mode cyberpunk-theme color-theme-modern madhat2r-theme monochrome-theme mood-one-theme night-owl-theme nimbus-theme noctilux-theme northcode-theme nova-theme nyx-theme org-beautify-theme overcast-theme paganini-theme plan9-theme planet-theme reykjavik-theme seti-theme soothe-theme sorcery-theme warm-night-theme zen-and-art-theme zerodark-theme zweilight-theme calmer-forest-theme bug-hunter auto-compile ag all-the-icons auto-package-update autopair bash-completion clang-format color-theme company-rtags counsel counsel-projectile csharp-mode diminish doom-modeline dumb-jump el-get eldoc-eval elpy exec-path-from-shell exotica-theme f flycheck flycheck-rtags flycheck-swiftx flymake-cursor flymake-shell flymake-shell focus fold-dwim forecast google-maps google-this haml-mode helm-rtags hl-sentence idle-require irony irony-eldoc ivy ivy-rtags ivy-xref jedi jedi-core jedi-direx jenkins-watch jinja2-mode let-alist live-py-mode markdown-mode metar mo-git-blame modern-cpp-font-lock multiple-cursors nose on-screen ox-html5slide ox-minutes ox-reveal ox-tufte projectile pydoc reveal-in-osx-finder rtags selectric-mode shrink-whitespace smart-compile sos speech-tagger sphinx-doc spotify sublimity super-save swift-helpful swift-mode swift-playground-mode swiper ten-hundred-mode theme-changer use-package vagrant virtualenv wordsmith-mode writegood-mode writeroom-mode xkcd xterm-color yafolding yaml-mode ycmd)))
 '(python-fill-docstring-style (quote pep-257-nn)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))) t)
 '(flymake-warnline ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold))) t)
 '(org-document-info ((t (:foreground "blue"))))
 '(org-document-title ((t (:foreground "blue" :weight bold)))))

(provide 'custom-settings)
;;; custom-settings.el ends here
