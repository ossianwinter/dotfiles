;;; early-init.el --- Early Emacs initialization -*- lexical-binding: t; -*-

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

(setopt gc-cons-threshold (* 1024 1024 64))
(setopt read-process-output-max (* 1024 64))

;; redirect the eln-cache BEFORE loading no-littering, otherwise we could end up
;; with two directories!
(startup-redirect-eln-cache (convert-standard-filename (expand-file-name "var/eln-cache/" user-emacs-directory)))

;; load no-littering from the contrib directory
(let ((no-littering (expand-file-name "contrib/no-littering" user-emacs-directory)))
  (load no-littering nil (not init-file-debug) nil 'must-suffix))

;; get ouf of here...
(setopt custom-file (no-littering-expand-etc-file-name "custom.el"))

;; we call `package-initialize' in `init' ourselves
(setopt package-enable-at-startup nil)

(push '(menu-bar-lines)       default-frame-alist)
(push '(tool-bar-lines)       default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; modes are assumed to be t unless we nil them out
(setopt menu-bar-mode   nil
	tool-bar-mode   nil
	scroll-bar-mode nil)

(provide 'early-init)
;;; early-init.el ends here
