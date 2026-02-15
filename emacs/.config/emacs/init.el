;;; init.el --- À la carte -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ossian Winter

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

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

;;; Buffer management:

(unless (package-installed-p 'popper)
  (package-install 'popper))
(popper-mode +1)

;;; Completion:

(setq completion-styles '(orderless)
      completion-category-overrides '((file (styles partial-completion))))

(setq read-extended-command-predicate #'command-completion-default-include-p)

(unless (package-installed-p 'orderless)
  (package-install 'orderless))

;;; Minibuffer:

(setq enable-recursive-minibuffers t)

(unless (package-installed-p 'consult)
  (package-install 'consult))

(unless (package-installed-p 'vertico)
  (package-install 'vertico))
(vertico-mode +1)

(unless (package-installed-p 'marginalia)
  (package-install 'marginalia))
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

(unless (package-installed-p 'avy)
  (package-install 'avy))

;;; Code navigation:

(setq xref-show-xrefs-function       #'consult-xref)
(setq xref-show-definitions-function #'consult-xref)

;;; Version control:

(unless (package-installed-p 'magit)
  (package-install 'magit))

;;; Postlude:

(load custom-file 'noerror 'nomessage)

(provide 'init)
;;; init.el ends here
