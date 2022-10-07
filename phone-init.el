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
(straight-use-package 'ivy)
(straight-use-package 'flymake)
(straight-use-package 'page-break-lines)
(straight-use-package 'dashboard)
(straight-use-package 'gruvbox-theme)
(straight-use-package 'spaceline)
(straight-use-package 'powerline
 :ensure t
 :init
 (spaceline-spacemacs-theme))
(straight-use-package 'undo-tree)
(straight-use-package 'w3m)
(straight-use-package 'emojify)
(straight-use-package 'elpher)
;; end
(setq custom-file (concat user-emacs-directory "custom.el"))
(global-emojify-mode 1)
(add-hook 'after-init-hook 'powerline-reset)
(delete-selection-mode 1)
(ivy-mode 1)
(global-undo-tree-mode 1)
(setq inhibit-startup-message t)
(load-theme 'gruvbox-dark-hard t)
(setq doc-view-resolution 500)
;; dash board
(dashboard-setup-startup-hook)
  (setq dashboard-items '((recents . 5)))
  (setq dashboard-banner-logo-title "T Z A N T Z A Q ' Ö R")
  (setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)
;; end
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
;; aqui van los keibinds texto
(global-set-key (kbd "s-o") 'query-replace)
;;; org-mode
(global-set-key (kbd "s-s") 'org-store-link)
(global-set-key (kbd "s-a") 'org-agenda)
(global-set-key (kbd "s-c") 'org-capture)
(global-set-key (kbd "s-i") 'org-table-insert-row)
(global-set-key (kbd "s-k") 'org-table-kill-row)
;; aqui terminan los keibinds texto
