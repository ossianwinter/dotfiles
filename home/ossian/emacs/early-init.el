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

(setq frame-inhibit-implied-resize t)
(setq inhibit-compacting-font-caches t)

(push '(menu-bar-lines . 0) default-frame-alist)
(setq menu-bar-mode nil)

(push '(tool-bar-lines . 0) default-frame-alist)
(setq tool-bar-mode nil)

(push '(vertical-scroll-bars) default-frame-alist)
(setq scroll-bar-mode nil)

(provide 'early-init)
;;; early-init.el ends here
