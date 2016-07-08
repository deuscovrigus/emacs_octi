;; Init RTags
(require 'rtags)
(setq rtags-completions-enabled t)
(rtags-enable-standard-keybindings c-mode-base-map)

(add-hook 'c++-mode-hook
         (lambda ()
	    (require 'rtags-ac)
	    (setq ac-sources '(ac-source-rtags))
    	    (require 'yasnippet)
	    (yas-minor-mode)
            (auto-complete-mode)
            (local-unset-key (kbd "M-/"))
	    (local-set-key (kbd "M-/") 'auto-complete)
             ))

;; (add-hook 'c++-mode-hook
;;          (lambda ()
;; 	    (require 'company-rtags)
;; 	    (setq company-backends '(company-rtags))
;; 	    (company-mode)
;; 	    (rtags-diagnostics)
;; 	    (local-unset-key (kbd "M-/"))
;; 	    (local-set-key (kbd "M-/") 'company-complete)
;; ))

(add-hook 'c++-mode-hook
          (lambda()
            (setq project-dir "/home/prj/janus/build/")
            (require 'compile)
            (set  (make-local-variable 'compile-command)
                  (concat "ninja -C " project-dir))
	    ))

(add-hook 'c-mode-common-hook
          (lambda()
                  (add-to-list 'auto-mode-alist '("\\.txx\\'" . c++-mode))
                  (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
                  (local-set-key (kbd "C-M-c") 'compile)
                  (local-set-key (kbd "C-M-j") 'nil)
                  (local-set-key (kbd "C-M-J") 'c-indent-new-comment-line)
                  (local-set-key (kbd "C-M-j") 'rtags-find-symbol-at-point)
                  (local-set-key (kbd "C-!") 'ff-find-other-file)
                  (local-set-key (kbd "C-,") 'rtags-location-stack-back)
                  (local-set-key (kbd "C-.") 'rtags-location-stack-forward)
                  (yas-minor-mode)
                  (setq gdb-many-windows t)
                  (setq flymake-mode nil)
))

(provide 'cpp-octi-new)
