;;; init.el --- Normal Emacs initialization -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Ossian Winter

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

;; ensure settings apply to all subsequent expression expansions
(use-package use-package
  :ensure nil
  :custom
  (use-package-always-defer
   t
   "Treat every package as though it had specified using :defer t")
  (use-package-always-ensure
   t
   "Treat every package as though it had specified using :ensure t")
  (use-package-expand-minimally
   t
   "Make the expanded code as minimal as possible"))

;; built-in feature that is provided by the C sources, only symbols strictly
;; defined in the C sources should be configured in this expression
(use-package emacs
  :ensure nil
  :custom
  (enable-recursive-minibuffers
   t
   "Allow minibuffer commands while in the minibuffer"))

;; built-in basic editing commands for Emacs i.e. `read-extended-command'
(use-package simple
  :ensure nil
  :custom
  (read-extended-command-predicate
   #'command-completion-default-include-p
   "Exclude from completion candidates those commands which have been marked
specific to other than the current buffer's mode"))

;; built-in package system 
(use-package package
  :ensure nil
  :custom
  (package-install-upgrade-built-in
   t
   "Let built-in packages be upgraded via archives")
  (package-archives
   '(("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-archive-priorities
   '(("melpa" . 100))
   "Try first to install packages from MELPA, fall back to GNU ELPA")
  :init
  (package-initialize))

;; makes Emacs look nice, while built-in we get the latest version from either
;; MELPA or the GNU ELPA (prefer not recompiling for updates...)
(use-package modus-themes
  :init
  (modus-themes-select 'modus-vivendi))

;; a `completion-try-completion' implementation that divides the completion
;; pattern into space-separated components and matches candidates that match all
;; of the components in any order
(use-package orderless
  :custom
  (completion-styles
   '(orderless basic)))

;; a fast vertical completion UI based on the built-in `completion' system
(use-package vertico
  :init
  (vertico-mode +1))

;; enriches minibuffer completions by adding annotations at the margin
(use-package marginalia
  :init
  (marginalia-mode +1))

;; search and navigation commands based on the built-in `completion' system
(use-package consult
  :custom
  (xref-show-xrefs-function #'consult-xref)
  (xref-show-definitions-function #'consult-xref)
  :bind
  ("C-x   b" . consult-buffer)
  ("C-x C-b" . consult-buffer)
  ("C-x 4 b" . consult-buffer-other-window)
  ("C-x 5 b" . consult-buffer-other-frame)
  ("C-x t b" . consult-buffer-other-tab)
  ("C-x r b" . consult-bookmark)
  ("C-x p b" . consult-project-buffer)
  ("M-s   d" . consult-fd)
  ("M-s M-d" . consult-fd)
  ("M-s   g" . consult-ripgrep)
  ("M-s M-g" . consult-ripgrep)
  ("M-s   s" . consult-line)
  ("M-s M-s" . consult-line)
  ("M-s   S" . consult-line-multi)
  ("M-s M-S" . consult-line-multi)
  :init
  (advice-add
   #'register-preview
   :override #'consult-register-window))

;; the one and only
(use-package magit)

;; on-the-fly syntax checker
(use-package flymake)

;; Emacs polyglot: LSP client
(use-package eglot)

;; major mode that makes editing Rust enjoyable
(use-package rust-mode
  :custom
  (rust-mode-treesitter-derive
   t
   "Derive `rust-mode' from the new tree-sitter mode `rust-ts-mode'")
  :hook
  (rust-mode . eglot-ensure))

(provide 'init)
;;; init.el ends here
