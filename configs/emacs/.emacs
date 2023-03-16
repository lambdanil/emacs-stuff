;;; package --- Summary
;;; Commentary:
;;;   My Emacs config
;;; Code:

;;;
;;;
;;; Dependencies:
;;;   clang, ripgrep, Fira font, sbcl
;;;
;;;


(defvar use-exwm nil)


;;; EXWM enable
(when use-exwm (load "~/.exwm.el"))
;;; -----------


;;; User info  ----------------------------------------------------------------
(setq user-mail-address "shadenk30011@gmail.com"
      user-full-name "Jan Novotný")
;;; ---------------------------------------------------------------------------




;;; Melpa and package setup  --------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;;; ----------------------------------------------------------------------------




;;; Packages  ------------------------------------------------------------------
(dolist (package '(dumb-jump
		   company
		   ivy
		   sudo-edit
		   sly
		   vterm
		   elfeed
		   magit
		   guix
		   tree-sitter
		   tree-sitter-langs
		   treemacs
		   ;spacemacs-theme ;; Doesn't work when added here?
		   doom-themes
		   treemacs-all-the-icons
		   markdown-mode
		   impatient-mode
		   rainbow-delimiters
		   ligature
		   flycheck))
  (unless (package-installed-p package)
    (package-install package))
  (require package))
;;; ----------------------------------------------------------------------------




;;; Custom variables  ----------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes '(doom-dracula))
 '(custom-safe-themes
   '("944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "631c52620e2953e744f2b56d102eae503017047fb43d65ce028e88ef5846ea3b" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "7ea883b13485f175d3075c72fceab701b5bf76b2076f024da50dff4107d0db25" "37768a79b479684b0756dec7c0fc7652082910c37d8863c35b702db3f16000f8" "ae426fc51c58ade49774264c17e666ea7f681d8cae62570630539be3d06fd964" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "bfc0b9c3de0382e452a878a1fb4726e1302bf9da20e69d6ec1cd1d5d82f61e3d" "dde643b0efb339c0de5645a2bc2e8b4176976d5298065b8e6ca45bc4ddf188b7" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "12ce0ae7f9f5ba28e7252d9464daea32aa0884646b6576b949edfb2ccf2bf9d4" "da75eceab6bea9298e04ce5b4b07349f8c02da305734f7c0c8c6af7b5eaa9738" "2dd4951e967990396142ec54d376cced3f135810b2b69920e77103e0bcedfba9" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "6945dadc749ac5cbd47012cad836f92aea9ebec9f504d32fe89a956260773ca4" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" default))
 '(delete-selection-mode t)
 '(package-selected-packages
   '(rainbow-mode eglot nord-theme nyan-mode rainbow-delimiters tree-sitter-langs tree-sitter magit treemacs-icons-dired spacemacs-theme treemacs-all-the-icons treemacs guix emms elfeed impatient-mode company-plisp sly-quicklisp ligature markdown-mode ivy flycheck company dumb-jump))
 '(safe-local-variable-values
   '((eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")))
 '(warning-suppress-types '((comp) (comp) (emacs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "CTDB" :slant normal :weight normal :height 120 :width normal)))))
;;; ----------------------------------------------------------------------------




;;; Ligatures  -----------------------------------------------------------------
(dolist (char/ligature-re
         `((?-  ,(rx (or (or "-->" "-<<" "->>" "-|" "-~" "-<" "->") (+ "-"))))
           (?/  ,(rx (or (or "/==" "/=" "/>" "/**" "/*") (+ "/"))))
           (?*  ,(rx (or (or "*>" "*/") (+ "*"))))
           (?<  ,(rx (or (or "<<=" "<<-" "<|||" "<==>" "<!--" "<=>" "<||" "<|>" "<-<"
                             "<==" "<=<" "<-|" "<~>" "<=|" "<~~" "<$>" "<+>" "</>" "<*>"
                             "<->" "<=" "<|" "<:" "<>"  "<$" "<-" "<~" "<+" "</" "<*")
                         (+ "<"))))
           (?:  ,(rx (or (or ":?>" "::=" ":>" ":<" ":?" ":=") (+ ":"))))
           (?=  ,(rx (or (or "=>>" "==>" "=/=" "=!=" "=>" "=:=") (+ "="))))
           (?!  ,(rx (or (or "!==" "!=") (+ "!"))))
           (?>  ,(rx (or (or ">>-" ">>=" ">=>" ">]" ">:" ">-" ">=") (+ ">"))))
           (?&  ,(rx (+ "&")))
           (?|  ,(rx (or (or "|->" "|||>" "||>" "|=>" "||-" "||=" "|-" "|>" "|]" "|}" "|=")
                         (+ "|"))))
           (?.  ,(rx (or (or ".?" ".=" ".-" "..<") (+ "."))))
           (?+  ,(rx (or "+>" (+ "+"))))
           (?\[ ,(rx (or "[<" "[|")))
           (?\{ ,(rx "{|"))
           (?\? ,(rx (or (or "?." "?=" "?:") (+ "?"))))
           (?#  ,(rx (or (or "#_(" "#[" "#{" "#=" "#!" "#:" "#_" "#?" "#(") (+ "#"))))
           (?\; ,(rx (+ ";")))
           (?_  ,(rx (or "_|_" "__")))
           (?~  ,(rx (or "~~>" "~~" "~>" "~-" "~@")))
           (?$  ,(rx "$>"))
           (?^  ,(rx "^="))
           (?\] ,(rx "]#"))))
  (apply (lambda (char ligature-re)
           (set-char-table-range composition-function-table char
                                 `([,ligature-re 0 font-shape-gstring])))
         char/ligature-re))
;;; ----------------------------------------------------------------------------




;;; Basic defaults  ------------------------------------------------------------
(setq ring-bell-function 'ignore)
(setq vc-follow-symlinks t)
(setq all-the-icons-scale-factor 1.2)
(setq confirm-kill-processes nil)
(setq kill-buffer-query-functions nil)
(setq frame-resize-pixelwise t)
(when (> (length command-line-args) 1)
  (setq inhibit-splash-screen t))
(treemacs-load-theme "all-the-icons")
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(height . 44))
(add-to-list 'default-frame-alist '(width . 140))
(setq inferior-lisp-program "sbcl")
;;; ----------------------------------------------------------------------------




;;; Company autofill setup  ----------------------------------------------------
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




;;; Global modes  --------------------------------------------------------------
(global-display-line-numbers-mode -1)
(add-hook 'prog-mode-hook #'(lambda () (display-line-numbers-mode t)))
(global-prettify-symbols-mode t)
(global-company-mode t)
(global-flycheck-mode t)
(ivy-mode t)
(global-tree-sitter-mode 1)
(electric-pair-mode t)
(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :inherit nil :background "gray14")
(desktop-save-mode -1)
(setf nyan-animate-nyancat t)
(setf nyan-animation-frame-interval 0.05)
(setf nyan-wavy-trail t)
(nyan-mode t)
;;; ----------------------------------------------------------------------------




;;; Minor mode for custom keymaps  ---------------------------------------------
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




;;; Custom functions  ----------------------------------------------------------
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

(defun new-vterm ()
  (interactive)
  (let ((current-prefix-arg '(4))) ;; emulate C-u
    (call-interactively 'vterm)))

(defun dired-open-file ()
  "In Dired, open the file named on this line."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (call-process "xdg-open" nil 0 nil file)))

(defun insert-above-and-jump ()
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

(defun markdown-html (buffer)
  "Markdown HTML filter, supply BUFFER."
  (princ (with-current-buffer buffer
	   (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://ndossougbe.github.io/strapdown/dist/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
	 (current-buffer)))

(defun markdown-impatient-start ()
  "Start impatient mode with filter."
  (interactive)
  (impatient-mode)
  (httpd-start)
  (imp-set-user-filter 'markdown-html))
;;; ----------------------------------------------------------------------------




;;; Global key bindings  -------------------------------------------------------
(when (not use-exwm) ;; Some bindings don't work properly in exwm when defined this way, so they are defined in the exwm config instead.
  (define-key my/keys-keymap (kbd "C-<return>") 'new-vterm)
  (define-key my/keys-keymap (kbd "C-)") #'(lambda () (interactive) (enlarge-window-horizontally 2)))
  (define-key my/keys-keymap (kbd "C-ú") #'(lambda () (interactive) (shrink-window-horizontally 2)))
  (define-key my/keys-keymap (kbd "M-ú") #'(lambda () (interactive) (shrink-window 2)))
  (define-key my/keys-keymap (kbd "M-)") #'(lambda () (interactive) (enlarge-window 2))))
(define-key my/keys-keymap (kbd "C-d") 'kill-line)
(global-set-key (kbd "C-l") 'forward-char)
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
(define-key my/keys-keymap (kbd "C-§") 'scroll-down-line)
(define-key my/keys-keymap (kbd "C-ů") 'scroll-up-line)
(define-key my/keys-keymap (kbd "M-ů") #'(lambda () (interactive) (scroll-up 4)))
(define-key my/keys-keymap (kbd "M-§") #'(lambda () (interactive) (scroll-down 4)))
(define-key my/keys-keymap (kbd "C-x c") #'(lambda () (interactive) (load-file "~/.emacs")))
(define-key my/keys-keymap (kbd "C-c r") 'replace-string)
(define-key my/keys-keymap (kbd "M-/") 'undo-redo)
(define-key my/keys-keymap (kbd "M-/") 'undo-redo)
(define-key my/keys-keymap (kbd "C-c n") 'elfeed)
(define-key my/keys-keymap (kbd "C-c y") 'yank-from-kill-ring)
(define-key my/keys-keymap (kbd "C-c p") 'treemacs)
(define-key my/keys-keymap (kbd "C-c l") 'treemacs-select-directory)
(define-key my/keys-keymap (kbd "C-c t") 'new-vterm)
(define-key my/keys-keymap (kbd "M-w") 'copy-region-as-kill)
(define-key my/keys-keymap (kbd "C-c h") 'help)
(define-key my/keys-keymap (kbd "C-c v") #'(lambda ()
					     (interactive)
					     (split-window-horizontally)
					     (run-with-idle-timer 0.05 nil
								  'windmove-right)))
(define-key my/keys-keymap (kbd "C-c c") #'(lambda ()
					     (interactive)
					     (split-window-vertically)
					     (run-with-idle-timer 0.05 nil
								  'windmove-down)))
(define-key my/keys-keymap (kbd "C-c q") 'delete-window)
(define-key my/keys-keymap (kbd "C-c C-q") 'my-kill-buffer-and-window)
(define-key my/keys-keymap (kbd "C-c d") #'(lambda (command)
					     (interactive (list (read-shell-command "$ ")))
					     (start-process-shell-command command nil command)))
(define-key dired-mode-map (kbd "C-c o") 'dired-open-file)
;;; ----------------------------------------------------------------------------




;;; Per-mode stuff -------------------------------------------------------------
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
;; Lisp mode -----
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'common-lisp-mode-hook #'(lambda ()
				     (local-set-key (kbd "C-c d") 'sly-eval-defun)
				     (local-set-key (kbd "C-c r") 'sly-eval-region)
				     (local-set-key (kbd "C-c b") 'sly-eval-buffer)))

;; Markdown mode -
(add-hook 'markdown-mode-hook #'(lambda ()
				  (markdown-impatient-start))) ; Impatient mode live preview
;;; ----------------------------------------------------------------------------




;;; Elfeed ---------------------------------------------------------------------
(setq elfeed-feeds
      '(("https://www.root.cz/rss/clanky" root.cz)
        ("https://www.root.cz/rss/zpravicky" root.cz)
        ("https://forum.root.cz/index.php?action=.xml;type=rss2;limit=30;sa=news" root.cz forum)))
;;; ----------------------------------------------------------------------------



;;; Cursor
(setq-default cursor-type 'bar)




(provide '.emacs)
;;; .emacs ends here
