;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;(require 'exwm)
;;(require 'exwm-config)
;;(exwm-config-default)
;;(require 'exwm-systemtray)
;;(exwm-systemtray-enable)
;;(setq exwm-systemtray-height 16)
;;(setq exwm-layout-show-all-buffers t)
;;(setq exwm-workspace-show-all-buffers t)
;;(setq exwm-workspace-number 2)
;;
;;(defun exwm-move-window-to-workspace (workspace-number)
;;  (interactive)
;;  (let ((frame (exwm-workspace--workspace-from-frame-or-index workspace-number))
;;        (id (exwm--buffer->id (window-buffer))))
;;    (exwm-workspace-move-window frame id)))
;;
;;
;;(defmacro exwm-set-key-progn (key &rest body)
;;  `(exwm-input-set-key (kbd ,key)
;;                       (lambda()
;;                         ,@body)))
;;
;;(defmacro exwm-key-to-workspace (key workspace)
;;  `(exwm-set-key-progn ,key
;;                       (interactive)
;;                       (exwm-workspace-switch ,workspace)))
;;
;;(defmacro exwm-key-send-to-workspace (key workspace)
;;  `(exwm-set-key-progn ,key
;;                       (interactive)
;;                       (exwm-move-window-to-workspace ,workspace)))
;;
;;(defmacro exwm-key-to-command (key command)
;;  `(exwm-set-key-progn ,key
;;                       (interactive)
;;                       (start-process-shell-command ,command nil ,command)))
;;
;;(exwm-key-to-workspace "s-é" 0)
;;(exwm-key-to-workspace "s-+" 1)
;;(exwm-key-to-workspace "s-ě" 2)
;;(exwm-key-to-workspace "s-š" 3)
;;(exwm-key-to-workspace "s-č" 4)
;;(exwm-key-to-workspace "s-ř" 5)
;;
;;(exwm-key-send-to-workspace "s-0" 0)
;;(exwm-key-send-to-workspace "s-1" 1)
;;(exwm-key-send-to-workspace "s-2" 2)
;;(exwm-key-send-to-workspace "s-3" 3)
;;(exwm-key-send-to-workspace "s-4" 4)
;;(exwm-key-send-to-workspace "s-5" 5)
;;
;;
;;(defun my-kill-buffer-and-window ()
;;  "Kill the current buffer and delete the selected window."
;;  (interactive)
;;  (let ((window-to-delete (selected-window))
;;	(buffer-to-kill (current-buffer))
;;	(delete-window-hook (lambda () (ignore-errors (delete-window)))))
;;    (unwind-protect
;;	(progn
;;	  (add-hook 'kill-buffer-hook delete-window-hook t t)
;;	  (if (kill-buffer (current-buffer))
;;	      ;; If `delete-window' failed before, we rerun it to regenerate
;;	      ;; the error so it can be seen in the echo area.
;;	      (when (eq (selected-window) window-to-delete)
;;		(delete-window)))))))
;;
;;(exwm-input-set-key (kbd "s-Q") #'my-kill-buffer-and-window)
;;(exwm-input-set-key (kbd "s-R") #'exwm-reset)
;;(exwm-input-set-key (kbd "s-x") #'exwm-input-toggle-keyboard)
;;(exwm-input-set-key (kbd "s-h") #'windmove-left)
;;(exwm-input-set-key (kbd "s-j") #'windmove-down)
;;(exwm-input-set-key (kbd "s-k") #'windmove-up)
;;(exwm-input-set-key (kbd "s-l") #'windmove-right)
;;(exwm-input-set-key (kbd "C-c l") #'+evil/window-move-right)
;;(exwm-input-set-key (kbd "C-c h") #'+evil/window-move-left)
;;(exwm-input-set-key (kbd "C-c j") #'+evil/window-move-down)
;;(exwm-input-set-key (kbd "C-c k") #'+evil/window-move-up)
;;(exwm-input-set-key (kbd "s-q") #'delete-window)
;;(exwm-input-set-key (kbd "C-c q") #'kill-current-buffer)
;;(exwm-input-set-key (kbd "s-,") #'exwm-workspace-switch-to-buffer)
;;(exwm-input-set-key (kbd "s-f") #'exwm-layout-toggle-fullscreen)
;;(exwm-input-set-key (kbd "s-<return>") #'+vterm/here)
;;(exwm-input-set-key (kbd "s-c") #'vterm)
;;(exwm-input-set-key (kbd "s-d") (lambda (command)
;;                                  (interactive (list (read-shell-command "$ ")))
;;                                  (start-process-shell-command command nil command)))
;;(exwm-input-set-key (kbd "s-W") #'evil-window-new)
;;(exwm-input-set-key (kbd "s-b") (lambda ()
;;                                  (interactive)
;;                                  (split-window-vertically)
;;                                  (run-with-idle-timer 0.05 nil (lambda() (windmove-down)))))
;;(exwm-input-set-key (kbd "s-v") (lambda ()
;;                                  (interactive)
;;                                  (split-window-horizontally)
;;                                  (run-with-idle-timer 0.05 nil (lambda() (windmove-right)))))
;;(exwm-input-set-key (kbd "s-L") #'evil-window-increase-width)
;;(exwm-input-set-key (kbd "s-H") #'evil-window-decrease-width)
;;(exwm-input-set-key (kbd "s-J") #'evil-window-decrease-height)
;;(exwm-input-set-key (kbd "s-K") #'evil-window-increase-height)
;;(exwm-input-set-key (kbd "s-F") #'exwm-floating-toggle-floating)
;;(exwm-input-set-key (kbd "s-<tab>") #'exwm-workspace-add)
;;(exwm-input-set-key (kbd "s-<iso-lefttab>") #'exwm-workspace-delete)
;;(exwm-key-to-command "s-M" "pavucontrol")
;;(exwm-key-to-command "<XF86AudioRaiseVolume>" "pamixer -i 5")
;;(exwm-key-to-command "<XF86AudioLowerVolume>" "pamixer -d 5")
;;(exwm-key-to-command "<XF86AudioMute>" "pamixer -t")
;;(exwm-key-to-command "s-<f6>" "pamixer --default-source -t")
;;(exwm-key-to-command "s-M" "pavucontrol")
;;
;;
;;(push ?\s-  exwm-input-prefix-keys)
;;
;;(push (kbd "<escape>") exwm-input-prefix-keys)

(setq user-full-name "Jan Novotný"
      user-mail-address "shadenk30011@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Code" :size 17 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 16))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(setq emojify-download-emojis-p t)

(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
    (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://ndossougbe.github.io/strapdown/dist/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
  (current-buffer)))

(defun md-live-prev ()
  (interactive)
  (httpd-start)
  (impatient-mode)
  (print "run: imp-set-user-filter markdown-html"))
