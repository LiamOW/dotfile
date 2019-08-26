(require 'package)

; Package.el stuff
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (doom-modeline which-key slime rainbow-delimiters flycheck markdown-mode rust-mode haml-mode yaml-mode web-mode evil-magit magit company helm-ag helm-projectile projectile helm org-bullets org-plus-contrib evil-terminal-cursor-changer evil-commentary evil-indent-textobject evil-org evil-surround evil-leader drag-stuff hlinum powerline evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-ellipsis ((t (:foreground nil)))))

; Set up use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(defalias 'yes-or-no-p 'y-or-n-p)

  ; Which-key
  (use-package which-key
      :ensure t)
  (which-key-mode 1)

(use-package whitespace
  :ensure t)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; Have tab insert a tab literal
(define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)

;; Colorize compilation output
(use-package ansi-color
  :ensure t)
(defun my/ansi-colorize-buffer ()
  (let ((buffer-read-only nil))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'my/ansi-colorize-buffer)

 ;; Colors hex color codes in the color they represent
 ;; (use-package rainbow-mode
 ;; :ensure t
 ;; :init
 ;;     (add-hook 'prog-mode-hook 'rainbow-mode))

(defun config-visit ()
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
  "Reloads ~/.emacs.d/config.org at runtime"
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

;; Startup dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-items '((recents  . 5)
                          (projects . 5))))

; Doom modeline
(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode))

(setq my-theme 'gruvbox)
(use-package gruvbox-theme
  :ensure t)
(load-theme my-theme t)

(menu-bar-mode -1)
(scroll-bar-mode 0)
(tool-bar-mode 0)

(global-linum-mode 1)
(setq linum-format " %4d ")

(use-package hlinum
  :ensure t)
(set-face-foreground 'linum-highlight-face "white")
(set-face-background 'linum-highlight-face nil)
(hlinum-activate)

(line-number-mode 1)
(column-number-mode 1)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(setq standard-indent 2)
(setq-default indent-tabs-mode nil)

(use-package drag-stuff
  :ensure t)
(drag-stuff-global-mode 1)
(global-set-key (kbd "M-k") 'drag-stuff-up)
(global-set-key (kbd "M-j") 'drag-stuff-down)

; Rainbow delimiters
(use-package rainbow-delimiters
  :init
    (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'web-mode-hook #'rainbow-delimiters-mode)
    (add-hook 'rust-mode-hook #'rainbow-delimiters-mode))

(setq show-paren-delay 0)
(show-paren-mode 1)

; Ricing
(defun reevaluate-eyecandy ()
    (load-theme my-theme t))

(if (daemonp)
    (add-hook 'after-make-frame-functions
        (lambda (frame)
            (select-frame frame)
            (reevaluate-eyecandy))))

; Helm and projectile
(use-package helm
  :ensure t
  :config (helm-mode t))
(use-package projectile
  :ensure projectile
  :config
  (setq projectile-indexing-method 'native))
(use-package helm-projectile
  :ensure t)
(use-package helm-ag
  :ensure t)

; Autocomplete
(use-package company
  :ensure t
  :config
  (global-company-mode t)
  (setq company-global-modes '(not org-mode)))
(define-key company-mode-map (kbd "TAB") 'company-complete)

; Magit
(use-package magit
  :ensure t
  :config (setq magit-diff-refine-hunk 'all))
(use-package evil-magit
  :ensure t)

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode))

(setq evil-want-C-i-jump nil)
;; Hasn't been working correctly
;; (setq evil-want-C-u-scroll t)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)

(use-package evil
  :ensure t
  :init
  (setq evil-vsplit-window-right t)
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode))

; Org mode stuff
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
  (lambda () (evil-org-set-key-theme))))

(use-package evil-snipe
  :ensure t)
(evil-snipe-mode +1)

(use-package evil-indent-textobject
  :ensure t)

(use-package evil-commentary
  :ensure t
  :config
  (evil-commentary-mode))

(use-package evil-terminal-cursor-changer
  :ensure t
  :init
  (setq evil-motion-state-cursor 'box)  ; █
  (setq evil-visual-state-cursor 'box)  ; █
  (setq evil-normal-state-cursor 'box)  ; █
  (setq evil-insert-state-cursor 'bar)  ; ⎸
  (setq evil-emacs-state-cursor  'hbar) ; _
  :config
  (evil-terminal-cursor-changer-activate))

; Make escape quit most stuff
(defun minibuffer-keyboard-quit ()
(interactive)
(if (and delete-selection-mode transient-mark-mode mark-active)
    (setq deactivate-mark  t)
(when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
(abort-recursive-edit)))

(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

; Vim leader keybinds
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "b" 'helm-buffers-list
  "f" 'helm-find-files
  "F" 'helm-projectile-ag
  "q" 'evil-quit
  "w" 'save-buffer
  "g" 'magit)

; Org mode keybinds
(evil-leader/set-key-for-mode 'org-mode
  "A" 'org-archive-subtree
  "a" 'org-agenda
  "c" 'org-capture
  "d" 'org-deadline
  "l" 'evil-org-open-links
  "s" 'org-schedule
  "t" 'org-todo)

; Org mode stuff
(setq org-startup-indented t
      org-ellipsis "  "
      org-hide-leading-stars t
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-agenda-block-separator ""
      org-fontify-whole-heading-line t
      org-fontify-done-headline t
      org-fontify-quote-and-verse-blocks t)

(use-package org
  :ensure org-plus-contrib)

; Pretty bullet points
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

; Agenda thing
(setq org-agenda-window-setup 'only-window)

; Yaml mode
(use-package yaml-mode
  :ensure t)

(use-package python-mode
  :ensure t)
(setq python-shell-interpreter "/usr/local/bin/python3")

; Hamlet mode
(use-package haml-mode
  :ensure t)

; Rust mode
(use-package rust-mode
  :ensure t)

; SLIME
(use-package slime
  :ensure t)
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

; Markdown mode
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

; Flycheck
(use-package flycheck
  :ensure t
  :init
(setq flycheck-indication-mode nil)
(setq flycheck-display-errors-delay nil)
(setq flycheck-idle-change-delay 2)
(global-flycheck-mode))
