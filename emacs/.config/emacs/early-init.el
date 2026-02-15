;;; early-init.el --- À la carte -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ossian Winter

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

(setq custom-file (locate-user-emacs-file "custom.el"))

(setq frame-inhibit-implied-resize t)

(push '(menu-bar-lines . 0) default-frame-alist)
(setq menu-bar-mode nil)

(push '(tool-bar-lines . 0) default-frame-alist)
(setq tool-bar-mode nil)

(push '(left-fringe . 0) default-frame-alist)
(push '(right-fringe . 0) default-frame-alist)
(setq fringe-mode nil)

(push '(vertical-scroll-bars) default-frame-alist)
(setq scroll-bar-mode nil)

(add-to-list 'default-frame-alist '(font . "Berkeley Mono-16"))

(provide 'early-init)
;;; early-init.el ends here
