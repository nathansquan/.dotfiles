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
;; (use-package solarized-theme
;;   :config (load-theme 'solarized-light t))

;; highlight parens
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)

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
  ;; Files
  (setq org-directory "~/Documents/org")
  (setq org-agenda-files "gtd")
  (setq org-ellipsis " ▾")
  ;;(setq org-agenda-start-with-log-mode t)
  ;;(setq org-log-done 'time)
  ;;(setq org-log-into-drawer t)
  ;;(setq org-checkbox-hierarchical-statistics nil)

  ;; CAPTURE ===================================================
  (setq org-capture-templates
	'(("i" "Inbox" entry (file "gtd/inbox.org")
	   "* TODO %?\nEntered on %U")))

  (defun org-capture-inbox ()
    (interactive)
    (call-interactively 'org-store-link)
    (org-capture nil "i"))

  ;; Key bindings
  (define-key global-map (kbd "C-c a") 'org-agenda)
  (define-key global-map (kbd "C-c c") 'org-capture)
  (define-key global-map (kbd "C-c i") 'org-capture-inbox)
  
  ;; REFILE ===================================================
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)
  (setq org-refile-targets
	'("gtd/projects"
	  "gtd/someday.org"
	  "gtd/waiting.org"))

  ;; TODO
  (setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)")))
  
  (defun log-todo-next-creation-date (&rest ignore)
    "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
    (when (and (string= (org-get-todo-state) "NEXT")
	       (not (org-entry-get nil "ACTIVATED")))
      (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))

  (add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)
  
  ;; Agenda
  (setq org-agenda-custom-commands
	'(("g" "Get Things Done (GTD)"
	   ((agenda ""
		    ((org-agenda-skip-function
		      '(org-agenda-skip-entry-if 'deadline))
		     (org-deadline-warning-days 0)))
	    (todo "NEXT"
		  ((org-agenda-skip-function
		    '(org-agenda-skip-entry-if 'deadline))
                   (org-agenda-prefix-format "  %i %-12:c [%e] ")
                   (org-agenda-overriding-header "\nTasks\n")))
            (agenda nil
		    ((org-agenda-entry-types '(:deadline))
                     (org-agenda-format-date "")
                     (org-deadline-warning-days 7)
                     (org-agenda-skip-function
		      '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                     (org-agenda-overriding-header "\nDeadlines")))
            (tags-todo "inbox"
                       ((org-agenda-prefix-format "  %?-12t% s")
			(org-agenda-overriding-header "\nInbox\n")))
            (tags "CLOSED>=\"<today>\""
                  ((org-agenda-overriding-header "\nCompleted today\n")))))))

  ;; Automatically save buffers after refiling ==================================
  ;; Get files
  (setq org-agenda-files 
	(mapcar 'file-truename 
		(file-expand-wildcards "~/Documents/org/gtd/*.org")))

  ;; Save the corresponding buffers
  (defun gtd-save-org-buffers ()
    "Save `org-agenda-files' buffers without user confirmation. See also `org-save-all-org-buffers'"
    (interactive)
    (message "Saving org-agenda-files buffers...")
    (save-some-buffers t (lambda ()
			   (when (member (buffer-file-name) org-agenda-files)
			     t)))
    (message "Saving org-agenda-files buffers... done"))

  ;; Add it after refile
  (advice-add 'org-refile :after
	      (lambda (&rest _)
		(gtd-save-org-buffers)))
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
 '(org-agenda-files
   '("/home/nathanquan/Documents/org/inbox.org"
     "/home/nathanquan/Documents/org/tasks.org"
     "/home/nathanquan/Documents/org/birthdays.org"))
 '(package-selected-packages
   '(all-the-icons cider counsel doom-modeline doom-themes
		   exec-path-from-shell ivy-rich org-bullets paredit
		   rainbow-delimiters solarized-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
