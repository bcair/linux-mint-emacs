;;; bcair-ui.el --- my theme config.  -*- no-byte-compile: t -*-

;;; Commentary:
;;;          themes --> ui
;;; code:

;; show line numbers in left margin.
;; (global-linum-mode 1)

;; I dont't like showing the background for comments in spacemacs-theme.
(use-package spacemacs-theme
  :init
  (setq spacemacs-theme-comment-bg nil)
  (setq spacemacs-theme-comment-italic t))

;; set initial frame finding that width is actually n-10 if I set it with (width . n), and more worse is that this line maybe doesn't make effection.
(setq initial-frame-alist '((width . 110) (height . 40)))

(setq custom-theme-directory "~/.emacs.d/themes/")
;; If you have lots of themes which you want to group inside a themes folder such as
;; `~/.emacs.d/themes’, the following snippet allows you to conveniently add all its
;; subfolders to the theme load path:

(let ((basedir "~/.emacs.d/themes/"))
  (dolist (f (directory-files basedir))
    (if (and (not (or (equal f ".") (equal f "..")))
             (file-directory-p (concat basedir f)))
        (add-to-list 'custom-theme-load-path (concat basedir f)))))
;; There is a good Gnu package `rainbow-mode' for designing color scheme. Please
;; add this to configure：
;; (require-package 'rainbow-mode)
;; it had been loaded in other place.
;; ------------------------------------------------------------

;; Theme profiles:
;; - Solarized-theme --> light-mode & dark-mode
;; - doom-themes
;;
;; I try to download themes provided by above list from package
;; manager system, and at future I must need to consider how to let
;; some of them be ignored by `package-initialize' for speed up start
;; there are also other themes not a form of set/suit, and each of
;; them has only one theme config either light-mode or dark-mode. I
;; just downloaded those together in custom-theme-dir.
;; ------------------------------------------------------------


;; ---> First theme suit
;; (require-package 'solarized-theme)
;; (require 'solarized-theme)
;; ---> Second theme suit
;; (require-package 'doom-themes)
;; (require 'doom-themes)

;; select dark or light theme automaticly by time
;; <http://zhangley.com/article/emacs-theme/>

;;(setq day-theme 'twilight-bright)

(setq day-theme 'spacemacs-light)
(setq dark-theme 'solarized-dark)

(defun synchronize-theme ()
  "Synchronize theme with time."
  (setq hour
        (string-to-number
         (substring (current-time-string) 11 13)))
  (if (member hour (number-sequence 6 16))
      (setq now day-theme)
    (setq now dark-theme))
  (load-theme now t))

;; eliminate some code setting font like above (font-set)

(synchronize-theme)

(defun day ()  "Turn on day theme." (interactive) (load-theme day-theme t))
(defun dark () "Turn on dark theme." (interactive) (load-theme dark-theme t))

;; (defun almono ()
;;  (interactive)
;;   "The author of theme almost-monokai didn't define it as a theme but function instaed so I define this func to load theme color-theme-almost-monokai"
;;   (load-file "~/.emacs.d/themes/color-themes/color-theme-almost-monokai.el")
;;   (color-theme-almost-monokai))

;; zenburn theme

;; If you'd like to tweak the theme by changing just a few colors, you can do so
;; by defining new values in the zenburn-override-colors-alist variable before
;; loading the theme.
;; (defvar zenburn-override-colors-alist
;;   '(("zenburn-bg+05" . "#282828")
;;     ("zenburn-bg+1"  . "#2F2F2F")
;;     ("zenburn-bg+2"  . "#3F3F3F")
;;     ("zenburn-bg+3"  . "#4F4F4F")))
;; (load-theme 'zenburn t)

(provide 'bcair-ui)
;;; bcair-ui.el ends here
