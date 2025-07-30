(defun ossian/defer-gc ()
  (setq gc-cons-threshold most-positive-fixnum)
  (setq gc-cons-percentage 1.0))

(defun ossian/resume-gc-now ()
  (setq gc-cons-threshold (* 1024 1024 32)) ; 32 MiB
  (setq gc-cons-percentage 0.1))

(defun ossian/resume-gc-soon ()
  (run-at-time 1 nil #'ossian/resume-gc-now))

;; Defer garbage collection during startup.
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 1.0)

;; Resume garbage collection after startup.
(add-hook 'emacs-startup-hook #'ossian/resume-gc-soon)

;; Don't compact font caches during garbage collection.
(setq inhibit-compacting-font-caches t)

;; Compile elc files asynchronously.
(setq native-comp-jit-compilation t)

;; Don't make installed packages available automatically.
(setq package-enable-at-startup nil)

;; Don't implicitly preserve the number of columns or lines
;; a frame displays by resizing it.
(setq frame-inhibit-implied-resize t)

;; Disable GTK interface elements.
(fringe-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Don't create default Emacs startup screen.
(setq inhibit-startup-screen t)
(advice-add 'display-startup-screen
	    :override #'ignore)

;; Empty initial scratch message.
(setq initial-scratch-message nil)
