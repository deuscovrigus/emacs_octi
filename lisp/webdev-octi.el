(load-file "~/.emacs.d/elpa/nxhtml/autostart.el")
(add-hook 'html-mode-hook (lambda()
(progn
  (load-file "~/.emacs.d/elpa/nxhtml/autostart.el")
)))


(provide 'webdev-octi)


