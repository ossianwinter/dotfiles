;;; early-init.el --- Emacs early-initialization -*- lexical-binding: t; -*-

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

;; @Speed: 64 MiB consing between garbage collections.
(setq gc-cons-threshold (* 1024 1024 64))

;; @Speed: Read 1 MiB chunks from child processes.
(setq read-process-output-max (* 1024 1024))

;; @Speed: Don't load package.el at startup.
(setq package-enable-at-startup nil)

;; @Speed: Disable implicit resizing of frame, it's extremely expensive.
(setq frame-inhibit-implied-resize t)

(push '(menu-bar-lines) default-frame-alist)
(setq menu-bar-mode nil)

(push '(tool-bar-lines) default-frame-alist)
(setq tool-bar-mode nil)

(push '(vertical-scroll-bars) default-frame-alist)
(setq scroll-bar-mode nil)

(modify-all-frames-parameters
 (list (cons 'left-fringe 0)
       (cons 'right-fringe 0)))

(provide 'early-init)
;;; early-init.el ends here
