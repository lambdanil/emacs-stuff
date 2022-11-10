;;; package --- Summary
;;; Commentary:
;;;   My Emacs config
;;; Code:

;;;
;;;
;;; Dependencies:
;;;   clang, ripgrep
;;;
;;;

;;; Melpa and package setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;;; ----------------------------------------------------------------------------

;;; Packages
(let ((my-package-list '(dumb-jump
			 company
			 ivy
			 markdown-mode
			 flycheck)))
  (dolist (my-package my-package-list)
    (eval `(use-package ,my-package
      :ensure t))))

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))
;;;

;;; Read GNU Emacs defaults:
(if (file-readable-p "~/.gnu-emacs")
    (load "~/.gnu-emacs" nil t)
  (if (file-readable-p "/etc/skel/.gnu-emacs")
      (load "/etc/skel/.gnu-emacs" nil t)))
;;;

;;; Custom variables
(custom-set-variables
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(delete-selection-mode t)
 '(package-selected-packages
   '(ligature minimap markdown-mode ivy flycheck company dumb-jump)))
(custom-set-faces
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 120 :width normal)))))
;;; ----------------------------------------------------------------------------

;;; Basic defaults
(setq ring-bell-function 'ignore)
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;; ----------------------------------------------------------------------------

;;; Company autofill setup
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
;;; ----------------------------------------------------------------------------

;;; Global modes
(global-display-line-numbers-mode t)
(global-company-mode t)
(global-flycheck-mode t)
(ivy-mode t)
(electric-pair-mode t)
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray14")
;;; ----------------------------------------------------------------------------


;;; Minor mode for custom keymaps
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
;;; ----------------------------------------------------------------------------

;;; Custom functions
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
  (shell-command "cp ~/.bashrc ~/git/emacs-stuff/bashrc")
  (shell-command "git add .")
  (shell-command (format "git commit -m \"%s\"" (read-string "Enter commit message: ")))
  (shell-command "git push -u origin main"))

(defun pull-config-from-git ()
  "Pull config from my github."
  (interactive)
  (shell-command "mkdir -p ~/git")
  (shell-command "rm -rf ~/git/emacs-stuff")
  (setq default-directory "~/git")
  (shell-command "git clone \"https://github.com/CuBeRJAN/emacs-stuff\"")
  (shell-command "cp ~/git/emacs-stuff/emacs ~/.emacs")
  (shell-command "cp ~/git/emacs-stuff/bashrc ~/.bashrc"))
;;; ----------------------------------------------------------------------------

;;; Key bindings
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
(define-key my/keys-keymap (kbd "M-ů") #'(lambda () (interactive) (shrink-window 2)))
(define-key my/keys-keymap (kbd "M-)") #'(lambda () (interactive) (enlarge-window 2)))
(define-key my/keys-keymap (kbd "C-§") 'scroll-down-line)
(define-key my/keys-keymap (kbd "C-ů") 'scroll-up-line)
(define-key my/keys-keymap (kbd "M-ů") #'(lambda () (interactive) (scroll-up 4)))
(define-key my/keys-keymap (kbd "M-§") #'(lambda () (interactive) (scroll-down 4)))
(define-key my/keys-keymap (kbd "C-x c") #'(lambda () (interactive) (load-file "~/.emacs")))
(define-key my/keys-keymap (kbd "C-c p") 'push-config-to-git)
(define-key my/keys-keymap (kbd "C-c l") 'pull-config-from-git)
;;; ----------------------------------------------------------------------------

;;; Cursor
(setq-default cursor-type 'bar)


(provide '.emacs)
;;; .emacs ends here
