;;; bcair-tramp.el ---  tramp mode configurations   -*- no-byte-compile: t -*-
;;; Commentary:
;;;        configure tramp-mode.
;;;        http://ju.outofmemory.cn/entry/1274
;;;        (type C-c <RET> to open url)
;;; Code:

(require 'tramp)

(cond
 ((eq system-type 'windows-nt)
  (setq tramp-default-method "plink"
        tramp-password-end-of-line "\r\n"))
 ((eq system-type 'gnu/linux)
  (setq tramp-default-method "ssh")))
(setq tramp-default-user "ding"
      tramp-default-host "202.207.209.76")
;; set how many seconds passwords are cached.
(setq password-cache-expiry 36000)



;; set default used method.
;; (setq tramp-default-method "ssh")

;; set default method `alist' if which not work emacs tramp will turn to the
;; value of tramp-default-method specify to use the 'ssh' method for all user
;; names matching 'ding'.
;; format: (HOST USER METHOD)
;; (add-to-list 'tramp-default-method-alist '("" "ding" "ssh"))


(provide 'bcair-tramp)
;;; bcair-tramp.el ends here
