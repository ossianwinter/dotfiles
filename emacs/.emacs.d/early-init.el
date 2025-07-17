(setq gc-cons-threshold  most-positive-fixnum
      gc-cons-percentage most-positive-fixnum)

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (* 100 1024 1024)
		  gc-cons-percentage 0.1)))

(setq custom-file null-device
      inhibit-startup-message t
      frame-inhibit-implied-resize t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
