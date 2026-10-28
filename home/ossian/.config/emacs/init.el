;;; init.el --- À la carte                           -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Ossian Winter

;; Author: Ossian Winter <ossian@winter.vg>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

;;;; Packages:

(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setopt package-selected-packages
        '(consult
          corfu
          embark
          embark-consult
          envrc
          magit
          marginalia
          vertico
          vundo))

(package-install-selected-packages)

;;;; Identity:

(setopt user-full-name "Ossian Winter")
(setopt user-mail-address "ossian@winter.vg")

;;;; Language:

(set-language-environment "UTF-8")
(setopt default-input-method nil)

;;;; Files:

(setopt make-backup-files nil)

(recentf-mode +1)

;;;; Server:

(unless (bound-and-true-p server-process)
  (server-start))

;;;; Look & feel:

(load-theme 'modus-vivendi t)

(when (display-graphic-p)
  (blink-cursor-mode -1)

  (set-face-attribute 'default nil
                      :family "Fira Code"
                      :height 160))

;;;; Minibuffer:

(setopt enable-recursive-minibuffers t)
(setopt read-extended-command-predicate #'command-completion-default-include-p)

(savehist-mode +1)

(vertico-mode +1)
(marginalia-mode +1)

;;;; Navigation:

(setopt xref-show-xrefs-function #'consult-xref)
(setopt xref-show-definitions-function #'consult-xref)

;;;; Editing:

(setopt tab-always-indent 'complete)    ; Indent or `completion-at-point'
(global-corfu-mode +1)

;;;; Key bindings:

(repeat-mode +1)

(keymap-global-set "M-y" #'consult-yank-pop)

(keymap-global-set "C-." #'embark-act)
(keymap-global-set "C-;" #'embark-dwim)

(keymap-set ctl-x-map "u" #'vundo)

(keymap-set ctl-x-map "b" #'consult-buffer)
(keymap-set ctl-x-4-map "b" #'consult-buffer-other-window)
(keymap-set ctl-x-5-map "b" #'consult-buffer-other-frame)
(keymap-set tab-prefix-map "b" #'consult-buffer-other-tab)
(keymap-set project-prefix-map "b" #'consult-project-buffer)

(keymap-set goto-map "g" #'consult-goto-line)
(keymap-set goto-map "M-g" #'consult-goto-line)

(keymap-set search-map "f" #'consult-fd)
(keymap-set search-map "g" #'consult-ripgrep)

;;;; Epilogue:

;; `envrc-mode' should be initialized in each buffer _before_ other
;; minor modes, which may look for executables. Counter-intuitively,
;; this means that `envrc-global-mode' should be enabled _after_ other
;; global minor modes, since each _prepends_ itself to various hooks.
(envrc-global-mode +1)

(provide 'init)
;;; init.el ends here
