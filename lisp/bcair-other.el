;;; bcair-other.el --- miscellaneous configurations    -*- no-byte-compile: t -*-
;;; Commentary:
;;;        some configurations hard to classify.
;;;
;;; Code:

;; --->
;; aspell
;; <---

;; use apsell as ispell backend
(setq-default ispell-program-name "aspell")
;; use American English as ispell default dictionary
(ispell-change-dictionary "american" t)



(provide 'bcair-other)
;;; bcair-other.el ends here
