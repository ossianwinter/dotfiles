(setq user-full-name "Ossian Winter"
      user-mail-address "ossian@winter.vg")

(set-language-environment "UTF-8")
(setq default-input-method nil)    ; side-effect of `set-language-environment'

;; Completion
(setq read-extended-command-predicate #'command-completion-default-include-p)

;; Minibuffer
(setq enable-recursive-minibuffers t)

(unless (package-installed-p 'vertico)
  (package-install 'vertico))
(vertico-mode +1)

(unless (package-installed-p 'marginalia)
  (package-install 'marginalia))
(marginalia-mode +1)

;; Version control
(unless (package-installed-p 'magit)
  (package-install 'magit))

(load custom-file 'noerror 'nomessage)
