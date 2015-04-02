(defun ring-window-mode(&optional toggle)
  (interactive)
  (let ((state (if toggle
		   (> toggle 0)
		 (if (boundp 'ring-window-mode)
		     (not ring-window-mode)
		   t))))
    (if state
	(progn 
	  (setq other-window (selected-window))
	  (setq other-window-buffer-ring '())
	  (setq display-buffer-overriding-action '(( (lambda (buffer action)
	       (setq other-window-buffer-ring (cons (window-buffer other-window) other-window-buffer-ring))
	       (select-window other-window)
	       (switch-to-buffer (buffer-name buffer)o)
	       ))))
	  (message (concat "Other window set: " (prin1-to-string other-window)))
	  )
      (progn
	(makunbound 'display-buffer-overriding-action)
	(makunbound 'other-window-buffer-ring)
	(message "ring-window-mode off")
	)
      )
    (setq ring-window-mode state)
    )
)
(defun goto-ring-window()
  (interactive)
  (if (boundp 'other-window)
      (select-window other-window)
    (message "No ring window"))
)
(defun pop-ring-window()
  (interactive)
  (if (and (boundp 'other-window) (boundp 'other-window-buffer-ring))
      (set-window-buffer other-window (pop other-window-buffer-ring))
    (message "Other window not set")
    )
)
(global-set-key (kbd "C-c o") 'goto-ring-window)
(global-set-key (kbd "C-c p") 'pop-ring-window)
