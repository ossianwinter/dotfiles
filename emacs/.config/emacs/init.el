;;; init.el --- À la carte -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ossian Winter

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

(require 'package)

;;; User:

(setq user-full-name "Ossian Winter"
      user-mail-address "ossian@winter.vg")

;;; Locale:

(set-language-environment "UTF-8")
(setq default-input-method nil)    ; side-effect of `set-language-environment'

;;; Keymaps:

;;;; C-x:

(keymap-set ctl-x-map          "M-:" #'consult-complex-command)     ; replaces `repeat-complex-command'
(keymap-set ctl-x-map          "b"   #'consult-buffer)              ; replaces `switch-to-buffer'
(keymap-set ctl-x-4-map        "b"   #'consult-buffer-other-window) ; replaces `switch-to-buffer-other-window'
(keymap-set ctl-x-5-map        "b"   #'consult-buffer-other-frame)  ; replaces `switch-to-buffer-other-frame'
(keymap-set tab-prefix-map     "b"   #'consult-buffer-other-frame)  ; replaces `switch-to-buffer-other-tab'
(keymap-set bookmark-map       "b"   #'consult-bookmark)            ; replaces `bookmark-jump'
(keymap-set project-prefix-map "b"   #'consult-project-buffer)      ; replaces `project-switch-to-buffer'

;;;; M-g:

(keymap-set goto-map "g"   #'consult-goto-line) ; replaces `goto-line'
(keymap-set goto-map "M-g" #'consult-goto-line) ; replaces `goto-line'

;;;; M-s:

(keymap-set search-map "g" #'consult-ripgrep)
(keymap-set search-map "f" #'consult-fd)

;;;; Global:

(keymap-global-set "M-y"   #'consult-yank-pop)    ; replaces `yank-pop'
(keymap-global-set "C-."   #'avy-goto-char-timer) ; read N chars and jump to the first one
(keymap-global-set "C-`"   #'popper-toggle)       ; toggle visibility of the last popup
(keymap-global-set "M-`"   #'popper-cycle)        ; cycle visibility of popup windows
(keymap-global-set "C-M-`" #'popper-toggle-type)  ; turn popup buffer into regular window or vice-versa

;;; Package management:

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archive-priorities '("gnu"    . 90) t)
(add-to-list 'package-archive-priorities '("nongnu" . 80) t)
(add-to-list 'package-archive-priorities '("melpa"  . 70) t)

;;; Theme:

(require-theme 'modus-themes)
(setq modus-vivendi-palette-overrides
      '((bg-main "#222222")
	(bg-dim  "#444444")
	(bg-region "#005577")
	(fg-main "#eeeeee")
	(fg-dim  "#bbbbbb")))
(modus-themes-load-theme 'modus-vivendi)

;;; Buffer management:

(unless (package-installed-p 'shackle) (package-install 'shackle))
(shackle-mode +1)

;;; Completion:

(setq completion-styles '(orderless)
      completion-category-overrides '((file (styles partial-completion))))

(setq read-extended-command-predicate #'command-completion-default-include-p)

(unless (package-installed-p 'orderless) (package-install 'orderless))

;;; Minibuffer:

(setq enable-recursive-minibuffers t)

(unless (package-installed-p 'consult) (package-install 'consult))

(unless (package-installed-p 'vertico) (package-install 'vertico))
(vertico-mode +1)

(unless (package-installed-p 'marginalia) (package-install 'marginalia))
(marginalia-mode +1)

;;; File navigation:

(with-eval-after-load 'consult
  (let ((fd-args (if (listp consult-fd-args) consult-fd-args (list consult-fd-args))))
    (unless (member "--hidden" fd-args)
      (setq consult-fd-args (append fd-args '("--hidden"))))))

(with-eval-after-load 'consult
  (let ((rg-args (if (listp consult-ripgrep-args) consult-ripgrep-args (list consult-ripgrep-args))))
    (unless (member "--hidden" rg-args)
      (setq consult-ripgrep-args (append rg-args '("--hidden"))))))

;;; Text navigation:

(unless (package-installed-p 'avy) (package-install 'avy))

;;; Code navigation:

(setq xref-show-xrefs-function       #'consult-xref)
(setq xref-show-definitions-function #'consult-xref)

;;; Version control:

(unless (package-installed-p 'magit) (package-install 'magit))

;;; Misc:

(unless (package-installed-p 'eat) (package-install 'eat))

;;; Window Manager:

(unless (package-installed-p 'exwm) (package-install 'exwm))
(require 'exwm)

(add-hook 'exwm-update-class-hook (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
(add-hook 'exwm-update-title-hook (lambda () (exwm-workspace-rename-buffer exwm-title)))

(setq exwm-input-global-keys
      `(([?\s-r] . exwm-reset)
	([?\s-w] . exwm-workspace-switch)
	([?\s-&] . (lambda (cmd)
		     (interactive (list (read-shell-command "$ ")))
		     (start-process-shell-command cmd nil cmd)))))

(setq exwm-input-simulation-keys
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

;; https://github.com/minad/consult/issues/178
;; https://github.com/minad/consult/issues/186
;; https://github.com/minad/consult/issues/204
;; https://github.com/minad/consult/wiki#do-not-preview-exwm-windows-or-tramp-buffers
(setq consult-preview-excluded-buffers '(major-mode . exwm-mode))

;; @Note: `exwm-wm-mode' is enabled later

;;; Postlude:

(load custom-file 'noerror 'nomessage)
(exwm-wm-mode +1) ; let `custom-file' override settings defined in this file

(provide 'init)
;;; init.el ends here
