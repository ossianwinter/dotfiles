;;; init.el --- À la carte -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ossian Winter

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

(defun ossian/read-file-contents (file)
  (and (file-exists-p file)
       (with-temp-buffer
         (insert-file-contents file)
         (read (current-buffer)))))

;;;; Core:

(unless (bound-and-true-p server-process) (server-start))

(setopt user-full-name    "Ossian Winter"
	user-mail-address "ossian@winter.vg")

(setopt gc-cons-threshold       (* 32 (* 1024 1024))
	read-process-output-max	(ossian/read-file-contents "/proc/sys/fs/pipe-max-size")) ; @Todo: This will break on non-GNU/Linux systems.

(set-language-environment "UTF-8")
(setopt default-input-method nil)

(setopt package-archives '(("gnu"    . "https://elpa.gnu.org/packages/")
			   ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			   ("melpa"  . "https://melpa.org/packages/"))
	package-archive-priorities '(("gnu"    . 90)
				     ("nongnu" . 80)
				     ("melpa"  . 70)))

(setopt use-package-always-defer     t
	use-package-always-ensure    t
	use-package-expand-minimally t)

;;;; Appearance:

(blink-cursor-mode -1)

(setopt display-time-default-load-average nil)
(display-time-mode +1)

(which-key-mode +1)

(setopt modus-themes-include-derivatives-mode t
	modus-themes-common-palette-overrides '((border-mode-line-active   nil)
						(border-mode-line-inactive nil)))

(use-package ef-themes
  :init
  (modus-themes-load-theme 'ef-autumn))

(use-package minions
  :init
  (minions-mode +1))

;;;; Buffers:

(setopt quit-window-kill-buffer t)

;;;; Files:

(setopt make-backup-files nil)

(setopt find-file-visit-truename t)

;;;; Editing:

(setq-default indent-tabs-mode nil)

(setopt org-default-notes-file                "~/org/notes.org"
	org-agenda-files                      '("~/org/notes.org")
	org-agenda-window-setup               'current-window
	org-agenda-restore-windows-after-quit t)

(use-package vundo
  :bind
  ((:map ctl-x-map ("u" . vundo))))

(use-package multiple-cursors
  :bind
  ((:map global-map        ("C->" . mc/mark-next-like-this))
   (:map global-map        ("C-<" . mc/mark-previous-like-this))
   (:map mode-specific-map ("C->" . mc/mark-all-like-this))
   (:map mode-specific-map ("C-<" . mc/mark-all-like-this))))

;;;; Navigation:

(repeat-mode +1)

(use-package consult
  :custom
  (xref-show-xrefs-function       #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  :bind
  ((:map global-map         ("M-y" . consult-yank-pop))
   (:map goto-map           ("g"   . consult-goto-line))
   (:map goto-map           ("M-g" . consult-goto-line))
   (:map search-map         ("g"   . consult-ripgrep))
   (:map search-map         ("f"   . consult-fd))
   (:map ctl-x-map          ("M-:" . consult-complex-command))
   (:map ctl-x-map          ("b"   . consult-buffer))
   (:map ctl-x-4-map        ("b"   . consult-buffer-other-window))
   (:map ctl-x-5-map        ("b"   . consult-buffer-other-frame))
   (:map tab-prefix-map     ("b"   . consult-buffer-other-tab))
   (:map bookmark-map       ("b"   . consult-bookmark))
   (:map project-prefix-map ("b"   . consult-project-buffer))))

(use-package embark
  :bind
  ((:map global-map ("C-;" . embark-act))
   (:map global-map ("C-:" . embark-dwim))))

(use-package embark-consult)

(use-package avy
  :bind
  ((:map global-map ("C-." . avy-goto-char-timer))))

;;;; Email:

(setopt gnus-select-method '( nnimap "bridge"
			      (nnimap-address     "127.0.0.1")
			      (nnimap-server-port 1143)
			      (nnimap-stream      starttls)))

(setopt smtpmail-smtp-server  "127.0.0.1"
	smtpmail-smtp-service 1025
	smtpmail-stream-type  'starttls)

(setopt message-send-mail-function 'smtpmail-send-it)

;;;; Security:

(setopt epg-pinentry-mode 'loopback)

(setopt auth-sources '("~/.authinfo.gpg"))
(auth-source-pass-enable)

;;;; Version control:

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

;;;; Completion:

(setopt enable-recursive-minibuffers t)

(setopt text-mode-ispell-word-completion nil)

(setopt completion-styles               '(orderless basic)
	completion-category-overrides   '((file (styles partial-completion)))
	completion-category-defaults    nil
	completion-pcm-leading-wildcard t)

(setopt read-extended-command-predicate #'command-completion-default-include-p)

(use-package orderless)

(use-package vertico
  :init
  (vertico-mode +1))

(use-package marginalia
  :init
  (marginalia-mode +1))

(use-package corfu
  :init
  (global-corfu-mode +1))

;;;; Misc:

(use-package eat
  :bind
  ((:map mode-specific-map  ("C-t" . eat))
   (:map project-prefix-map ("t"   . eat-project))))

(use-package bluetooth
  :if (equal system-name "ossian-laptop"))

(use-package filechooser
  :custom
  (filechooser-use-popup-frame nil))

(use-package xdg-launcher
  :vc (:url "https://github.com/emacs-exwm/xdg-launcher.git" :rev "ca774d0"))

(use-package ednc
  :init
  (ednc-mode +1))

(use-package exwm
  :if (eq window-system 'x)
  :preface
  (defun ossian/exwm-run-shell-command (cmd)
    (interactive (list (read-shell-command "$ ")))
    (start-process-shell-command cmd nil cmd))
  (defun ossian/exwm-rename-buffer-by-class ()
    (exwm-workspace-rename-buffer exwm-class-name))
  (defun ossian/exwm-rename-buffer-by-title ()
    (exwm-workspace-rename-buffer exwm-title))
  :custom
  (exwm-input-global-keys `(([?\s-r] . exwm-reset)
			    ([?\s-w] . exwm-workspace-switch)
			    ([?\s-7] . xdg-launcher-run-app)
			    ([?\s-&] . ossian/exwm-run-shell-command)))
  (exwm-input-simulation-keys '(;; char navigation
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
  :init
  (exwm-wm-mode +1)
  :hook
  (exwm-update-class . ossian/exwm-rename-buffer-by-class)
  (exwm-update-title . ossian/exwm-rename-buffer-by-title))

(provide 'init)
;;; init.el ends here
