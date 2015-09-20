(require 'python-mode)
(setq py-install-directory "~/.emacs.d/plugins/python-mode")
(setq interpreter-mode-alist
        '(lambda () (progn
		    (set-variable 'py-indent-offset 4)
		    (set-variable 'py-smart-indentation nil)
		    (set-variable 'indent-tabs-mode nil) 
                    (define-key python-mode-map "\C-m" 'newline-and-indent)
	 )
      )
)

(add-hook 'python-mode-hook
          (lambda ()
	     (autoload 'pymacs-apply "pymacs")
	     (autoload 'pymacs-call "pymacs")
	     (autoload 'pymacs-eval "pymacs" nil t)
	     (autoload 'pymacs-exec "pymacs" nil t)
	     (autoload 'pymacs-load "pymacs" nil t)
	     ))
(add-hook 'python-mode-hook
	  (lambda()
	     (require 'auto-complete-pycomplete)
	     (require 'auto-complete-config)
	     (require 'popup)
    	     (ac-config-default)
	     (local-set-key (kbd "M-/") 'auto-complete)
             (setq ac-sources '(ac-source-pycomplete
                               ))
	     ))
;; (add-hook 'python-mode-hook
;; 	  (lambda()
;; 	    (require 'company-pycomplete)
;; 	    (setq company-backends '((company-pycomplete)))
;; 	     (company-mode)
;; 	     (local-set-key (kbd "M-/") 'company-complete)
;; 	    ))

(defun my-compile ()
  "Use compile to run python programs"
  (interactive)
  (save-buffer)
  (compile (concat "python " (buffer-name))))

(defun my-compile-d ()
  "Use compile to run python programs"
  (interactive)
  (save-buffer)
  (compile (concat "python_d " (buffer-name))))


(setq compilation-scroll-output t)
(define-key python-mode-map (kbd "C-M-c") 'my-compile)
(define-key python-mode-map (kbd "C-M-v") 'my-compile-d)
(define-key python-mode-map (kbd "C-M-n") 'kill-compilation)
(define-key python-mode-map (kbd "C-M-.") 'py-shift-right)
(define-key python-mode-map (kbd "C-M-,") 'py-shift-left)
(define-key python-mode-map (kbd "<tab>") 'py-indent-line)
(define-key python-mode-map (kbd "C-M-w") 'py-execute-line)
(define-key python-mode-map (kbd "C-M-<backspace>")  'c-hungry-delete-backwards)
(define-key python-mode-map (kbd "C-<backspace>")  'backward-delete-word)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; End Auto Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;Autofill comments
;;TODO: make this work for docstrings too.
;;      but docstrings just use font-lock-string-face unfortunately
(add-hook 'python-mode-hook
          (lambda ()
            (auto-fill-mode 1)
            (set (make-local-variable 'fill-nobreak-predicate)
                 (lambda ()
                   (not (eq (get-text-property (point) 'face)
                            'Font-lock-comment-face))))))
(custom-set-faces
  '(flymake-errline ((((class color)) (:underline "red"))))
  '(flymake-warnline ((((class color)) (:underline "yellow")))))
(add-hook 'python-mode-hook
          (lambda ()
(when (load "flymake-cursor" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name))))
      (list "flake8" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pyflakes-init)))
))

(add-hook 'find-file-hook 'flymake-find-file-hook)
(provide 'python-octi)
