;;; early-init.el --- À la carte -*- lexical-binding: t; -*-

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

;; https://github.com/nix-community/emacs-overlay/issues/497
(setopt package-archives nil)

(setopt custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t)

(setopt frame-inhibit-implied-resize t)
(setopt inhibit-compacting-font-caches t)

(modify-all-frames-parameters (list (cons 'menu-bar-lines 0)
                                    (cons 'tool-bar-lines 0)
                                    (cons 'vertical-scroll-bars nil)))
(setopt menu-bar-mode nil
        tool-bar-mode nil
        scroll-bar-mode nil)

(provide 'early-init)
;;; early-init.el ends here
