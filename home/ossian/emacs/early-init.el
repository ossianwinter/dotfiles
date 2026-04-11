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

(push '(menu-bar-lines . 0) default-frame-alist)
(setopt menu-bar-mode nil)

(push '(tool-bar-lines . 0) default-frame-alist)
(setopt tool-bar-mode nil)

(push '(vertical-scroll-bars) default-frame-alist)
(setopt scroll-bar-mode nil)

(provide 'early-init)
;;; early-init.el ends here
