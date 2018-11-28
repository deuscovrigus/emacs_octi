(server-start)
(remove-hook 'python-mode-hook 'wisent-python-default-setup)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'package)
(package-initialize)
(add-to-list 'package-archives  '("marmalade" .  "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(progn (cd "~/.emacs.d/lisp")(normal-top-level-add-subdirs-to-load-path))
(setq mouse-wheel-progressive-speed nil)
(setq save-interprogram-paste-before-kill t)

;; no tabs and trailing white space
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(cond
 ((string-equal system-type 'darwin) ; Mac OS X
  (progn
(require 'fixpath)
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(setq mac-function-modifier 'control))))

(cond
 ((string-equal system-type 'gnu/linux) ; Linux - Gnu
  (progn
   (require 'bash-completion)
   (bash-completion-setup)
   (if (file-exists-p "/usr/local/share/emacs/site-lisp/")(progn
							  (cd "/usr/local/share/emacs/site-lisp/")
							  (normal-top-level-add-subdirs-to-load-path)
                                                       ) nil)
)))


(require 'LaTeX-octi)
(require 'cpp-octi-new)
(require 'python-octi)
(require 'generic-util-octi)
(require 'ido)
(require 'magit)
(add-hook 'magit-diff-mode-hook
          (lambda ()
             (setq truncate-lines nil)))
(require 'uniquify)
(require 'doc-view)
(require 'zenburn-theme)

(setq uniquify-buffer-name-style 'post-forward)
(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
(add-hook 'lisp-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))
(modify-syntax-entry ?< "(>" ) ; angle brackets matching global
(modify-syntax-entry ?> ")<" )
(cua-mode t)
(setq cua-delete-copy-to-register-0 nil)
(define-key global-map (kbd "<S-down-mouse-1>") 'ignore) ; turn off font dialog
(define-key global-map (kbd "<S-mouse-1>") 'mouse-set-point)
(put 'mouse-set-point 'CUA 'move)
(setq mouse-drag-copy-region nil)
(bar-cursor-mode 1)
(scroll-bar-mode -1) ; no scroll bars
(xterm-mouse-mode)
(tool-bar-mode -1) ; no tool bar
(global-eldoc-mode -1); no eldoc
(ido-mode t)

;; (set-foreground-color "white")
;; (set-background-color "black")
;; disable undo and put fundamental mode on large files
(defun my-find-file-check-make-large-file-read-only-hook ()
  "If a file is over a given size, make the buffer read only."
  (when (> (buffer-size) (* 1024 1024))
    (fundamental-mode)))
(add-hook 'find-file-hook 'my-find-file-check-make-large-file-read-only-hook)

(set-face-attribute 'default nil :height 120)
(setq case-fold-search nil)
(setq doc-view-continuous t)
(delete-selection-mode 1)
(setq split-width-threshold nil)
(setq confirm-kill-emacs 'y-or-n-p)
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions)) ; no active process prompt
;; flymake settings
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mumamo-region ((t (:background "black")))))

;;to set background color to lack
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying t)
 '(ipython-complete-use-separate-shell-p nil)
 '(package-selected-packages
   (quote
    (comment-dwim-2 highlight-indent-guides docker dockerfile-mode yaml-mode zenburn-theme yasnippet magit jedi flymake-cursor company-math cmake-mode bash-completion bar-cursor autopair auctex)))
 '(py-force-py-shell-name-p nil)
 '(py-indent-paren-spanned-multilines-p nil)
 '(py-keep-windows-configuration nil)
 '(py-python-command-args (quote ("--pylab" "--colors=Linux")))
 '(py-shell-name "ipython")
 '(py-split-window-on-execute t)
 '(py-split-window-on-execute-threshold 2)
 '(py-underscore-word-syntax-p nil)
 '(python-shell-interpreter "ipython")
 '(send-mail-function (quote mailclient-send-it)))
;;;;FUN DEFS

(define-key (current-global-map) (kbd "C-q") 'delete-line)
(define-key (current-global-map) (kbd "C-t") 'copy-line)
(define-key (current-global-map) (kbd "M-d") 'delete-word)
(define-key (current-global-map) (kbd "<C-backspace>") 'backward-delete-word)
(define-key (current-global-map) (kbd "M-p") 'scroll-down)
(define-key (current-global-map) (kbd "M-n") 'scroll-up)
(define-key (current-global-map) (kbd "C-M-q") 'quoted-insert)
(define-key (current-global-map) (kbd "M-o") 'other-window)
(define-key (current-global-map) (kbd "M-O") 'frame-bck)
(define-key (current-global-map) (kbd "M-c") 'cua--prefix-override-handler)
(define-key (current-global-map) (kbd "M-v") 'cua-paste)
(global-set-key (kbd "M-;") 'comment-dwim-2)
(define-key (current-global-map) (kbd "C-M-<right>") 'enlarge-window-horizontally)
(define-key (current-global-map) (kbd "C-M-<left>") 'shrink-window-horizontally)
(define-key (current-global-map) (kbd "C-M-<up>") 'enlarge-window)
(define-key (current-global-map) (kbd "C-M-<down>") 'shrink-window)


(defun ns-get-pasteboard ()
      "Returns the value of the pasteboard, or nil for unsupported formats."
     (condition-case nil
         (ns-get-selection-internal 'CLIPBOARD)
       (quit nil)))
(defun flymake-get-tex-args (file-name)
  (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
(require 'flymake-cursor)
