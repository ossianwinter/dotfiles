;;; init.el --- À la carte -*- lexical-binding: t; -*-

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

;;;; Core:

(unless (bound-and-true-p server-process) (server-start))

(setopt user-full-name "Ossian Winter"
	user-mail-address "ossian@winter.vg")

(set-language-environment "UTF-8")
(setopt default-input-method nil)

(setopt use-dialog-box nil)

(setopt gc-cons-threshold (* 32 (* 1024 1024))
	read-process-output-max (* 1024 1024))

(defun ossian/use-package-ensure-noop (&rest _) t)
(setopt use-package-ensure-function #'ossian/use-package-ensure-noop
        use-package-expand-minimally t)

;;;; Appearance:

(blink-cursor-mode -1)

(setopt modus-themes-include-derivatives-mode t
	modus-themes-mixed-fonts t)

(use-package ef-themes :ensure t)

(use-package darkman :ensure t
  :custom (darkman-themes '( :light ef-orange
		             :dark ef-autumn))
  :config (darkman-mode +1))

(use-package fontaine :ensure t
  :custom (fontaine-presets
           '((regular)
             (t
              :default-family "IBM Plex Mono"
              :default-weight regular
              :default-height 120

              :fixed-pitch-family nil ; fallback to :default-family
              :fixed-pitch-weight nil ; fallback to :default-weight
              :fixed-pitch-height 1.0

              :variable-pitch-family "IBM Plex Sans"
              :variable-pitch-weight nil ; fallback to :default-weight
              :variable-pitch-height 1.0)))
  :config
  (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))
  (fontaine-mode +1))

(set-fontset-font t 'symbol "JuliaMono")
(set-fontset-font t 'symbol "Symbola" nil 'append)

;;;; Completion:

;;;; Minibuffer:

(setopt enable-recursive-minibuffers t)

(use-package vertico :ensure t
  :config (vertico-mode +1))

(use-package marginalia :ensure t
  :config (marginalia-mode +1))

;;;; Navigation:

(repeat-mode +1)

(use-package consult :ensure t
  :custom ( xref-show-xrefs-function #'consult-xref
            xref-show-definitions-function #'consult-xref)
  :bind ( :map global-map ("M-y" . consult-yank-pop)
          :map goto-map ("g" . consult-goto-line)
          :map goto-map ("M-g" . consult-goto-line)
          :map search-map ("g" . consult-grep)
          :map search-map ("f" . consult-find)
          :map ctl-x-map ("b" . consult-buffer)))

;;;; Editing:

(setq-default indent-tabs-mode nil)

(use-package vundo :ensure t
  :bind (:map ctl-x-map ("u" . vundo)))

;;;; Files:

(setopt make-backup-files nil)

;; `find-file' follows links
(setopt find-file-visit-truename t)

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
     (nnimap "Personal"
             (nnimap-address "imap.fastmail.com")
             (nnimap-user "ossian@fastmail.com")
             (nnimap-stream tls)))))

;;;; Misc:

(use-package auth-source-1password :ensure t
  :preface
  (defun ossian/auth-source-1password--construct-secret-reference
      (backend type host user port)
    (pcase `(,host ,user)
      (`(,(or `(,_ "imap.fastmail.com") "smtp.fastmail.com") "ossian@fastmail.com")
       "Personal/i7o5bqrpenxguh5psiaave5k7m/credential")
      (`(,(and (pred stringp) host)
         ,(and (pred stringp) user))
       (auth-source-1password--1password-construct-entry-path
        backend type host user port))
      (_ nil)))
  :custom (auth-source-1password-construct-secret-reference #'ossian/auth-source-1password--construct-secret-reference)
  :config (auth-source-1password-enable))

(use-package vterm :ensure t
  ;; https://mocompute.codeberg.page/item/2024/2024-09-03-emacs-project-vterm.html
  :preface (defun ossian/project-shell ()
             (interactive)
             (let* ((default-directory (project-root (project-current t)))
                    (default-project-shell-name (project-prefixed-buffer-name "shell"))
                    (shell-buffer (get-buffer default-project-shell-name)))
               (if (and shell-buffer (not current-prefix-arg))
                   (if (comint-check-proc shell-buffer)
                       (pop-to-buffer shell-buffer (bound-and-true-p display-comint-buffer-action))
                     (vterm shell-buffer))
                 (vterm (generate-new-buffer-name default-project-shell-name)))))
  :config (advice-add 'project-shell :override #'ossian/project-shell))

(use-package magit :ensure t
  :init (with-eval-after-load 'project
          (add-to-list 'project-switch-commands '(magit-project-status "Magit") t))
  :bind ( :map ctl-x-map ("g" . magit-status)
          :map project-prefix-map ("m" . magit-project-status)))

(provide 'init)
;;; init.el ends here
