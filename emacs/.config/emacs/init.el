;;; init.el --- À la carte -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ossian Winter

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

(require 'use-package)

(defun ossian/read-file-contents (file)
  (and (file-exists-p file)
       (with-temp-buffer
         (insert-file-contents file)
         (read (current-buffer)))))

(setopt use-package-always-defer t)
(setopt use-package-always-ensure t)
(setopt use-package-expand-minimally t)

(use-package emacs
  :custom
  (enable-recursive-minibuffers t)
  (gc-cons-threshold (* 1024 (* 1024 32)))
  ;; @Todo: This will break on non-GNU/Linux systems.
  (read-process-output-max (ossian/read-file-contents "/proc/sys/fs/pipe-max-size")))

(use-package mule-cmds
  :ensure nil
  :no-require t
  :init
  (set-language-environment "UTF-8")
  (setopt default-input-method nil))

(use-package startup
  :ensure nil
  :no-require t
  :custom
  (user-full-name "Ossian Winter")
  (user-mail-address "ossian@winter.vg"))

(use-package files
  :ensure nil
  :custom
  (make-backup-files nil)
  (find-file-visit-truename t))

(use-package simple
  :ensure nil
  :custom
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package server
  :ensure nil
  :demand t
  :config
  (unless (bound-and-true-p server-process)
    (server-start)))

(use-package frame
  :ensure nil
  :demand t
  :config
  (blink-cursor-mode -1))

(use-package window
  :ensure nil
  :custom
  (quit-window-kill-buffer t))

(use-package which-key
  :ensure nil
  :demand t
  :config
  (which-key-mode +1))

(use-package time
  :ensure nil
  :demand t
  :custom
  (display-time-default-load-average nil)
  :config
  (display-time-mode +1))

(use-package package
  :ensure nil
  :custom
  (package-archives
   '(("gnu"    . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa"  . "https://melpa.org/packages/")))
  (package-archive-priorities
   '(("gnu"    . 90)
     ("nongnu" . 80)
     ("melpa"  . 70))))

(use-package doom-modeline
  :demand t
  :config
  (doom-modeline-mode +1))

(use-package modus-themes
  :demand t
  :config
  (modus-themes-load-theme 'modus-vivendi))

(use-package vertico
  :demand t
  :config
  (vertico-mode +1))

(use-package marginalia
  :demand t
  :config
  (marginalia-mode +1))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package embark
  :bind
  (("C-;" . embark-act)
   ("C-:" . embark-dwim)))

(use-package embark-consult
  :after (embark consult))

(use-package consult
  :custom
  (xref-show-xrefs-function       #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  :bind
  (("M-y" . consult-yank-pop)
   :map goto-map           ("g"   . consult-goto-line)
   :map goto-map           ("M-g" . consult-goto-line)
   :map search-map         ("g"   . consult-ripgrep)
   :map search-map         ("f"   . consult-fd)
   :map ctl-x-map          ("M-:" . consult-complex-command)
   :map ctl-x-map          ("b"   . consult-buffer)
   :map ctl-x-4-map        ("b"   . consult-buffer-other-window)
   :map ctl-x-5-map        ("b"   . consult-buffer-other-frame)
   :map tab-prefix-map     ("b"   . consult-buffer-other-tab)
   :map bookmark-map       ("b"   . consult-bookmark)
   :map project-prefix-map ("b"   . consult-project-buffer)))

(use-package avy
  :bind
  ("C-." . avy-goto-char-timer))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (magit-commit-show-diff nil)
  :init
  (with-eval-after-load 'project
    (add-to-list 'project-switch-commands '(magit-project-status "Magit") t))
  :bind
  ((:map ctl-x-map          ("g" . magit-status))
   (:map project-prefix-map ("m" . magit-project-status))))

(use-package forge)

(use-package eat)

(use-package filechooser
  :custom
  (filechooser-use-popup-frame nil))

(use-package app-launcher
  :vc (:url "https://github.com/emacs-exwm/xdg-launcher.git"))

(use-package ednc
  :demand t
  :config
  (ednc-mode +1))

(use-package bluetooth
  :if (equal system-name "ossian-laptop"))

(use-package exwm
  :demand t
  :if (eq window-system 'x)
  :custom
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([?\s-w] . exwm-workspace-switch)
     ([?\s-7] . app-launcher-run-app)
     ([?\s-&] . (lambda (cmd)
		  (interactive (list (read-shell-command "$ ")))
		  (start-process-shell-command cmd nil cmd)))))
  (exwm-input-simulation-keys
   '(;; char navigation
     ([?\C-p]   . [up])
     ([?\C-n]   . [down])
     ([?\C-b]   . [left])
     ([?\C-f]   . [right])
     ([?\C-d]   . [delete])
     ;; word navigation
     ([?\M-b]   . [C-left])
     ([?\M-f]   . [C-right])
     ;; line navigation
     ([?\C-a]   . [home])
     ([?\C-e]   . [end])
     ([?\C-k]   . [S-end delete])
     ;; scroll
     ([?\C-v]   . [next])
     ([?\M-v]   . [prior])
     ([?\C-w]   . [?\C-x])
     ([?\M-w]   . [?\C-c])
     ([?\C-y]   . [?\C-v])
     ([?\C-s]   . [?\C-f])))
  :config
  (exwm-wm-mode +1)
  :hook
  (exwm-update-class . (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
  (exwm-update-title . (lambda () (exwm-workspace-rename-buffer exwm-title))))

(provide 'init)
;;; init.el ends here
