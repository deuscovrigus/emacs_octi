(defvar toinstall '(zenburn-theme
                    company company-math jedi auctex auto-complete popup autopair flycheck
                    flymake-cursor bash-completion magit bar-cursor yasnippet cmake-mode flymake-python-pyflakes
                    cuda-mode flyspell-correct highlight-indentation))
(defun install-packages()
  (progn
    (package-initialize)
    (require 'package)
    (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;    (add-to-list 'package-archives     '("marmalade" . "http://marmalade-repo.org/packages/"))
    (package-refresh-contents)
    (dolist (p toinstall) (safe-install-package p))
    ))

(defun safe-install-package(p)
    (when (not (package-installed-p p))
      (message "%s %s %s" "====== Installing Package :" p "=======")
      (package-install p)
      )
)
