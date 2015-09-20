;;;;FUN DEFS
(defun string-replace-2(this withthat in)
 (with-temp-buffer
 (insert in)
 (goto-char (point-min))
  (while (search-forward this nil t)
	 (replace-match withthat nil t))
  (buffer-substring (point-min) (point-max))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (backward-word arg) (point))))

(defun delete-word (arg)
  "Kill characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))



(defun delete-line (&optional arg)
  (interactive "P")
  ;; taken from kill-line
  (delete-region (point)
                 ;; It is better to move point to the other end of the kill
                 ;; before killing.  That way, in a read-only buffer, point
                 ;; moves across the text that is copied to the kill ring.
                 ;; The choice has no effect on undo now that undo records
                 ;; the value of point from before the command was run.
                 (progn
                   (if arg
                       (forward-visible-line (prefix-numeric-value arg))
                     (if (eobp)
                         (signal 'end-of-buffer nil))
                     (let ((end
                            (save-excursion
                              (end-of-visible-line) (point))))
                       (if (or (save-excursion
                                 ;; If trailing whitespace is visible,
                                 ;; don't treat it as nothing.
                                 (unless show-trailing-whitespace
                                   (skip-chars-forward " \t" end))
                                 (= (point) end))
                               (and kill-whole-line (bolp)))
                           (forward-visible-line 1)
                         (goto-char end))))
                   (point))))

(defun copy-line (&optional arg)
  (interactive "P")
  ;; taken from kill-line
  (kill-ring-save (point)
  		  
                 ;; It is better to move point to the other end of the kill
                 ;; before killing.  That way, in a read-only buffer, point
                 ;; moves across the text that is copied to the kill ring.
                 ;; The choice has no effect on undo now that undo records
                 ;; the value of point from before the command was run.
                 (progn
		   (save-excursion
                   (if arg
                       (forward-visible-line (prefix-numeric-value arg))
                     (if (eobp)
                         (signal 'end-of-buffer nil))
                     (let ((end
                            (save-excursion
                              (end-of-visible-line) (point))))
                       (if (or (save-excursion
                                 ;; If trailing whitespace is visible,
                                 ;; don't treat it as nothing.
                                 (unless show-trailing-whitespace
                                   (skip-chars-forward " \t" end))
                                 (= (point) end))
                               (and kill-whole-line (bolp)))
                           (forward-visible-line 1)
                         (goto-char end))))
                   (point)  ))))
(dolist (cmd '(delete-word backward-delete-word))
  (put cmd 'CUA 'move))

(defun frame-bck()
(interactive)
(other-window-or-frame -1)
)
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))
(autoload 'cmake-mode "cmake-mode.el" t)

(defun cmake-rename-buffer ()
  "Renames a CMakeLists.txt buffer to cmake-<directory name>."
  (interactive)
  ;(print (concat "buffer-filename = " (buffer-file-name)))
  ;(print (concat "buffer-name     = " (buffer-name)))
  (when (and (buffer-file-name) (string-match "CMakeLists.txt" (buffer-name)))
      ;(setq file-name (file-name-nondirectory (buffer-file-name)))
      (setq parent-dir (file-name-nondirectory (directory-file-name (file-name-directory (buffer-file-name)))))
      ;(print (concat "parent-dir = " parent-dir))
      (setq new-buffer-name (concat "cmake-" parent-dir))
      ;(print (concat "new-buffer-name= " new-buffer-name))
      (rename-buffer new-buffer-name t)
      )
  )

(add-hook 'cmake-mode-hook (function cmake-rename-buffer))
(dolist (cmd '(delete-word backward-delete-word))
  (put cmd 'CUA 'move))
(defun frame-bck()
  (interactive)
  (other-window -1))
(provide 'generic-util-octi)
