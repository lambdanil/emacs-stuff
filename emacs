;;; package --- Summary
;;; Commentary:
;;;   My Emacs config

(use-package dumb-jump
  :ensure t)

(use-package company
  :ensure t)

(use-package ivy
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package flycheck
  :ensure t)

;;; Code:
(if (file-readable-p "~/.gnu-emacs")
    (load "~/.gnu-emacs" nil t)
  (if (file-readable-p "/etc/skel/.gnu-emacs")
      (load "/etc/skel/.gnu-emacs" nil t)))

;;; GNU custom
(setq custom-file "~/.gnu-emacs-custom")
(load "~/.gnu-emacs-custom" t t)
;;;

(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))


(defun company-complete-common-or-cycle ()
  "Company settings."
  (interactive)
  (when (company-manual-begin)
    (if (eq last-command 'company-complete-common-or-cycle)
        (let ((company-selection-wrap-around t))
          (call-interactively 'company-select-next))
      (call-interactively 'company-complete-common))))

(define-key company-active-map [tab] 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)

(setq company-insertion-on-trigger 'company-explicit-action-p)

(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)

(global-display-line-numbers-mode t)

(global-company-mode t)
(global-flycheck-mode t)
(ivy-mode t)
(electric-pair-mode t)
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray14")

(defvar my/keys-keymap (make-keymap)
  "Keymap for my/keys-mode.")

(define-minor-mode my/keys-mode
  "Minor mode for my personal keybindings."
  :init-value t
  :global t
  :keymap my/keys-keymap)

;; The keymaps in `emulation-mode-map-alists' take precedence over
;; `minor-mode-map-alist'
(add-to-list 'emulation-mode-map-alists
             `((my/keys-mode . ,my/keys-keymap)))

(defun insert-line-above-and-jump ()
  "Insert line above current line."
  (interactive)
  (beginning-of-line)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun insert-line-below-and-jump ()
  "Insert line below current line."
  (interactive)
  (end-of-line)
  (newline-and-indent))

(defun my-enlarge-window-horizontally ()
  "Enlarge window horizontally."
  (interactive)
  (enlarge-window-horizontally 4))

(defun my-shrink-window-horizontally ()
  "Shrink window horizontally."
  (interactive)
  (shrink-window-horizontally 4))

(defun push-config-to-git ()
  "Push config to my github."
  (interactive)
  (setq default-directory "~/git/emacs-stuff")
  (shell-command "git reset --hard")
  (shell-command "git pull")
  (shell-command "cp ~/.emacs ~/git/emacs-stuff/emacs")
  (shell-command "git add .")
  (shell-command "git commit -m %s" (read-string "Enter commit message: "))
  (shell-command "git push -u origin main"))

(define-key my/keys-keymap (kbd "C-d") 'kill-line)
(define-key my/keys-keymap (kbd "C-l") 'forward-char)
(define-key my/keys-keymap (kbd "C-h") 'backward-char)
(define-key my/keys-keymap (kbd "C-k") 'previous-line)
(define-key my/keys-keymap (kbd "C-j") 'next-line)
(define-key my/keys-keymap (kbd "M-l") 'forward-word)
(define-key my/keys-keymap (kbd "M-h") 'backward-word)
(define-key my/keys-keymap (kbd "M-j") 'forward-paragraph)
(define-key my/keys-keymap (kbd "M-k") 'backward-paragraph)
(define-key my/keys-keymap (kbd "M-c") 'compile)
(define-key my/keys-keymap (kbd "C-b") 'ivy-switch-buffer)
(define-key my/keys-keymap (kbd "C-p") 'other-window)
(define-key my/keys-keymap (kbd "C-o") 'insert-line-above-and-jump)
(define-key my/keys-keymap (kbd "C-v") 'set-mark-command)
(define-key my/keys-keymap (kbd "<backtab>") 'indent-rigidly)
(define-key my/keys-keymap (kbd "C-=") 'indent-region)
(define-key my/keys-keymap (kbd "C-)") #'(lambda () (interactive) (enlarge-window-horizontally 2)))
(define-key my/keys-keymap (kbd "C-ú") #'(lambda () (interactive) (shrink-window-horizontally 2)))
(define-key my/keys-keymap (kbd "C-/") #'(lambda () (interactive) (shrink-window 2)))
(define-key my/keys-keymap (kbd "C-(") #'(lambda () (interactive) (enlarge-window 2)))
(define-key my/keys-keymap (kbd "C-§") 'scroll-down-line)
(define-key my/keys-keymap (kbd "C-ů") 'scroll-up-line)
(define-key my/keys-keymap (kbd "M-ů") #'(lambda () (interactive) (scroll-up 4)))
(define-key my/keys-keymap (kbd "M-§") #'(lambda () (interactive) (scroll-down 4)))
(define-key my/keys-keymap (kbd "C-x c") #'(lambda () (interactive) (load-file "~/.emacs")))


(setq-default cursor-type 'bar)


(provide '.emacs)
;;; .emacs ends here
