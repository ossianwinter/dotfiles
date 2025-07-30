(unless (bound-and-true-p straight-base-dir)
  (load (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory) nil 'nomessage))

(straight-use-package 'use-package)

(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
