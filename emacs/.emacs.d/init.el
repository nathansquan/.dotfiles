(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (setq use-package-always-ensure t
	use-package-expand-minimally t)
  (require 'use-package))
;; General Configuration

;; User Interface
(setq visible-bell t)
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for certain modes
(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; Themes
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
;; (load-theme 'nord t)
;;(use-package solarized-theme
;;  :config (load-theme 'solarized-light t))

;; highlight parens
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)

;; Show emacs where nix installed language bins are
;;(add-to-list 'exec-path "~/.nix-profile/bin")
(setq scheme-program-name "~/.nix-profile/bin/scheme")

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))


;; packages
(use-package counsel)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; add descriptions to counsel-Mx
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history))
  :config
  ;; Don't start searches with ^
  (setq ivy-initial-inputs-alist nil))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-oksolar-light t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; M-x all-the-icons-install-fonts on first run
(use-package all-the-icons
  :if (display-graphic-p))

(use-package paredit
  :init
  (add-hook 'clojure-mode-hook #'enable-paredit-mode)
  (add-hook 'cider-repl-mode-hook #'enable-paredit-mode)
  (add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook #'enable-paredit-mode)
  :config
  (show-paren-mode t)
  :bind (("M-[" . paredit-wrap-square)
	 ("M-{" . paredit-wrap-curly))
  :diminish nil)


;; Org-mode
(use-package org
  :config
  (setq org-ellipsis " ▾")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-checkbox-hierarchical-statistics nil)
  (setq org-agenda-files
	'("~/Documents/org/tasks.org"
	  "~/Documents/org/birthdays.org"
	  "~/Documents/org/habits.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  ;;(setq org-habit-graph-column 60)
  (setq org-habit-show-all-today t)
  )

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))


(defvar my-packages '(clojure-mode
		      cider))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-bullets exec-path-from-shell ivy-rich all-the-icons doom-themes paredit solarized-theme which-key doom-modeline counsel cider clojure-mode nord-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
