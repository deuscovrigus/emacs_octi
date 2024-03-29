(server-start)
(remove-hook 'python-mode-hook 'wisent-python-default-setup)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'package)

(add-to-list 'package-archives  '("marmalade" .  "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives  '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(progn (cd "~/.emacs.d/lisp")(normal-top-level-add-subdirs-to-load-path))
(setq mouse-wheel-progressive-speed nil)
(setq save-interprogram-paste-before-kill t)
(electric-pair-mode t)
;; no tabs and trailing white space
(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-14"))
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
(savehist-mode 1); remember minibuffer commands
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

(set-face-attribute 'default nil :height 140)
(setq case-fold-search nil)
(setq doc-view-continuous t)
(delete-selection-mode 1)
(setq split-width-threshold nil)
(setq confirm-kill-emacs 'y-or-n-p)
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions)) ; no active process prompt
;; flymake settings
;; (load "flymake")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mumamo-region ((t (:background "black")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1 --shell-escape --enable-write18")
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-source-specials-view-emacsclient-flags "--no-wait +%%l %%f")
 '(TeX-view-program-list
   (quote
    (("Okular" "okular --unique %o#src:%n%(masterdir)./%b"))))
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Okular")
     (output-html "xdg-open"))))
 '(backup-by-copying t)
 '(elpy-autodoc-delay 4)
 '(elpy-formatter (quote black))
 '(elpy-get-info-from-shell t)
 '(ipython-complete-use-separate-shell-p nil)
 '(package-selected-packages
   (quote
    (elpy neotree dockerfile-mode yaml-mode docker highlight-indent-guides flycheck json-reformat auctex)))
 '(password-word-equivalents
   (quote
    ("password" "passcode" "passphrase" "pass phrase" "mot de passe" "parola" "wachtwoord" "YubiKey for")))
 '(preview-default-document-pt 14)
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(preview-scale-function 2.0)
 '(py-force-py-shell-name-p nil)
 '(py-indent-paren-spanned-multilines-p nil)
 '(py-ipython-command-args "--automagic --simple-prompt")
 '(py-keep-windows-configuration nil)
 '(py-shell-name "ipython")
 '(py-split-window-on-execute t)
 '(py-split-window-on-execute-threshold 2)
 '(py-underscore-word-syntax-p nil)
 '(python-shell-interpreter "ipython")
 '(send-mail-function (quote mailclient-send-it))
 '(tramp-password-prompt-regexp
   "^.*\\(\\(?:adgangskode\\|contrase\\(?:\\(?:ny\\|\303\261\\)a\\)\\|geslo\\|h\\(?:\\(?:as\305\202\\|esl\\)o\\)\\|iphasiwedi\\|jelsz\303\263\\|l\\(?:ozinka\\|\303\266senord\\)\\|m\\(?:ot de passe\\|\341\272\255t kh\341\272\251u\\)\\|pa\\(?:rola\\|s\\(?:ahitza\\|s\\(?: phrase\\|code\\|ord\\|phrase\\|wor[dt]\\)\\|vorto\\)\\)\\|s\\(?:alasana\\|enha\\|lapta\305\276odis\\)\\|YubiKey for\\|wachtwoord\\)\\).*: ? *" nil (tramp)))

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
(define-key (current-global-map) (kbd "M-;") 'comment-dwim-2)
(define-key (current-global-map) (kbd "C-M-<right>") 'enlarge-window-horizontally)
(define-key (current-global-map) (kbd "C-M-<left>") 'shrink-window-horizontally)
(define-key (current-global-map) (kbd "C-M-<up>") 'enlarge-window)
(define-key (current-global-map) (kbd "C-M-<down>") 'shrink-window)
(define-key (current-global-map) (kbd "C-c g") 'revert-buffer)
(define-key (current-global-map) (kbd "C-c j") 'json-reformatter-jq-buffer)


(defun ns-get-pasteboard ()
      "Returns the value of the pasteboard, or nil for unsupported formats."
     (condition-case nil
         (ns-get-selection-internal 'CLIPBOARD)
       (quit nil)))
(defun flymake-get-tex-args (file-name)
  (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
(add-hook 'after-init-hook #'global-flycheck-mode)
