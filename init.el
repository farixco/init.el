;; Make emacs startup faster
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)
 
(defvar startup/file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
 
(defun startup/revert-file-name-handler-alist ()
  (setq file-name-handler-alist startup/file-name-handler-alist))
 
(defun startup/reset-gc ()
  (setq gc-cons-threshold 16777216
    gc-cons-percentage 0.1))
 
(add-hook 'emacs-startup-hook 'startup/revert-file-name-handler-alist)
(add-hook 'emacs-startup-hook 'startup/reset-gc)
;;
;; hmmm
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
;; test
;; aqui los pack a usar
(straight-use-package 'use-package)
(straight-use-package 'auctex)
(straight-use-package 'ivy)
(straight-use-package 'flymake)
(straight-use-package 'synonyms)
(straight-use-package 'yasnippet)
(straight-use-package 'page-break-lines)
(straight-use-package 'projectile)
(straight-use-package 'dashboard)
(straight-use-package 'gruvbox-theme)
(straight-use-package 'spaceline)
(straight-use-package 'powerline
 :ensure t
 :init
 (spaceline-spacemacs-theme))
(straight-use-package 'undo-tree)
(straight-use-package 'w3m)
(straight-use-package 'magit)
(straight-use-package 'company)
(straight-use-package 'csharp-mode)
(straight-use-package 'omnisharp)
(straight-use-package 'emojify)
(straight-use-package 'gnu-apl-mode)
(use-package lsp-mode
  :straight t
  :hook ((c-mode . lsp)
	 (c++-mode . lsp))
  :commands lsp
  :config (setq lsp-keymap-prefix "s-q"))
(use-package lsp-ivy
  :straight t
  :commands lsp-ivy-workspace-symbol)
(use-package lsp-ui
  :straight t)
(use-package ccls
  :after lsp-mode
  :straight t
  :config (setq ccls-executable "~/Documents/Cosas/ccls/Release/ccls"))
(straight-use-package 'elpher)
;; end
;; custom
(setq custom-file (concat user-emacs-directory "custom.el"))
;; end custom
;; \begin C
; (setq lsp-clients-clangd-executable "/usr/bin/clangd")
(defun modo-de-c ()
  (c-set-style "ellemtel")
  (electric-pair-local-mode 1)
  (local-set-key (kbd "C-x C-a") (shell-command-to-string (concat "g++ -g -o prog " (buffer-name))))) 
(add-hook 'c-mode-hook 'modo-de-c t)
(add-hook 'c++-mode-hook 'modo-de-c t)
;; \end C
;; AQUÍ EMPIEZA C#
(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))

(defun my-csharp-mode-setup ()
  (omnisharp-mode)
  (company-mode)
  (flycheck-mode)

  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (vsetq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)

  ;csharp-mode README.md recommends this too
  ;(electric-pair-mode 1)       ;; Emacs 24
  (electric-pair-local-mode 1) ;; Emacs 25

  (local-set-key (kbd "C-c C-c") 'omnisharp-start-omnisharp-server)
  (local-set-key (kbd "C-c r r") 'omnisharp-run-code-action-refactoring)
  (local-set-key (kbd "C-c C-a") 'recompile)
  (local-set-key (kbd ".") 'omnisharp-add-dot-and-auto-complete))

(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)
;; AQUÍ TERMINA C#
(global-emojify-mode 1)
(add-hook 'after-init-hook 'powerline-reset)
(delete-selection-mode 1)
(ivy-mode 1)
(global-display-line-numbers-mode 1)
(global-undo-tree-mode 1)
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(load-theme 'gruvbox-dark-hard t)
(setq synonyms-file        "~/.emacs.d/mthesaur.txt")
(setq synonyms-cache-file  "~/.emacs.d/mthesaur.txt.cache")
(require 'synonyms)
(setq doc-view-resolution 500)
;; dash board
(dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)))
  (setq dashboard-banner-logo-title "T Z A N T Z A Q ' Ö R")
  (setq dashboard-startup-banner "~/Pictures/naznaz.png")
  (setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)
;; end
; (set-default-font "IBM Plex Mono-11")
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)

(load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t) 
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

(require 'flymake)

(defun flymake-get-tex-args (file-name)
(list "pdflatex"
(list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))

(add-hook 'LaTeX-mode-hook 'flymake-mode)

; could be ispell as well, depending on your preferences
(setq ispell-program-name "aspell") 
; this can obviously be set to any language your spell-checking program supports
(setq ispell-dictionary "spanish") 

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

(defun turn-on-outline-minor-mode ()
(outline-minor-mode 1))

(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode)
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode)
(setq outline-minor-mode-prefix "\C-c \C-o") ; Or something
;; aqui van los keibinds texto
(global-set-key (kbd "s-o") 'query-replace)
;;; magit
(global-set-key (kbd "s-r") 'magit-status)
;;; org-mode
(global-set-key (kbd "s-s") 'org-store-link)
(global-set-key (kbd "s-a") 'org-agenda)
(global-set-key (kbd "s-c") 'org-capture)
(global-set-key (kbd "s-i") 'org-table-insert-row)
(global-set-key (kbd "s-k") 'org-table-kill-row)
;; aqui terminan los keibinds texto
(put 'downcase-region 'disabled nil)
