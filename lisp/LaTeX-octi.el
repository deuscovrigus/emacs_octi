(load "auctex.el" nil t t)
(setq LaTeX-using-Biber nil)
;(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook (lambda()
			     (setq TeX-auto-save t)
			     (setq TeX-parse-self t)
	      		     (require 'company)
	      		     (require 'company-math)
	      		     (company-mode)
	      		     (setq-local company-backends
			     		 '(company-math-symbols-latex company-latex-commands ))
			     (local-set-key (kbd "M-/") 'company-complete)
			    ))

(add-hook 'LaTeX-mode-hook '(lambda()
			      (require 'yasnippet)
			      (yas-minor-mode)
	      ))
(eval-after-load "flyspell"
  '(define-key flyspell-mode-map (kbd "C-;") nil))
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checking"
t)

(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook (lambda ()
  (TeX-global-PDF-mode t)
  (push 
    '("Latexmk" "latexmk -pdflatex='pdflatex -file-line-error -synctex=1' -pdf %s" Tex-run-TeX nil t
      :help "Run Latexmk on file")
    TeX-command-list)))

(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
(add-hook 'LaTeX-mode-hook
	(lambda()
	(add-to-list 'TeX-command-list
			(list "TexifyPDF"
          "latexmk -pdflatex='pdflatex -file-line-error -synctex=1' -pdf %s"
         'TeX-run-command nil t))
	))
(add-hook 'LaTeX-mode-hook
	(lambda()
	(add-to-list 'TeX-command-list
			(list "All Texify run-viewer"
         "texify --tex-option=--src --run-viewer --clean %t --pdf"
         'TeX-run-command nil t))
	))
(add-hook 'LaTeX-mode-hook
	(lambda()
	(add-to-list 'TeX-command-list
			(list "LaTeX-diff"
         "latexdiff-vc --svn --force --pdf -r %t"
         'TeX-run-command t nil))
	))


(add-hook 'LaTeX-mode-hook
      (lambda()
        (add-to-list 'TeX-expand-list
             '("%q" skim-make-url))))

(defun skim-make-url () (concat
        (TeX-current-line)
        " "
        (expand-file-name (funcall file (TeX-output-extension) t)
            (file-name-directory (TeX-master-file)))
        " "
        (buffer-file-name)))

(add-hook 'LaTeX-mode-hook
	(lambda()
(setq TeX-view-program-list
      '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o") ("Preview" "open -a Preview.app %o")))
       ))
(custom-set-variables
 '(LaTeX-command "latex -synctex=1 --shell-escape --enable-write18")
 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and start") (output-dvi "Skim") (output-pdf "Skim") (output-html "start"))))
 '(preview-default-document-pt 14)
 '(preview-scale-function 2.0)
 )
;;;;FUN DEFS
(defun do-Texify ()
   "Texify the curent file."
   (interactive)
   (save-buffer)
   (TeX-command-menu "TexifyPDF")
 )
(defun do-All-LaTeX ()∑
   "Texify the curent file and view."
   (interactive)
   (save-buffer)
   (TeX-command-menu "LaTeX")
)
(defun do-preview-env ()
   "Texify the curent env and view."
   (interactive)
   (save-buffer)
   (preview-environment 1)
)
(defun do-preview-sec ()
   "Texify the curent sec and view."
   (interactive)
   (save-buffer)
   (preview-section)
)
(defun do-diff ()
  "do latex-diff"
  (interactive)
  (TeX-command-menu "LaTeX-diff")
)
(defun do-diff-open ()
   "Do LateX-diff then view files"
   (interactive)
   (save-buffer)
   (setq my-string (TeX-master-file))
   (setq args_s (concatenate 'string "--svn --force --pdf -r " my-string)) 
   (print args_s t)
   (setq args_f (concatenate 'string my-string ".tex"))
   (print args_f t)
   (call-process "latexdiff-vc" nil "blablu" t "--svn" "--force" "-r" args_f)

   (find-file-existing (concatenate 'string my-string "-diff.tex"))
   ;;(find-file my-string)
   (TeX-command-menu "All Texify run-viewer"))

(defalias 'lower_index
  (read-kbd-macro "_{} <left>"))
(defalias 'upper_index
  (read-kbd-macro "^{} <left>"))
(defalias 'frc
  (read-kbd-macro "\\frac{}{} <left><left><left>"))
  (defalias 'paren
  (read-kbd-macro "\\left(\\right) M-b <left>"))
(add-hook 'LaTeX-mode-hook
  '(lambda nil
       (define-key LaTeX-mode-map (kbd "C-`") 'TeX-next-error)
	   (define-key LaTeX-mode-map (kbd "C-M-x") 'do-All-LaTeX)
	   (define-key LaTeX-mode-map (kbd "C-M-c") 'do-Texify)
	   (define-key LaTeX-mode-map (kbd "C-^") 'upper_index)
	   (define-key LaTeX-mode-map (kbd "C-_") 'lower_index)
	   (define-key LaTeX-mode-map (kbd "C-#") 'frc)
	   (define-key LaTeX-mode-map (kbd "C-(") 'paren)
	   (define-key LaTeX-mode-map (kbd "C-M-z") 'do-preview-env)
	   (define-key LaTeX-mode-map (kbd "C-M-w") 'do-preview-sec)
	   (define-key LaTeX-mode-map (kbd "C-M-v") 'preview-clearout-at-point)
	   (define-key LaTeX-mode-map (kbd "C-M-l") 'do-diff-open)
         )) 	
(provide 'LaTeX-octi)
