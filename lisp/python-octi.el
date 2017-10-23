(require 'python-mode)
(require 'jedi)
(remove-hook 'python-mode-hook 'wisent-python-default-setup)
(setq py-complete-function 'py-complete)
(setq py-install-directory "~/.emacs.d/lisp/plugins/python-mode")

;; generic python settings
(add-hook 'python-mode-hook
          (lambda()
            (set-variable 'py-indent-offset 4)
            (set-variable 'py-smart-indentation nil)
            (set-variable 'indent-tabs-mode nil)
            (define-key python-mode-map "\C-m" 'newline-and-indent)
           ))
;; Jedi python setup
(add-hook 'python-mode-hook
          (lambda()
            (jedi:setup)
            (setq jedi:complete-on-dot t)
            (setq jedi:server-command '("jediepcserver"))
            (delq 'ac-source-dictionary ac-sources)
            (delq 'ac-source-abbrev ac-sources)
            (delq 'ac-source-words-in-same-mode-buffers ac-sources)
            ))

;;;;;; Py-complete python setup -disabled for now

;; (add-hook 'python-mode-hook
;; 	  (lambda()
;; 	    (setq py-load-pymacs-p t)
;; 	     (require 'auto-complete-pycomplete)
;; 	     (require 'auto-complete-config)
;; 	     (require 'popup)
;;     	     (ac-config-default)
;; 	     (local-set-key (kbd "M-/") 'auto-complete)
;;              (setq ac-sources '(ac-source-pycomplete
;;                                ))
;; 	     ))

;;;;;; Company python setup

;; (add-hook 'python-mode-hook
;; 	  (lambda()
;;          (setq py-load-pymacs-p t)
;; 	    (require 'company-pycomplete)
;; 	    (setq company-backends '((company-pycomplete)))
;; 	    (company-mode)
;; 	    (local-set-key (kbd "M-/") 'company-complete)
;; 	    ))

(defun my-compile ()
  "Use compile to run python programs"
  (interactive)
  (save-buffer)
  (compile (concat "python " (buffer-name))))

(defun my-compile-d ()
  "python debug exec"
  (interactive)
  (save-buffer)
  (compile (concat "python_d " (buffer-name))))

(defun run-ipython ()
  "Use compile to run python programs"
  (interactive)
  (py-execute-buffer)
  (display-buffer "*IPython*" t)
)

(defun new-ipython-shell (&optional argprompt dedicated switch)
  "create a dedicated instance of ipyton"
  (interactive "P")
  (pop-to-buffer (py-shell argprompt t "ipython" switch))
  (end-of-buffer)
)

(setq compilation-scroll-output t)
(define-key python-mode-map (kbd "C-M-c") 'run-ipython)
(define-key python-mode-map (kbd "C-M-v") 'my-compile-d)
(define-key python-mode-map (kbd "C-M-x") 'new-ipython-shell)
(define-key python-mode-map (kbd "C-M-j") 'jedi:goto-definition)
(define-key python-mode-map (kbd "C-,") 'jedi:goto-definition-pop-marker)
(define-key python-mode-map (kbd "M-/")'jedi:complete)
(define-key python-mode-map (kbd "C-M-.") 'py-shift-right)
(define-key python-mode-map (kbd "C-M-,") 'py-shift-left)
(define-key py-shell-map "\t"  'py-shell-complete)
(define-key python-mode-map (kbd "C-M-w")  'py-execute-line)
(define-key python-mode-map (kbd "C-M-r")  'py-execute-region)
(define-key python-mode-map (kbd "C-c j")  'my-go-to-def)
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
            (require 'flymake-cursor)
            (require 'flymake-python-pyflakes)
            (flymake-python-pyflakes-load)
            (setq flymake-python-pyflakes-executable "flake8")
))

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

(custom-set-variables
 '(ipython-complete-use-separate-shell-p nil)
 '(py-python-command-args (quote ("--colors=Linux")))
 '(py-shell-name "ipython")
 '(py-force-py-shell-name-p nil)
 '(py-split-window-on-execute-threshold 2)
 '(py-keep-windows-configuration nil)
 '(py-split-window-on-execute t)
 '(py-underscore-word-syntax-p nil)
 '(py-indent-paren-spanned-multilines-p nil)
 '(python-shell-interpreter "ipython")
)
(provide 'python-octi)
