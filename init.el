;(load-file "~/.emacs.d/elpa/cedet/cedet-devel-load.el") 
(server-start)
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'package)
(package-initialize)
;;  (setq package-archives '(("ELPA" . "http://tromey.com/elpa/") 
;;                            ("gnu" . "http://elpa.gnu.org/packages/")
;; ("marmalade" . "http://marmalade-repo.org/packages/")))

(progn (cd "~/.emacs.d/lisp")(normal-top-level-add-subdirs-to-load-path))
 (setq mouse-wheel-progressive-speed nil)
;(set-message-beep 'silent)
(setq save-interprogram-paste-before-kill t)
(cond
 ((string-equal system-type "darwin") ; Mac OS X
  (progn
(require 'fixpath)
(setq mac-option-key-is-meta t
      mac-command-key-is-meta nil
      mac-command-modifier 'meta
      mac-option-modifier 'none)
(setq mac
(require 'ido)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)
(require 'LaTeX-octi)
(require 'cpp-octi-new)
(require 'python-octi)
(require 'generic-util-octi)
(autoload 'autopair-global-mode "autopair" nil t)
(autopair-global-mode)
(add-hook 'lisp-mode-hook
          #'(lambda () (setq autopair-dont-activate t)))

(defalias 'yes-or-no-p 'y-or-n-p)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

(defun stop-using-minibuffer ()  "kill the minibuffer"  
(when (and (>= (recursion-depth) 1) (active-minibuffer-window))    
(abort-recursive-edit)))
(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)
(require 'bar-cursor)
(autoload 'global-flyspell-mode "flyspell" "On-the-fly spelling" t)
(setq-default ispell-program-name "aspell") 
;;predictive
(add-to-list 'auto-mode-alist '("\\.cl" . c-mode))
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))
(autoload 'cmake-mode "cmake-mode.el" t)
(cua-mode t)
(setq cua-delete-copy-to-register-0 nil)
(define-key global-map (kbd "<S-down-mouse-1>") 'ignore) ; turn off font dialog
(define-key global-map (kbd "<S-mouse-1>") 'mouse-set-point)
(put 'mouse-set-point 'CUA 'move)
(setq mouse-drag-copy-region nil)
(bar-cursor-mode 1)
(ido-mode t)
(set-foreground-color "white")
(set-background-color "black")
(set-face-attribute 'default nil :height 150)
(setq case-fold-search nil)
(setq doc-view-continuous t)
(delete-selection-mode 1)
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions)) ; no active process prompt
;;Tex settingscroll

;;to set background color to lack
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1 --shell-escape --enable-write18")
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and start") (output-dvi "Skim") (output-pdf "Skim") (output-html "start"))))
 '(backup-by-copying t)
 '(cppcm-build-dirname "build_unix")
 '(ipython-complete-use-separate-shell-p nil)
 '(preview-default-document-pt 14)
 '(preview-scale-function 2.0)
 '(py-python-command-args (quote ("--pylab" "--colors=Linux")))
 '(py-shell-name "ipython")
 '(send-mail-function (quote mailclient-send-it)))
;;;;FUN DEFS

(define-key (current-global-map) (kbd "C-q") 'delete-line)
(define-key (current-global-map) (kbd "C-t") 'copy-line)
(define-key (current-global-map) (kbd "M-d") 'delete-word)
(define-key (current-global-map) (kbd "<C-backspace>") 'backward-delete-word)
(define-key (current-global-map) (kbd "M-,") 'scroll-down)
(define-key (current-global-map) (kbd "M-.") 'scroll-up)
(define-key (current-global-map) (kbd "C-M-q") 'quoted-insert)
(define-key (current-global-map) (kbd "C-;") 'comment-region)
(define-key (current-global-map) (kbd "C-:") 'uncomment-region)
(define-key (current-global-map) (kbd "M-o") 'other-window)
(define-key (current-global-map) (kbd "M-O") 'frame-bck)
(define-key (current-global-map) (kbd "M-c") 'cua--prefix-override-handler)
(define-key (current-global-map) (kbd "M-v") 'cua-paste)
(define-key (current-global-map) (kbd "M-g") 'goto-line)

(custom-set-faces
 '(flymake-errline ((((class color)) (:underline "red"))))
 '(flymake-warnline ((((class color)) (:underline "yellow"))))
 '(font-lock-comment-face ((t (:foreground "#00CD00"))))
 '(mumamo-region ((t (:background "black")))))
(defun ns-get-pasteboard () 
      "Returns the value of the pasteboard, or nil for unsupported formats." 
     (condition-case nil 
         (ns-get-selection-internal 'CLIPBOARD) 
       (quit nil))) 
(defun flymake-get-tex-args (file-name)
  (list "pdflatex" (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
(require 'flymake-cursor)
