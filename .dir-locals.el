;;; Directory Local Variables            -*- no-byte-compile: t -*-
;;; For more information see (info "(emacs) Directory Variables")

((nil . ((indent-tabs-mode . nil)
         (eval . (progn
                   (defun dotfiles/diff (reverse)
                     (interactive "P")
                     (compilation-start
                      (concat "./Diff" (if reverse " --reverse" ""))
                      'diff-mode
                      (lambda (_) "*Diff*")))

                   (defun dotfiles/install ()
                     (interactive)
                     (compilation-start
                      "sudo ./Install"
                      'compilation-mode
                      (lambda (_) "*Install*"))))))))
