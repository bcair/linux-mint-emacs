;;; bcair-unix.el ---  forms to evaluate with/after start "unix" server
;;; -*- no-byte-compile: t -*-
;;; Commentary:
;;;        This file lists forms to evaluate with/after start "unix" server,
;;;        so I can use such shell code:
;;;        : alias emu='emacs --eval "(load-file \"/path/to/this/file \")" --daemon --debug-init '
;;;
;;; Code:

;; Automatically ssh remote unix server, and load a different theme for
;; emacs-server "unix".

;; please add this to your .bashrc file, do not ignore the two symbols "\".
;; alias emu='emacs --eval "(load-file \"~/.emacs.d/lisp/bcair-unix.el\")" --daemon --debug-init '
;; It will start server failed if loss two "\" characers.

;; So all the configures and optimizations collected in this file could be load
;; after start "unix" server.

(progn
  (load-theme 'monokai t )
  (setq server-name "unix")
  (find-file "/ssh::")
  ;; (find-file "/ssh:ding@202.207.209.76:")
  (switch-to-buffer "ding")
  (eshell)
  )

;; -----------------------------------------------
;; (find-file "/ssh::")
;; (find-file "/ssh:ding@202.207.209.76:")
;; (switch-to-buffer "ding")
;; (eshell)
;; -----------------------------------------------
;;; `WRONG'
;; above four s-expressions had been commonted because those need insert keypass
;; of remote ssh contact and this operation maybe didn't work in the way I
;; designed now. So just load-theme and name server-name.
;; -----------------------------------------------
;;; `RIGHT'
;; It is possible to add above four forms into bcair-unix.el and start emacs
;; daemon mode with correct option
;; " --eval "(load-file \"/home/bcair/.emacs.d/lisp/bcair-unix.el\")" "
;; after inserting passkey of login remote machine "unix" server will be start
;; successfully


(provide 'bcair-unix)
;;; bcair-unix.el ends here
