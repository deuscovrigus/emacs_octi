(require 'rtags)
(rtags-enable-standard-keybindings c-mode-base-map)
(setq rtags-completions-enabled t)
(require 'cpputils-cmake)
(require 'cmake-project)
(add-hook 'c-mode-common-hook
          (lambda ()
	    (autoload 'cmake-project-mode "cmake-project")
	    (setq flymake-mode nil)
            ;; (if (derived-mode-p 'c-mode 'c++-mode)
            ;;     (cppcm-reload-all))
              ))
(add-hook 'c++-mode-hook
          (lambda ()
	    (require 'auto-complete)
	    (require 'auto-complete-config)
	    (ac-config-default)
	    (require 'popup)
	    (require 'rtags-ac)
	    (setq ac-sources '(ac-source-rtags))
    	    (require 'yasnippet)
	    (yas-minor-mode)
	    (local-set-key (kbd "M-/") 'auto-complete)
	    ))
;; (add-hook 'c++-mode-hook
;;           (lambda ()
;; 	    (require 'company-rtags)
;; 	    (setq company-backends '(company-rtags))
;; 	    (company-mode)
;; 	    (rtags-diagnostics)
;; 	    (local-unset-key (kbd "M-/"))
;; 	    (local-set-key (kbd "M-/") 'company-complete)
;; ))

(setq cppcm-get-executable-full-path-callback
      (lambda (path type tgt-name)
        ;; path is the supposed-to-be target's full path
        ;; type is either add_executabe or add_library
        ;; tgt-name is the target to built. The target's file extension is stripped
        (message "cppcm-get-executable-full-path-callback called => %s %s %s" path type tgt-name)
        (let ((dir (file-name-directory path))
              (file (file-name-nondirectory path)))
          (cond
           ((string= type "add_executable")
            (setq path (concat cppcm-build-dir "bin/" file)))
           ;; for add_library
           (t (setq path (concat cppcm-build-dir "lib/" file)))
           ))
        ;; return the new path
        (message "cppcm-get-executable-full-path-callback called => path=%s" path)
        path))

(provide 'cpp-octi-new)
