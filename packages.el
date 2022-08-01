(defvar toinstall '(zenburn-theme
                    company company-math jedi auctex auto-complete popup flycheck
                    bash-completion magit bar-cursor yasnippet cmake-mode
                    cuda-mode flyspell-correct highlight-indentation comment-dwim-2 elpy
                    dockerfile-mode yaml-mode docker highlight-indent-guides json-reformatter-jq))
(defun install-packages()
  (progn
    (package-initialize)
    (require 'package)
    (add-to-list 'package-archives  '("melpa" . "https://melpa.org/packages/") t)
    (package-refresh-contents)
    (dolist (p toinstall) (safe-install-package p))
    ))

(defun safe-install-package(p)
    (when (not (package-installed-p p))
      (message "%s %s %s" "====== Installing Package :" p "=======")
      (package-install p)
      )
)
