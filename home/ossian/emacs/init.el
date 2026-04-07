;;; init.el --- À la carte -*- lexical-binding: t; -*-

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

;;;; Core:

(use-package use-package
  :preface
  (defun ossian/use-package-ensure-noop (&rest _) t)
  :custom
  (use-package-ensure-function #'ossian/use-package-ensure-noop)
  (use-package-expand-minimally t)
  (use-package-always-defer t))

(use-package alloc
  :custom (gc-cons-threshold (* 32 (* 1024 1024))))

(use-package process
  :custom (read-process-output-max (* 1024 1024)))

(use-package fns
  :custom (use-dialog-box nil))

(use-package startup
  :custom
  (user-full-name "Ossian Winter")
  (user-mail-address "ossian@winter.vg"))

(use-package server
  :preface
  (unless (fboundp #'server-running-p)
    (autoload #'server-running-p "server" nil t))
  :unless (server-running-p)
  :init (server-start))

(use-package mule-cmds
  :init
  (set-language-environment "UTF-8")
  (setopt default-input-method nil))

;;;; Appearance:

(use-package frame
  :if (display-graphic-p)
  :init (blink-cursor-mode -1))

(use-package faces
  :if (display-graphic-p)
  :init
  (set-face-attribute 'default nil
                      :family "IBM Plex Mono"
                      :height 140)
  (set-face-attribute 'variable-pitch nil
                      :family "IBM Plex Sans"))

(use-package fontset
  :if (display-graphic-p)
  :init (set-fontset-font t 'symbol "Symbola"))

(use-package darkman
  :ensure t
  :custom (darkman-themes '(:light leuven :dark leuven-dark))
  :init (darkman-mode +1))

;;;; Completion:

;;;; Minibuffer:

(use-package minibuf
  :custom (enable-recursive-minibuffers t))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

(use-package vertico
  :ensure t
  :init (vertico-mode +1))

(use-package marginalia
  :ensure t
  :init (marginalia-mode +1))

;;;; Navigation:

(use-package repeat
  :init (repeat-mode +1))

(use-package consult
  :ensure t
  :custom
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  :bind (("M-y" . consult-yank-pop)
         :map goto-map
         ("g" . consult-goto-line)
         ("M-g" . consult-goto-line)
         :map search-map
         ("g" . consult-grep)
         ("f" . consult-find)
         :map ctl-x-map ("b" . consult-buffer)))

;;;; Editing:

(use-package simple
  :custom
  (indent-tabs-mode nil)
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package vundo
  :ensure t
  :bind ( :map ctl-x-map ("u" . vundo)))

;;;; Files:

(use-package files
  :custom
  (make-backup-files nil)
  (find-file-visit-truename t))

;;;; Mail:

(use-package message
  :custom (message-send-mail-function 'smtpmail-send-it))

(use-package smtpmail
  :custom
  (smtpmail-smtp-server "smtp.fastmail.com")
  (smtpmail-smtp-service 465)
  (smtpmail-smtp-user "ossian@fastmail.com")
  (smtpmail-stream-type 'ssl))

(use-package gnus
  :custom
  (gnus-select-method '(nnnil ""))
  (gnus-secondary-select-methods
   '((nntp "Gmane"
           (nntp-address "news.gmane.io"))
     (nntp "Gwene"
           (nntp-address "news.gwene.org"))
     (nnimap "Personal"
             (nnimap-address "imap.fastmail.com")
             (nnimap-user "ossian@fastmail.com")
             (nnimap-stream tls))))
  (gnus-save-newsrc-file nil)
  (gnus-read-newsrc-file nil)
  (gnus-use-dribble-file nil)
  (gnus-use-cache t)
  :hook (gnus-group-mode . gnus-topic-mode))

;;;; Misc:

(use-package envrc
  :ensure t
  :init (envrc-global-mode))

(use-package auth-source-1password
  :ensure t
  :preface
  (defun ossian/auth-source-1password--construct-secret-reference
      (backend type host user port)
    (pcase `(,host ,user)
      (`(,(or `(,_ "imap.fastmail.com") "smtp.fastmail.com") "ossian@fastmail.com")
       "Personal/i7o5bqrpenxguh5psiaave5k7m/credential")
      (`(,(pred stringp) ,(pred stringp))
       (auth-source-1password--1password-construct-entry-path
        backend type host user port))
      (_ nil)))
  :custom (auth-source-1password-construct-secret-reference #'ossian/auth-source-1password--construct-secret-reference)
  :commands auth-source-1password-enable
  :init (auth-source-1password-enable))

(use-package magit
  :ensure t
  :init (with-eval-after-load 'project
          (add-to-list 'project-switch-commands '(magit-project-status "Magit") t))
  :bind ( :map ctl-x-map ("g" . magit-status)
          :map project-prefix-map ("m" . magit-project-status)))

(use-package vterm
  :ensure t
  :preface
  ;; https://mocompute.codeberg.page/item/2024/2024-09-03-emacs-project-vterm.html
  (defun ossian/project-shell ()
    (interactive)
    (let* ((default-directory (project-root (project-current t)))
           (default-project-shell-name (project-prefixed-buffer-name "shell"))
           (shell-buffer (get-buffer default-project-shell-name)))
      (if (and shell-buffer (not current-prefix-arg))
          (if (comint-check-proc shell-buffer)
              (pop-to-buffer shell-buffer (bound-and-true-p display-comint-buffer-action))
            (vterm shell-buffer))
        (vterm (generate-new-buffer-name default-project-shell-name)))))
  :init (advice-add 'project-shell :override #'ossian/project-shell)
  :bind ( :map vterm-mode-map ("M-s" . nil)))

;;;; Language specific

(use-package nix-mode
  :ensure t)

(use-package kotlin-ts-mode
  :ensure t
  :mode "\\.kt\\'")

(use-package csharp-ts-mode
  :mode "\\.cs\\'")

(use-package bazel
  :ensure t)

(use-package rust-ts-mode
  :mode "\\.rs\\'")

(provide 'init)
;;; init.el ends here
