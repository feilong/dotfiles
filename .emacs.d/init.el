;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/.emacs.d")
(require 'cl)
(require 'ido)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'linum)
(require 'smooth-scrolling)
(require 'whitespace)
(require 'dired-x)
(require 'compile)
;(ido-mode t)
(menu-bar-mode -1)
;; mfl: the following line would mess up my backspace key 
; (normal-erase-is-backspace-mode 1)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(setq column-number-mode t)
(setq inhibit-startup-message t)
(setq save-abbrevs nil)
(setq show-trailing-whitespace t)
(setq suggest-key-bindings t)
(setq vc-follow-symlinks t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))))
 '(diff-added ((t (:foreground "cyan"))))
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))))
 '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light)) (:background "black"))))
 '(vertical-border ((t nil)))
)

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key "\M-=" 'align-equals)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c;" 'comment-or-uncomment-region)
(global-set-key "\M-n" 'next5)
(global-set-key "\M-p" 'prev5)
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" 'back-window)
(global-set-key "\C-z" 'zap-to-char)
; (global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-d" 'delete-word)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key "\M-u" 'zap-to-char)

;; ---------------------------
;; -- JS Mode configuration --
;; ---------------------------
(load "js-config.el")
(add-to-list 'load-path "~/.emacs.d/jade-mode") ;; github.com/brianc/jade-mode
(require 'sws-mode)
(require 'jade-mode)    
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; -------------------------------
;; -- Python Mode configuration --
;; -------------------------------
(load "python-config.el")

;; ----------------------------
;; -- Org Mode configuration --
;; ----------------------------
(load "org-config.el")

;; -----------------------------
;; -- HTML Mode configuration --
;; -----------------------------
(load "html-config.el")

(load "coffee-config.el")

;; -----------------------------
;; -- PHP-Mode configuration ---
;; -----------------------------

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))


;; -------------------------
;; -- other configuration --
;; -------------------------
(set-keyboard-coding-system nil) ;; disable OSX option key symbols
(load-theme 'color-theme-mfl t) ;; http://jasonm23.github.io/emacs-theme-editor/
; (require 'color-theme)
; (load "color-theme-mfl.el")
; (color-theme-mfl)
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (next-line)))
(global-set-key "\C-c;" 'comment-or-uncomment-region-or-line)

;; Visual line mode
(global-visual-line-mode 1)

;; Font Family
; http://stackoverflow.com/questions/5795451/how-to-detect-that-emacs-is-in-terminal-mode
; http://blog.csdn.net/ccat/article/details/5286648
(if window-system
    (progn
      (set-frame-font "Monaco-12")
      (set-fontset-font "fontset-default" 'han '("SimHei"))
      (setq face-font-rescale-alist '(("SimHei" . 1.2)))))

;; Package Management with package.el
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; EIN -- Emacs IPython Notebook
;(require 'ein)

;; kivy-mode
(require 'kivy-mode)
(add-to-list 'auto-mode-alist '("\\.kv$" . kivy-mode))

;; Octave-Mode
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))
(add-hook 'octave-mode-hook '(lambda ()
  (local-set-key (kbd "RET") 'newline-and-indent)))
(setq octave-block-offset 4)
(setq standard-indent 4)
(setq-default indent-tabs-mode nil)
;; (add-hook 'octave-mode-hook
          ;; (lambda() (setq indent-line-function 'insert-tab)))

;; Backup Files
(setq backup-directory-alist `(("." . "~/.saves")))

;; Tabs to spaces
;; (setq-default indent-tabs-mode nil)
(setq tab-width 4)
;; (global-set-key (kbd "TAB") 'indent-for-tab-command)
(setq tab-stop-list '(4 8 12 16 20 24 28 32))
;; (customize-variable (quote tab-stop-list))
;; (custom-set-variables
 ;; '(indent-line-function 'insert-tab)
 ;; '(indent-tabs-mode t)
 ;; '(tab-width 4))

;; Unicode Encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
