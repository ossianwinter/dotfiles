;;; early-init.el --- À la carte                     -*- lexical-binding: t; -*-

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

(setopt custom-file (locate-user-emacs-file "custom.el"))
(load custom-file t)

(setopt frame-inhibit-implied-resize t)

(modify-all-frames-parameters (list (cons 'menu-bar-lines 0)
                                    (cons 'tool-bar-lines 0)
                                    (cons 'vertical-scroll-bars nil)))

(setopt menu-bar-mode   nil)
(setopt tool-bar-mode   nil)
(setopt scroll-bar-mode nil)

(provide 'early-init)
;;; early-init.el ends here
