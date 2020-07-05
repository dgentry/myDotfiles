;;; package -- my init.el
;;;
;;; Commentary:
;;;     This commentary is only here to shut up some flychecker thing.
;;; Code:
;;;     Same with this "Code:"

;; Not sure why this would be necessary.  Can't emacs figure out where
;; it loaded the init file from?
;(defconst my-init-dir "~/.emacs.d/init.d")

;; This adds just one directory to the path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; This would add directories recursively
;(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
;  (normal-top-level-add-subdirs-to-load-path))

(require 'spud)

;; Start emacs server.  I don't think this actually works since I seem
;; to have to start a server myself every time.
(require 'server)
(unless (server-running-p)
  (server-start))
;; For the ChromeOS Edit with Emacs extension
;;(require 'edit-server)
;;(edit-server-start)
  ;; (set-selection-coding-system 'compound-text-with-extensions)
;;  (menu-bar-mode t))

;; Without this, when defadvice redefines a function, emacs reports the
;; redefiniton in my startup messages, which is annoying.
(setq ad-redefinition-action 'accept)

;;
;; Package Stuff
;;

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ;("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
			 ;("marmalade" . "http://marmalade-repo.org/packages/")
			 ("elpy" . "https://jorgenschaefer.github.io/packages/")))

;; Still (4 July 2020) necessary?
;(add-to-list 'package-pinned-packages '(rtags . "melpa-stable") t)
;(add-to-list 'package-pinned-packages '(ivy-rtags . "melpa-stable") t)

(eval-when-compile (package-initialize))

;; Comment out if you've already loaded this package...
(require 'cl)

(defun require-package (package)
  "Refresh archives, check PACKAGE presence and install if it's not installed."
  (if (null (require package nil t))
      (progn (let* ((ARCHIVES (if (null package-archive-contents)
                                  (progn (package-refresh-contents)
                                         package-archive-contents)
                                package-archive-contents))
                    (AVAIL (assoc package ARCHIVES)))
               (if AVAIL
                   (package-install package)))
             (require package))))

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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (wheatgrass manoj-dark)))
 '(custom-safe-themes
   (quote
    ("7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "d8a7a7d2cffbc55ec5efbeb5d14a5477f588ee18c5cddd7560918f9674032727" "72c530c9c8f3561b5ab3bf5cda948cd917de23f48d9825b7a781fe1c0d737f2f" "fb09acc5f09e521581487697c75b71414830b1b0a2405c16a9ece41b2ae64222" "0e8c264f24f11501d3f0cabcd05e5f9811213f07149e4904ed751ffdcdc44739" "a02c000c95c43a57fe1ed57b172b314465bd11085faf6152d151385065e0e4b1" "cdc2a7ba4ecf0910f13ba207cce7080b58d9ed2234032113b8846a4e44597e41" "e26e879d250140e0d4c4d5ab457c32bcb29742599bd28c1ce31301344c6f2a11" "deb7ae3a735635a85c984ece4ce70317268df6027286998b0ea3d10f00764c9b" "0973b33d2f15e6eaf88400eee3dc8357ad8ae83d2ca43c125339b25850773a70" "abd7719fd9255fcd64f631664390e2eb89768a290ee082a9f0520c5f12a660a8" "1127f29b2e4e4324fe170038cbd5d0d713124588a93941b38e6295a58a48b24f" "b71da830ae97a9b70d14348781494b6c1099dbbb9b1f51494c3dfa5097729736" "ff8c6c2eb94e776c9eed9299a49e07e70e1b6a6f926dec429b99cf5d1ddca62a" "701b4b4e7989329a0704b92fc17e6600cc18f9df4f2466617ec91c932b5477eb" "4e7e04c4b161dd04dc671fb5288e3cc772d9086345cb03b7f5ed8538905e8e27" "6a674ffa24341f2f129793923d0b5f26d59a8891edd7d9330a258b58e767778a" "ff6a8955945028387ed1a2b0338580274609fbb0d40cd011b98ca06bd00d9233" "daeaa8249f0c275de9e32ed822e82ff40457dabe07347fe06afc67d962a3b1e9" "b48599e24e6db1ea612061252e71abc2c05c05ac4b6ad532ad99ee085c7961a7" "c51e302edfe6d2effca9f7c9a8a8cfc432727efcf86246002a3b45e290306c1f" "d422c7673d74d1e093397288d2e02c799340c5dabf70e87558b8e8faa3f83a6c" "cc2f32f5ee19cbd7c139fc821ec653804fcab5fcbf140723752156dc23cdb89f" "a5a2954608aac5c4dcf9659c07132eaf0da25a8f298498a7eacf97e2adb71765" "68b847fac07094724e552eeaf96fa4c7e20824ed5f3f225cad871b8609d50ace" "1c10e946f9a22b28613196e4c02b6508970e3b34660282ec92d9a1c293ee81bb" "80a23d559a5c5343a0882664733fd2c9e039b4dbf398c70c424c8d6858b39fc5" "1342a81078bdac27f80b86807b19cb27addc1f9e4c6a637a505ae3ba4699f777" "44f5578eccb2cde3b196dfa86a298b75fe39ceff975110c091fa8c874c338b50" "2ea9afebc23cca3cd0cd39943b8297ce059e31cb62302568b8fa5c25a22db5bc" "f19d195fa336e9904303eea20aad35036b79cfde72fa6e76b7462706acd52920" "bce1c321471d37b875f99c83cb7b451fd8386001259e1c0909d6e078ea60f00b" "45482e7ddf47ab1f30fe05f75e5f2d2118635f5797687e88571842ff6f18b4d5" "938f120eeda938eef2c36b4cc9609d1ad91b3a3666cd63a4be5b70b739004942" "53de65a1e7300e0f1a4f8bf317530a5008e9d06a0e2f8863b80dc56d77f844cf" "a621dd9749f2651e357a61f8d8d2d16fb6cacde3b3784d02151952e1b9781f05" "1a2cde373eff9ffd5679957c7ecfc6249d353e1ee446d104459e73e924fe0d8a" "63aff36a40f41b28b0265ac506faa098fd552fac0a1813b745ba7c27efa5a943" "57d7e8b7b7e0a22dc07357f0c30d18b33ffcbb7bcd9013ab2c9f70748cfa4838" "d9e811d5a12dec79289c5bacaecd8ae393d168e9a92a659542c2a9bab6102041" "11e5e95bd3964c7eda94d141e85ad08776fbdac15c99094f14a0531f31a156da" "880f541eabc8c272d88e6a1d8917fe743552f17cedd8f138fe85987ee036ad08" "76935a29af65f8c915b1b3b4f6326e2e8d514ca098bd7db65b0caa533979fc01" "62a6731c3400093b092b3837cff1cb7d727a7f53059133f42fcc57846cfa0350" "0f302165235625ca5a827ac2f963c102a635f27879637d9021c04d845a32c568" "2047464bf6781156ebdac9e38a17b97bd2594b39cfeaab561afffcbbe19314e2" "aae40caa1c4f1662f7cae1ebfbcbb5aa8cf53558c81f5bc15baefaa2d8da0241" "aaf783d4bfae32af3e87102c456fba8a85b79f6e586f9911795ea79055dee3bf" "9d9b2cf2ced850aad6eda58e247cf66da2912e0722302aaa4894274e0ea9f894" "ec0c9d1715065a594af90e19e596e737c7b2cdaa18eb1b71baf7ef696adbefb0" "5c5de678730ceb4e05794431dd65f30ffe9f1ed6c016fa766cdf909ba03e4df4" "b6f06081b007b57be61b82fb53f27315e2cf38fa690be50d6d63d2b62a408636" "995d0754b79c4940d82bd430d7ebecca701a08631ec46ddcd2c9557059758d33" "70b2d5330a8dd506accac4b51aaa7e43039503d000852d7d152aec2ce779d96d" "011d4421eedbf1a871d1a1b3a4d61f4d0a2be516d4c94e111dfbdc121da0b043" "6b4f7bde1ce64ea4604819fe56ff12cda2a8c803703b677fdfdb603e8b1f8bcb" "6c0d748fb584ec4c8a0a1c05ce1ae8cde46faff5587e6de1cc59d3fc6618e164" "335ad769bcd7949d372879ec10105245255beec6e62213213835651e2eb0b8e0" "4bcdfc98cf64ce6145684dc8288fd87489cfa839e07f95f6c791d407624d04f8" "31772cd378fd8267d6427cec2d02d599eee14a1b60e9b2b894dd5487bd30978e" "8e7044bfad5a2e70dfc4671337a4f772ee1b41c5677b8318f17f046faa42b16b" "b5cff93c3c6ed12d09ce827231b0f5d4925cfda018c9dcf93a2517ce3739e7f1" "3ed2e1653742e5059e3d77af013ee90c1c1b776d83ec33e1a9ead556c19c694b" "1f126eb4a1e5d6b96b3faf494c8c490f1d1e5ad4fc5a1ce120034fe140e77b88" "cb39485fd94dabefc5f2b729b963cbd0bac9461000c57eae454131ed4954a8ac" "0ca71d3462db28ebdef0529995c2d0fdb90650c8e31631e92b9f02bd1bfc5f36" "fc1137ae841a32f8be689e0cfa07c872df252d48426a47f70dba65f5b0f88ac4" "aad7fd3672aad03901bf91e338cd530b87efc2162697a6bef79d7f8281fd97e3" "fe349b21bb978bb1f1f2db05bc87b2c6d02f1a7fe3f27584cd7b6fbf8e53391a" "b4fd44f653c69fb95d3f34f071b223ae705bb691fb9abaf2ffca3351e92aa374" "9a3c51c59edfefd53e5de64c9da248c24b628d4e78cc808611abd15b3e58858f" "09feeb867d1ca5c1a33050d857ad6a5d62ad888f4b9136ec42002d6cdf310235" "a455366c5cdacebd8adaa99d50e37430b0170326e7640a688e9d9ad406e2edfd" "f831c1716ebc909abe3c851569a402782b01074e665a4c140e3e52214f7504a0" "ed92c27d2d086496b232617213a4e4a28110bdc0730a9457edf74f81b782c5cf" "5eb4b22e97ddb2db9ecce7d983fa45eb8367447f151c7e1b033af27820f43760" "4c8372c68b3eab14516b6ab8233de2f9e0ecac01aaa859e547f902d27310c0c3" "8530b2f7b281ea6f263be265dd8c75b502ecd7a30b9a0f28fa9398739e833a35" "1a094b79734450a146b0c43afb6c669045d7a8a5c28bc0210aba28d36f85d86f" "3fe4861111710e42230627f38ebb8f966391eadefb8b809f4bfb8340a4e85529" "5c83b15581cb7274085ba9e486933062652091b389f4080e94e4e9661eaab1aa" "da8e6e5b286cbcec4a1a99f273a466de34763eefd0e84a41c71543b16cd2efac" "77515a438dc348e9d32310c070bfdddc5605efc83671a159b223e89044e4c4f1" "a513bb141af8ece2400daf32251d7afa7813b3a463072020bb14c82fd3a5fe30" "ab04c00a7e48ad784b52f34aa6bfa1e80d0c3fcacc50e1189af3651013eb0d58" "59e82a683db7129c0142b4b5a35dbbeaf8e01a4b81588f8c163bd255b76f4d21" "24fc62afe2e5f0609e436aa2427b396adf9a958a8fa660edbaab5fb13c08aae6" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "d8dc153c58354d612b2576fea87fe676a3a5d43bcc71170c62ddde4a1ad9e1fb" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "3cd4f09a44fe31e6dd65af9eb1f10dc00d5c2f1db31a427713a1784d7db7fdfc" "565aa482e486e2bdb9c3cf5bfb14d1a07c4a42cfc0dc9d6a14069e53b6435b56" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" "585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "08a89acffece58825e75479333109e01438650d27661b29212e6560070b156cf" "0bff60fb779498e69ea705825a2ca1a5497a4fccef93bf3275705c2d27528f2f" "04589c18c2087cd6f12c01807eed0bdaa63983787025c209b89c779c61c3a4c4" "ae3a3bed17b28585ce84266893fa3a4ef0d7d721451c887df5ef3e24a9efef8c" "8dc7f4a05c53572d03f161d82158728618fb306636ddeec4cce204578432a06d" "b135596aa34a746437e2f55c65053803ae0fa1d73d32bdcf77af1ca33e32d2c7" "d1ba97c2fbdcbdaa73c93ae92763c0ee3d5aec401aa4bd99a6bd1688aed43ce4" default)))
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
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (req-package let-alist el-get ace-window ag all-the-icons auto-package-update autopair bash-completion clang-format color-theme counsel counsel-projectile csharp-mode diminish doom-modeline dumb-jump eldoc-eval elpy exec-path-from-shell exotica-theme f flycheck flycheck-rtags flymake-cursor flymake-shell flymake-shell focus fold-dwim forecast git google-maps google-this haml-mode hl-sentence idle-require irony irony-eldoc ivy ivy-rtags ivy-xref jedi jedi-core jedi-direx jenkins-watch jinja2-mode live-py-mode markdown-mode metar mo-git-blame modern-cpp-font-lock multiple-cursors nose on-screen ox-html5slide ox-minutes ox-reveal ox-tufte projectile pydoc reveal-in-osx-finder rtags selectric-mode shrink-whitespace smart-compile sos speech-tagger sphinx-doc spotify sublimity super-save swiper ten-hundred-mode theme-changer use-package vagrant virtualenv wordsmith-mode writegood-mode writeroom-mode xkcd xterm-color yafolding yaml-mode ycmd)))
 '(python-fill-docstring-style (quote pep-257-nn))
 '(vc-annotate-background "#f6f0e1")
 '(vc-annotate-color-map
   (quote
    ((20 . "#e43838")
     (40 . "#f71010")
     (60 . "#ab9c3a")
     (80 . "#9ca30b")
     (100 . "#ef8300")
     (120 . "#958323")
     (140 . "#1c9e28")
     (160 . "#3cb368")
     (180 . "#028902")
     (200 . "#008b45")
     (220 . "#077707")
     (240 . "#259ea2")
     (260 . "#358d8d")
     (280 . "#0eaeae")
     (300 . "#2c53ca")
     (320 . "#1111ff")
     (340 . "#2020cc")
     (360 . "#a020f0"))))
 '(vc-annotate-very-old-color "#a020f0"))

;; This is supposed to load all packages in the list, but it fails if
;; package-refresh-contents hasn't finished.  You can hand-run the
;; (Packagex-refresh-contents) and then run this to load everything.
(dolist (package package-selected-packages)
   (unless (package-installed-p package)
     (package-install package)))

;(load-theme 'dg-bigbook-board t)

(unless (package-installed-p 'org)  ;; Make sure the Org package is
  (package-install 'org))           ;; installed, install it if not
;; (setq org-...)                   ;; Your custom settings

(require-package 'use-package)
(require 'use-package)
(setq use-package-always-ensure t)

;; Auto update packages (default is every 7 days)
(use-package auto-package-update
             :config
             (setq auto-package-update-delete-old-versions t)
	     (setq auto-package-update-prompt-before-update t)
	     (auto-package-update-at-time "02:27")
	     (add-hook 'auto-package-update-before-hook
		       (lambda () (message "Auto-updating packages now.")))
             (auto-package-update-maybe))

(use-package req-package
  :ensure t
  :config (req-package--log-set-level 'debug))

(use-package ag)
(use-package f)

(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))

;; Comment out if you've already loaded this package...
;(require 'cl)


;;
;; Keyboard, Mouse, and Window Stuff
;;

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
;(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Make the mouse work in emacs and iterm2
(require 'mwheel)
(require 'mouse)
(xterm-mouse-mode t)
(mouse-wheel-mode t)

;; Get rid of the damn menu bar
(menu-bar-mode -1)

(when window-system
  ;; enable wheelmouse support by default
  (mwheel-install)
  ;; use extended compound-text coding for X clipboard
  (set-selection-coding-system 'compound-text-with-extensions))

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq frame-title-format  "")
(setq icon-title-format  "")


;;
;; File Stuff
;;

;; Never use tabs for indenting.
(setq indent-tabs-mode nil)

;; always end files with a newline
(setq require-final-newline t)

;; stop at the end of the file instead of just adding lines
(setq next-line-add-newlines nil)

;;
;; How Files Display Stuff
;;

;; turn on font-lock (syntax highlighting) mode
(global-font-lock-mode t)

;; disable visual feedback on selections, because damn it's annoying.
(setq-default transient-mark-mode nil)

; Deal with whitespace
(setq show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; I wonder if this file is still there at google?
;(load-file "/home/build/public/google/util/google.el")

(require 'timestomp)
(global-set-key [C-ct] 'insert-timestomp)
;(global-set-key "\C-ct" 'insert-timestomp)
(global-set-key "\C-c;" 'comment-region)

(defun other-window-backward (&optional n)
  "Select the Nth previous window."
  (interactive "p")
  (if n
      (other-window (- n))  ;if n is non-nil
    (other-window (- n))))  ;if n is nil

(global-set-key [C-xC-p] 'other-window-backward)

(defun eval-current-buffer ()
  "Old name, I guess."
  (interactive)
  (eval-buffer))

(require 'arduino-mode)

; Flymake colors for dark background
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((((class color) (background light)) (:background "darkblue" :foreground "grey" :weight bold))) t)
 '(flymake-warnline ((((class color) (background light)) (:background "darkblue" :foreground "black" :weight bold))) t)
 '(font-lock-comment-face ((t (:foreground "red"))))
 '(font-lock-string-face ((t (:foreground "color-163"))))
 '(makefile-space ((t (:background "color-236"))))
 '(mode-line ((t (:background "#002000" :foreground "gray80" :box 1 :weight bold :height 0.9))))
 '(mode-line-buffer-id ((t (:background "#008700" :foreground "gray95" :weight bold :height 0.9))))
 '(org-document-info ((t (:foreground "blue"))))
 '(org-document-title ((t (:foreground "blue" :weight bold)))))


(require 'flymake-cursor)

(global-set-key "\C-cn" 'flymake-goto-next-error)
(global-set-key "\C-cp" 'flymake-goto-previous-error)

;(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(defun eval-current-buffer ()
  "Old name, I guess."
  (interactive)
  (eval-buffer))

;; Auto modes based on file extensions
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;
;; Fix goddamn dark dark blue color in syntax highlighting
;;
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/lisp/color-theme-6.6.0/themes")

;; Hack to make something work after make-variable-frame-local went away.
(when (not (fboundp 'make-variable-frame-local))
  (defun make-variable-frame-local (variable) variable))

(require 'color-theme)
(eval-after-load "color-theme"
 '(progn
    (color-theme-initialize)
    (color-theme-gentrix)
    ;(color-theme-cathode)
    ))

;; I guess color themes are "obsolete" but whatever has replaced them
;; isn't any easier to figure out.
(setq my-color-themes (list
		       'color-theme-cathode
		       'color-theme-gentrix
		       'color-theme-arjen
		       'color-theme-billw
		       'color-theme-simple-1
		       'color-theme-calm-forest
		       'color-theme-goldenrod
		       'color-theme-clarity
		       'color-theme-comidia
		       'color-theme-jsc-dark
		       'color-theme-dark-green
		       'color-theme-dark-laptop
		       'color-theme-euphoria
		       'color-theme-hober
		       'color-theme-late-night
		       'color-theme-lawrence
		       'color-theme-lethe
		       'color-theme-ld-dark
		       'color-theme-matrix
		       'color-theme-midnight
		       'color-theme-oswald
		       'color-theme-renegade
		       'color-theme-retro-green
		       'color-theme-retro-orange
		       'color-theme-salmon-font-lock
		       'color-theme-subtle-hacker
		       'color-theme-taming-mr-arneson
		       'color-theme-taylor
		       'color-theme-tty-dark
		       'color-theme-pok-wob
		       'color-theme-word-perfect))


(defun my-theme-set-default ()
  "Choose the first row of my-color-themes."
  (interactive)
  (setq theme-current my-color-themes)
  (funcall (car theme-current)))

(defun my-describe-theme ()
  "Describe the current color theme."
  (interactive)
  (message "%s" (car theme-current)))

; Set the next theme
(defun my-theme-cycle ()
  "Cycle to the next color theme."
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
      (setq theme-current my-color-themes))
  (funcall (car theme-current))
  (message "%S" (car theme-current)))

(setq theme-current my-color-themes)
(setq color-theme-is-global nil) ; Initialization
;(my-theme-set-default)
(global-set-key "\C-c," 'my-theme-cycle)

(add-hook 'html-mode-hook
        (lambda ()
          ;; Default indentation is usually 2 spaces, changing to 4.
          (set (make-local-variable 'sgml-basic-offset) 4)))

;;
;; Org mode stuff
;;
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
; (add-hook 'org-mode-hook '(local-set-key "\C-ct" 'org-todo))
(add-hook 'org-mode-hook
          (lambda () (local-set-key (kbd "C-ct") #'org-todo)))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(setq org-startup-indented t)  ; Cleaner Outline View
                               ; Don't require repetitive stars for sub-trees

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-log-done t)
(setq org-todo-keywords
      '((sequence "TODO" "STARTED" "WAITING" "DONE")))
(setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("computer" . ?l) ("phone" . ?p) ("reading" . ?r)))

(define-key global-map "\e+" 'update-time-stamp)

;; Reveal.js + Org mode
(require 'ox-reveal)
(setq org-reveal-root "file:///Users/gentry/myDotfiles/reveal.js/")
(setq org-reveal-title-slide nil)

;;
;; Programming Stuff
;;

(autoload 'git-status "git" "Entry point into git-status mode." t)

;; Tags (specifically ExuberantCtags now) stuff
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

(require 'smart-compile)

(require 'flycheck)
;; Maybe only one of the following?
(global-flycheck-mode 1)
(add-hook 'after-init-hook #'global-flycheck-mode)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(require 'dumb-jump)
(dumb-jump-mode)
;(setq dumb-jump-default-project "~/Projects

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
(c-add-style "gentry"
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
;; automatically get gentry coding style.


;;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-mode))


(add-hook 'c-mode-common-hook
	  (function
	   (lambda nil
	     (if (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
		 (c-set-style "gentry"))
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

;;; Flycheck
(req-package flycheck
             :config
             (progn
               (global-flycheck-mode)))

;; Live code checking.
(req-package flycheck-rtags
  :require flycheck rtags
  :config
  (progn
    ;; ensure that we use only rtags checking
    ;; https://github.com/Andersbakken/rtags#optional-1
    (defun setup-flycheck-rtags ()
      (rtags-xref-enable)
      (flycheck-select-checker 'rtags)
      (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
      (setq-local flycheck-check-syntax-automatically nil)
      (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
      )
    (add-hook 'c-mode-hook #'setup-flycheck-rtags)
    (add-hook 'c++-mode-hook #'setup-flycheck-rtags)
    (add-hook 'objc-mode-hook #'setup-flycheck-rtags)
    ))
;;;;;;;;;;;;;;;;;;;;;;;;;

;(rtags-enable-standard-keybindings)
;(setq rtags-display-result-backend 'ivy)
;(setq rtags-completions-enabled t)

; (define-key c-mode-base-map (kbd "M-.") (function rtags-find-symbol-at-point))
; (define-key c-mode-base-map (kbd "M-,") (function rtags-find-references-at-point))

;;(require 'company)
(req-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    ;; was "M-/"
    (global-set-key [C-tab] 'company-complete-common-or-cycle)
    (setq company-idle-delay 0)))

;; (push 'company-rtags company-backends)

;; (global-company-mode)

;; Cquery, I guess.
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

  ;; Use company for code completion.
  (req-package company-irony
    :require company irony
    :config
    (progn
      (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

  ;; Use flycheck for real-time syntax checking.
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

;;
;; Python stuff
;;
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
;; Or is it this one?
(require 'my-python-setup)
(require 'live-py-mode)

; (flycheck-define-checker python-prospector
;   "A Python syntax and style checker using Prospector.
; See URL `http://prospector.readthedocs.org/en/latest/index.html'."
;   :command ("prospector" "-s" "medium" "--profile-path" "/Users/gentry/tpg-code/metrics" "--profile" "tpg-prospector" "--max-line-length" "99" "-M" "-o" "emacs" source-inplace)
;   :error-patterns
;   ((error line-start
;           (file-name) ":" (one-or-more digit) " :" (one-or-more digit) ":" (optional "\r") "\n"
;           (one-or-more " ") "L" line ":" column " "
;           (message (minimal-match (one-or-more not-newline)) "E" (one-or-more digit) (optional "\r") "\n"
;                    (one-or-more not-newline) (optional "\r") "\n" line-end))
;    (warning line-start
;           (file-name) ":" (one-or-more digit) " :" (one-or-more digit) ":" (optional "\r") "\n"
;           (one-or-more " ") "L" line ":" column " "
;           (message (minimal-match (one-or-more not-newline)) "D" (one-or-more digit) (optional "\r") "\n"
;                    (one-or-more not-newline)) (optional "\r") "\n" line-end)
;    (warning line-start
;           (file-name) ":" (one-or-more digit) " :" (one-or-more digit) ":" (optional "\r") "\n"
;           (one-or-more " ") "L" line ":" column
;           (message (minimal-match (one-or-more not-newline)) (not digit) (one-or-more digit) (optional "\r") "\n"
;                    (one-or-more not-newline)) (optional "\r") "\n" line-end))

;   :modes python-mode)
;(add-to-list 'flycheck-checkers 'python-prospector)


;;(require 'exec-path-from-shell)
;;(when (memq window-system '(mac ns x))
;;  (exec-path-from-shell-initialize)
;;  (exec-path-from-shell-copy-envq "PKG_CONFIG_PATH")
;;  (exec-path-from-shell-copy-env "IDF_PATH"))

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
;;(yas-global-mode 1)

;; Diminish
;; (require 'diminish)
;; (diminish 'irony-mode)
;; (diminish 'flycheck-mode)
;; (diminish 'company-mode)
;; (diminish 'ivy-mode)
;; (diminish 'abbrev-mode)
;; (diminish 'eldoc-mode)
;; (diminish 'yas-minor-mode)

;; ace-window
(require 'ace-window)
(global-set-key (kbd "C-x o") 'ace-window)

(defun projectile-compile-project--save-project-buffers (arg)
  "Ignore ARG."
  (projectile-save-project-buffers))

(advice-add 'projectile-compile-project :before #'projectile-compile-project--save-project-buffers)

;; multiple cursors
(require-package 'multiple-cursors)
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
(setq my-themes '(calmer-forest klere nyx))
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

(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")
(set-face-foreground 'highlight nil)

;; XTERM 256 color
;; (Don't forget to "setenv TERM xterm-256color")
(use-package xterm-color
  :ensure t
  :config
  (progn (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter)
       (setq comint-output-filter-functions (remove 'ansi-color-process-output comint-output-filter-functions))))

(use-package eshell
  :ensure t
  :config 	     
  (add-hook 'eshell-mode-hook
	    (lambda () (setq xterm-color-preserve-properties t))))

; Colorize compilation buffer
;(require 'ansi-color)
;(defun colorize-compilation-buffer ()
;  "Uh."
;  (read-only-mode nil)
;  (ansi-color-apply-on-region compilation-filter-start (point))
;  (read-only-mode t))
;(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(provide 'init)
;;; init.el ends here
