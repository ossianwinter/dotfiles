;;; init.el --- À la carte -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ossian Winter

;; Author: Ossian Winter <ossian@winter.vg>
;; URL: https://github.com/ossianwinter/dotfiles

;;; Commentary:

;; À la carte.

;;; Code:

(unless (bound-and-true-p server-process) (server-start))

(set-language-environment "UTF-8")
(setopt default-input-method nil)  ; side-effect of `set-language-environment'

(setopt user-full-name "Ossian Winter")
(setopt user-mail-address "ossian@winter.vg")

(setopt make-backup-files nil)

;;; Package management:

(require 'package)

(defun ossian/pkg (pkg)
  (unless package-archive-contents (package-refresh-contents))
  (unless (package-installed-p pkg) (package-install pkg)))

(setopt package-archives
	'(("gnu"    . "https://elpa.gnu.org/packages/")
	  ("nongnu" . "https://elpa.nongnu.org/nongnu/")
	  ("melpa"  . "https://melpa.org/packages/")))

(setopt package-archive-priorities
	'(("gnu"    . 90)
	  ("nongnu" . 80)
	  ("melpa"  . 70)))

;;; Visual:

(require-theme 'modus-themes)
(modus-themes-load-theme 'modus-vivendi)

;;; Completion:

(setopt read-extended-command-predicate #'command-completion-default-include-p)

;;;; Orderless:

(ossian/pkg 'orderless)

(setopt completion-styles '(orderless))
(setopt completion-category-overrides '((file (styles partial-completion))))

;;; Minibuffer:

(setopt enable-recursive-minibuffers t)

;;;; Vertico:

(ossian/pkg 'vertico)

(vertico-mode +1)

;;;; Marginalia:

(ossian/pkg 'marginalia)

(marginalia-mode +1)

;;;; Embark:

(ossian/pkg 'embark)
(ossian/pkg 'embark-consult)

(keymap-global-set "C-;" #'embark-act)  ; prompt for action and perform it
(keymap-global-set "C-:" #'embark-dwim) ; perform default action on current target

;;; Navigation:

;;;; Consult:

(ossian/pkg 'consult)

(setopt consult-buffer-list-function     #'consult--frame-buffer-list)
(setopt consult-preview-excluded-buffers  '(major-mode . exwm-mode))
(setopt xref-show-xrefs-function         #'consult-xref)
(setopt xref-show-definitions-function   #'consult-xref)

(keymap-global-set "M-y" #'consult-yank-pop) ; replaces `yank-pop'

(keymap-set ctl-x-map          "M-:" #'consult-complex-command)     ; replaces `repeat-complex-command'
(keymap-set ctl-x-map          "b"   #'consult-buffer)              ; replaces `switch-to-buffer'
(keymap-set ctl-x-4-map        "b"   #'consult-buffer-other-window) ; replaces `switch-to-buffer-other-window'
(keymap-set ctl-x-5-map        "b"   #'consult-buffer-other-frame)  ; replaces `switch-to-buffer-other-frame'
(keymap-set tab-prefix-map     "b"   #'consult-buffer-other-frame)  ; replaces `switch-to-buffer-other-tab'
(keymap-set bookmark-map       "b"   #'consult-bookmark)            ; replaces `bookmark-jump'
(keymap-set project-prefix-map "b"   #'consult-project-buffer)      ; replaces `project-switch-to-buffer'

(keymap-set goto-map "g"   #'consult-goto-line) ; replaces `goto-line'
(keymap-set goto-map "M-g" #'consult-goto-line) ; replaces `goto-line'

(keymap-set search-map "g" #'consult-ripgrep) ; search with rg
(keymap-set search-map "f" #'consult-fd)      ; search with fd

;;;; avy:

(ossian/pkg 'avy)

(keymap-global-set "C-." #'avy-goto-char-timer) ; read N chars and jump to the first one

;;; Version control:

;;;; Magit:

(ossian/pkg 'magit)

;;; Misc:

;;;; eat:

(ossian/pkg 'eat)

;;;; vterm:

(ossian/pkg 'vterm)

;;; X11:

;;;; filechooser:

(ossian/pkg 'filechooser)

(setopt filechooser-use-popup-frame nil)

;;;; EXWM:

(ossian/pkg 'exwm)

(setopt exwm-input-global-keys
	`(([?\s-r] . exwm-reset)
	  ([?\s-w] . exwm-workspace-switch)
	  ([?\s-&] . (lambda (cmd)
		       (interactive (list (read-shell-command "$ ")))
		       (start-process-shell-command cmd nil cmd)))))

(setopt exwm-input-simulation-keys
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

(add-hook 'exwm-update-class-hook (lambda () (exwm-workspace-rename-buffer exwm-class-name)))
(add-hook 'exwm-update-title-hook (lambda () (exwm-workspace-rename-buffer exwm-title)))

(exwm-wm-mode +1)

(provide 'init)
;;; init.el ends here
