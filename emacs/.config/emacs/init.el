;;; init.el --- Emacs initialization -*- lexical-binding: t; -*-

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

;;; Code:

;; Bootstrap or install straight.el, @ugly but WCYD?
(let ((straight-bootstrap
       (expand-file-name
	"straight/repos/straight.el/bootstrap.el"
	user-emacs-directory)))
  (unless (file-exists-p straight-bootstrap)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
	 'silent
	 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load straight-bootstrap))

(use-package use-package
  :straight nil
  :custom
  (use-package-always-defer t)      ; Treat every use-package sexp as though it specified ':defer t'.
  (use-package-expand-minimally t)) ; @Speed: Make expanded code of every use-package sexp as minimal as possible.

(use-package emacs
  :straight nil
  :custom
  (enable-recursive-minibuffers t)) ; Allow minibuffer commands while in the minibuffer.

(use-package simple
  :straight nil
  :custom
  ;; Exclude from completion candidates those commands which have been marked specific to modes other than the current buffer's mode.
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package custom
  :straight nil
  :custom
  (custom-safe-themes t)) ; Treat all themes safe.

(use-package modus-themes
  :straight t
  :init
  (modus-themes-select 'modus-vivendi)) ; Load `modus-vivendi' for now, darkman will load the appropriate theme later.

(use-package darkman
  :straight t
  :custom
  (darkman-themes '(:light modus-operandi :dark modus-vivendi))
  :init
  (darkman-mode +1))

(use-package orderless
  :straight t
  :custom
  (completion-styles
   '(orderless basic)))

(use-package vertico
  :straight t
  :init
  (vertico-mode +1))

(use-package marginalia
  :straight t
  :init
  (marginalia-mode +1))

(use-package consult
  :straight t
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
  ("M-s   f" . consult-fd)
  ("M-s M-f" . consult-fd)
  ("M-s   g" . consult-ripgrep)
  ("M-s M-g" . consult-ripgrep)
  ("M-s   r" . consult-ripgrep)
  ("M-s M-r" . consult-ripgrep)
  ("M-s   l" . consult-line)
  ("M-s M-l" . consult-line)
  ("M-s   L" . consult-line-multi)
  ("M-s M-L" . consult-line-multi)
  :init
  (advice-add #'register-preview :override #'consult-register-window)) ; Better consult-register previews.

(use-package magit
  :straight t)

(provide 'init)
;;; init.el ends here
