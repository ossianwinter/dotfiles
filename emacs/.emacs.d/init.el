;; package.el
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; emacs
(use-package emacs
  :custom
  (tab-always-indent 'complete)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p)
  (minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt))
  :init
  (load-theme 'modus-vivendi))

;; savehist
(use-package savehist
  :init
  (savehist-mode))

;; magit
(use-package magit
  :ensure t
  :bind (("C-x   g" . magit-status)
	 ("C-x C-g" . magit-status)
	 ("C-c   g" . magit-dispatch)
	 ("C-c C-g" . magit-dispatch)
	 ("C-c   f" . magit-file-dispatch)
	 ("C-c C-f" . magit-file-dispatch))
  :custom
  (magit-define-global-key-bindings nil))

;; vertico
(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; consult
(use-package consult
  :ensure t
  :bind (("C-x   b" . consult-buffer)
	 ("C-x C-b" . consult-buffer))
  :custom
  (xref-show-xrefs-function       #'consult-xref)
  (xref-show-definitions-function #'consult-xref))

;; marginalia
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;; embark
(use-package embark
  :ensure t
  :bind (("C-." . embark-act)
	 ("C-;" . embark-dwim)))

;; embark-consult
(use-package embark-consult
  :ensure t
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

;; corfu
(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))

;; eat
(use-package eat
  :ensure t
  :bind (("C-c   t" . eat)
	 ("C-c C-t" . eat)))

;; affe
(use-package affe
  :ensure t
  :bind (("C-x C-f" . affe-find)
	 ("M-s M-s" . affe-grep))
  :custom
  (affe-find-command "fd --hidden --exclude .git --type file --color never")
  (affe-grep-command "rg --hidden  --iglob=!.git             --color never --null --max-columns=1000 --no-heading --line-number -v ^$")
  (affe-regexp-function #'orderless-pattern-compiler)
  (affe-highlight-function #'orderless-highlight-matches))

(use-package rust-mode
  :ensure t)

;; eglot
(use-package eglot)
