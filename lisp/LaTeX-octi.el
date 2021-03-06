;(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook (lambda()
                             (load "auctex.el" nil t t)
                             (setq LaTeX-using-Biber nil)
                             (visual-line-mode)
                             (flyspell-mode)
                             (LaTeX-math-mode)
                             (turn-on-reftex)
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

(require 'flyspell-correct)
(define-key flyspell-mode-map (kbd "C-M-;") 'flyspell-correct-previous-word-generic)
(setq reftex-plug-into-AUCTeX t)

(if (or (eq system-type 'darwin) (eq system-type 'gnu/linux))
                                        ; something for OS X if true
                                        ; optional something if not

    (add-hook 'LaTeX-mode-hook (lambda ()
                                 (message "%s" "System detected as windows")
                                 (add-to-list 'TeX-command-list
                                              '("TexifyPDF" "latexmk -pdflatex='pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -shell-escape -enable-restricted' -pdf %s" TeX-run-command nil :help "Texify document to pdf (resolves all cross-references, etc.)") t)
                                 (TeX-global-PDF-mode t)
                                 (TeX-PDF-mode t)
                                 (setq TeX-command-default "TexifyPDF")
                                 )))

;;;; Mac only settings

(if (eq system-type 'darwin)
    (add-hook 'LaTeX-mode-hook
	(lambda()
	(setq TeX-view-program-list
         '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b %n %o") ("Preview" "open -a Preview.app %o")))
	(defun skim-make-url () (concat
        (TeX-current-line)
        " "
        (expand-file-name (funcall file (TeX-output-extension) t)
            (file-name-directory (TeX-master-file)))
        " "
        (buffer-file-name)))

	(add-to-list 'TeX-expand-list
             '("%q" skim-make-url))
	(custom-set-variables
	 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and start") (output-dvi "Skim") (output-pdf "Skim") (output-html "start")))))
       )))
;;; Linux Gnu hooks
(if (eq system-type 'gnu/linux)
 (add-hook 'LaTeX-mode-hook
           (lambda()
            (push '("%(masterdir)" (lambda nil (file-truename (TeX-master-directory))))
        TeX-expand-list)
  (custom-set-variables
   '(TeX-source-correlate-method (quote synctex))
   '(TeX-source-correlate-mode t t)
   '(TeX-source-correlate-start-server t)
   '(TeX-source-specials-view-emacsclient-flags "--no-wait +%%l %%f")
   '(TeX-view-program-list (quote (("Okular" "okular --unique %o#src:%n%(masterdir)./%b"))))
   '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "xdvi") (output-pdf "Okular") (output-html "xdg-open"))))
   ))))

;; windows hooks
(if (eq system-type 'windows-nt)
    (add-hook 'LaTeX-mode-hook
              (lambda()
                (message "%s" "System detected as windows")
                (add-to-list 'TeX-command-list
                             (list "TexifyPDF"
                                   "texify --tex-option=--src --run-viewer --clean %t --pdf"
                                   'TeX-run-command nil t))
                (add-to-list 'TeX-view-program-list-builtin list "TeXworks" "miktex-texworks %o")
                (custom-set-variables
                 '(TeX-source-correlate-method (quote synctex))
                 '(TeX-source-correlate-mode t t)
                 '(TeX-source-correlate-start-server t)
                 '(TeX-source-specials-view-emacsclient-flags "--no-wait +%%l %%f")
                 '(TeX-view-program-list (quote (("Sumatra" ("SumatraPDF.exe -reuse-instance" (mode-io-correlate " -forward-search %b %n") " %o")))))
                 '(TeX-view-program-selection (quote (((output-dvi style-pstricks) "dvips and gv") (output-dvi "gs") (output-pdf "Sumatra") (output-html "xdg-open"))))
                 ))))

;; system invariant hooks
(add-hook 'LaTeX-mode-hook
          (lambda()

            (custom-set-variables
             '(LaTeX-command "latex -synctex=1 --shell-escape --enable-write18")
             '(preview-default-document-pt 14)
             '(preview-gs-options (quote ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
             '(preview-scale-function 2.0)
             )))
;;;;FUN DEFS
(defun do-Texify ()
   "Texify the curent file."
   (interactive)
   (save-buffer)
   (TeX-command-menu "TexifyPDF")
 )
(defun do-All-LaTeX ()
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
