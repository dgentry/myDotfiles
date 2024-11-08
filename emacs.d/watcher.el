(defalias 'watcher-debug (apply-partially #'debug nil))
(add-variable-watcher 'projectile-project-compilation-cmd #'watcher-debug)
(add-variable-watcher 'compile-command #'watcher-debug)
;; (remove-variable-watcher 'cmake-ide-build-dir #'watcher-debug)
