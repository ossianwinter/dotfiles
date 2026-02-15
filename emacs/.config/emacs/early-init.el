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
