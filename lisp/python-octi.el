(package-initialize)
(elpy-enable)
;; generic python settings
(add-hook 'elpy-mode-hook
          (lambda()
            (setq elpy-shell-echo-input nil)
            (setq python-shell-interpreter "jupyter"
                  python-shell-interpreter-args "console --simple-prompt"
                  python-shell-prompt-detect-failure-warning nil)
            (add-to-list 'python-shell-completion-native-disabled-interpreters
                         "jupyter")
            (highlight-indentation-mode -1)
            (setq highlight-indent-guides-method 'character)
            (highlight-indent-guides-mode)
            (setq company-idle-delay 0.5)
            (setq company-backends '(elpy-company-backend))
            ))
(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(define-key python-mode-map (kbd "C-M-c") (kbd "C-u C-c C-y B")) ;elpy-shell-send-buffer-and-go with prefix
(define-key python-mode-map (kbd "C-M-j") 'elpy-goto-definition)
(define-key python-mode-map (kbd "C-,") 'pop-tag-mark)
(define-key python-mode-map (kbd "M-/")'elpy-company-backend)
(define-key python-mode-map (kbd "M-.") 'elpy-nav-indent-shift-right)
(define-key python-mode-map (kbd "M-,") 'elpy-nav-indent-shift-left)
;; (define-key python-mode-map (kbd "C-M-w")  'py-execute-line)
(define-key python-mode-map (kbd "C-M-r")  'elpy-shell-send-region-or-buffer)
(define-key python-mode-map (kbd "C-M-<backspace>")  'c-hungry-delete-backwards)
(define-key python-mode-map (kbd "C-<backspace>")  'backward-delete-word)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; End Auto Completion
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'python-octi)
