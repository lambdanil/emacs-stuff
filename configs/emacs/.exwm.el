(unless (package-installed-p 'exwm)
  (package-install 'exwm))

(require 'exwm)
(require 'exwm-config)
(exwm-config-default)
(require 'exwm-systemtray)
(exwm-systemtray-enable)
(setq exwm-systemtray-height 16)
(setq exwm-layout-show-all-buffers t)
(setq exwm-workspace-show-all-buffers t)
(setq exwm-workspace-number 4)
(display-time-mode 1)
(setq display-time-24hr-format t)
(call-process "/usr/bin/bash" "~/.loginctl")

(defun new-vterm-exwm ()
  (interactive)
  (let ((current-prefix-arg '(4))) ;; emulate C-u
    (call-interactively 'vterm)))

(defun exwm-move-window-to-workspace (workspace-number)
  (interactive)
  (let ((frame (exwm-workspace--workspace-from-frame-or-index workspace-number))
	  (id (exwm--buffer->id (window-buffer))))
    (exwm-workspace-move-window frame id)))


(defmacro exwm-set-key-progn (key &rest body)
  `(exwm-input-set-key (kbd ,key)
			 (lambda()
			   ,@body)))

(defmacro exwm-key-to-workspace (key workspace)
  `(exwm-set-key-progn ,key
			 (interactive)
			 (exwm-workspace-switch ,workspace)))

(defmacro exwm-key-send-to-workspace (key workspace)
  `(exwm-set-key-progn ,key
			 (interactive)
			 (exwm-move-window-to-workspace ,workspace)))

(defmacro exwm-key-to-command (key command)
  `(exwm-set-key-progn ,key
			 (interactive)
			 (start-process-shell-command ,command nil ,command)))

(defun my-kill-buffer-and-window ()
  "Kill the current buffer and delete the selected window."
  (interactive)
  (let ((window-to-delete (selected-window))
	  (buffer-to-kill (current-buffer))
	  (delete-window-hook (lambda () (ignore-errors (delete-window)))))
    (unwind-protect
	  (progn
	    (add-hook 'kill-buffer-hook delete-window-hook t t)
	    (if (kill-buffer (current-buffer))
		;; If `delete-window' failed before, we rerun it to regenerate
		;; the error so it can be seen in the echo area.
		(when (eq (selected-window) window-to-delete)
		  (delete-window)))))))

(exwm-key-to-workspace "s-é" 0)
(exwm-key-to-workspace "s-+" 1)
(exwm-key-to-workspace "s-ě" 2)
(exwm-key-to-workspace "s-š" 3)
(exwm-key-to-workspace "s-č" 4)
(exwm-key-to-workspace "s-ř" 5)

(exwm-key-send-to-workspace "s-0" 0)
(exwm-key-send-to-workspace "s-1" 1)
(exwm-key-send-to-workspace "s-2" 2)
(exwm-key-send-to-workspace "s-3" 3)
(exwm-key-send-to-workspace "s-4" 4)
(exwm-key-send-to-workspace "s-5" 5)

(exwm-input-set-key (kbd "s-Q") #'my-kill-buffer-and-window)
(exwm-input-set-key (kbd "s-R") #'exwm-reset)
(exwm-input-set-key (kbd "s-x") #'exwm-input-toggle-keyboard)
(exwm-input-set-key (kbd "s-h") #'windmove-left)
(exwm-input-set-key (kbd "s-j") #'windmove-down)
(exwm-input-set-key (kbd "s-k") #'windmove-up)
(exwm-input-set-key (kbd "s-l") #'windmove-right)
(exwm-input-set-key (kbd "s-q") #'delete-window)
(exwm-input-set-key (kbd "C-c q") #'kill-current-buffer)
(exwm-input-set-key (kbd "s-,") #'exwm-workspace-switch-to-buffer)
(exwm-input-set-key (kbd "s-f") #'exwm-layout-toggle-fullscreen)
(exwm-input-set-key (kbd "s-<return>") #'new-vterm-exwm)
(exwm-input-set-key (kbd "s-c") #'vterm)
(exwm-input-set-key (kbd "s-d") (lambda (command)
				    (interactive (list (read-shell-command "$ ")))
				    (start-process-shell-command command nil command)))
(exwm-input-set-key (kbd "s-b") (lambda ()
				    (interactive)
				    (split-window-vertically)
				    (run-with-idle-timer 0.05 nil (lambda() (windmove-down)))))
(exwm-input-set-key (kbd "s-v") (lambda ()
				    (interactive)
				    (split-window-horizontally)
				    (run-with-idle-timer 0.05 nil (lambda() (windmove-right)))))
(exwm-input-set-key (kbd "s-L") #'(lambda () (enlarge-window-horizontally 2)))
(exwm-input-set-key (kbd "s-H") #'(lambda () (shrink-window-horizontally 2)))
(exwm-input-set-key (kbd "s-J") #'(lambda () (shrink-window 2)))
(exwm-input-set-key (kbd "s-K") #'(lambda () (enlarge-window 2)))
(exwm-input-set-key (kbd "s-F") #'exwm-floating-toggle-floating)
(exwm-input-set-key (kbd "s-<tab>") #'exwm-workspace-add)
(exwm-input-set-key (kbd "s-<iso-lefttab>") #'exwm-workspace-delete)
(exwm-key-to-command "s-M" "pavucontrol")
(exwm-key-to-command "<XF86AudioRaiseVolume>" "pamixer -i 5")
(exwm-key-to-command "<XF86AudioLowerVolume>" "pamixer -d 5")
(exwm-key-to-command "<XF86AudioMute>" "pamixer -t")
(exwm-key-to-command "s-<f6>" "pamixer --default-source -t")

(push ?\s-  exwm-input-prefix-keys)

(push (kbd "<escape>") exwm-input-prefix-keys)
