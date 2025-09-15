; use-package.el bootstrap sequence
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))
; use-package.el bootstrap sequence					;


; Packages


;; Customization
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)) ; Open automatically at start-up.
(use-package gruvbox-theme
  :config (load-theme 'gruvbox-dark-hard t))
(use-package spaceline
  :hook (after-init . powerline-reset)
  :config (spaceline-spacemacs-theme))
(use-package emojify
  :hook (after-init . global-emojify-mode)) ; Open automatically at start-up.
(use-package all-the-icons
  :if (display-graphic-p))
;; Customization end

;; Nicies
(use-package ivy)
(use-package undo-tree)
(use-package w3m)
(use-package magit)
(use-package elpher)
(use-package pdf-tools)
;; Nicies end

;; Modes
(use-package flymake)
(use-package company)
;; Modes end

;; LSP
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (prog-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "basedpyright") ;; or basedpyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred
;; LSP End


; Packages End


; Config Options


;; Customization

;;; Dashboard
(setq inhibit-startup-message t)
(setq dashboard-items '((recents . 5)))
(setq dashboard-banner-logo-title "P a s s i f l o r a c e a e")
(setq dashboard-startup-banner 'official)
(setq dashboard-center-content t)
(setq dashboard-vertically-center-content t)
;;;; (setq dashboard-show-shortcuts nil)
(setq dashboard-icon-type 'all-the-icons)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
;;; Dashboard end

(delete-selection-mode 1)
(global-display-line-numbers-mode 1)
(scroll-bar-mode -1)
(global-undo-tree-mode 1)
(set-frame-font "IBM Plex Mono 11")
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
;; Customization end

;; Nicies
(setq doc-view-resolution 500)

;;; Ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(setq enable-recursive-minibuffers t)
;;; Ivy end

;; Nicies end

;; Org-Mode
(with-eval-after-load 'ox-latex
   (add-to-list 'org-latex-classes
                '("apa6p"
                  "\\documentclass[a4paper, man]{apa6}"
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
;; Org-Mode end


; Config Options end


; Keybinds
(global-set-key (kbd "s-o") 'query-replace)
(global-set-key (kbd "s-r") 'magit-status)

;; Org-Mode
(global-set-key (kbd "s-s") 'org-store-link)
(global-set-key (kbd "s-a") 'org-agenda)
(global-set-key (kbd "s-c") 'org-capture)
(global-set-key (kbd "s-i") 'org-table-insert-row)
(global-set-key (kbd "s-k") 'org-table-kill-row)
;; Org-Mode end


; Keybinds end


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
