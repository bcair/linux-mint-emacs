;;; bcair-auctex.el ---  config auctex, reftex to generate PDF files   -*- no-byte-compile: t -*-
;;; Commentary:
;;;        tested on linux mint system.
;;;        ref1: https://github.com/bigclean/blogs/blob/master/emacs/auctex.mkd
;;;        ref2:
;;;
;;; Code:

;; 一直找不到preview-latex.el 文件，但是好像不影响预览功能，打开tex文件，在工具
;; 栏上可以看到“Preview”“LaTeX”选项，应该没问题，所以省去两个load语句。
;; 通过包管理器安装的auctex，省去了把auctex路径加到load-path这一步。
;; (add-to-list 'load-path
;; "~/.emacs.d/lisp/auctex/site-lisp/site-start.d")
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)

;; 如果 emacs 是运行在多需折腾的 windows 平台上，系统会加载 "tex-mik" 文件，这可以提供很多在 windows 上方便的设置。
(if (string-equal system-type "windows-nt") (require 'tex-mik))

;; 为了使用 auctex 方便，为 LaTeX 模式 hook 自动换行，数学公式，reftex 和显示行
;; 号的功能。

(mapc (lambda (mode)
        (add-hook 'LaTeX-mode-hook mode))
      (list 'auto-fill-mode
            'LaTeX-math-mode
            'turn-on-reftex
            ;; 'Tex-fold-mode
            ;; 'auto-complete-mode
            'linum-mode))

;; configuration for TeX-fold-mode
;; add entries you want to be fold, or comment that needn't to be fold.
(setq TeX-fold-env-spec-list
      (quote (("[figure]" ("figure"))
              ("[table]" ("table"))
              ("[itemize]" ("itemize"))
              ("[description]" ("description"))
              ("[tabular]" ("tabular"))
              ("[frame]" ("frame"))
              ("[array]" ("array"))
              ("[code]" ("lstlisting"))
              ;;              ("[eqnarray]" ("eqnarray"))
              )))


;; Compile TeX with SyncTeX
;; Adding the line \synctex=1 in the preamble of your TeX file will trigger synchronization with SyncTeX.
;; \documentclass{article}
;; \synctex=1
;; \usepackage{fullpage}
;; \begin{document}
;; ...
;; \end{document}
;; Alternatively, you can run the pdflatex command with the -synctex=1 option:
;; pdflatex -synctex=1 yourFile.tex

;;run latex compiler with option -shell-escape
(setq LaTeX-command-style '(("" "%(PDF)%(latex) -synctex=1 -shell-escape %S%(PDFout)")))


;; 现在 TeX 对于中文的处理基本有两种方案，CJK 宏包和 xetex。如果使用 CJK 宏包需
;; 要对字体进行配置，这也是大部分面对 TeX 最折腾的地方。相比 CJK 宏包， xetex 要
;; 方便的多。建议设置 'TeX-engine' 变量为 xetex 替代 latex 作为 tex 文件的默认排
;; 版引擎。
;; 在 LaTeX mode 中，默认开启 PDF mode，即默认使用 xelatex 直接生成 pdf 文件，
;; 而不用每次用 'C-c C-t C-p' 进行切换。设置 'Tex-show-compilation' 为 t，在另一
;; 个窗口显示编译信息，对于错误的排除很方便。另外，编译时默认直接 保存文件，绑定
;; 补全符号到 TAB 键。

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq TeX-auto-untabify t     ; remove all tabs before saving
                  TeX-engine 'xetex       ; use xelatex default
                  TeX-show-compilation t) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
            (define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)))

;; 如下的设置中就 分别定义了 SumatraPDF, Gsview 用于 Windows 平台，Okular,
;; Evince, Firefox 用于Linux 平台。

(setq TeX-view-program-list
      '(("SumatraPDF" "SumatraPDF.exe %o")
        ("Gsview" "gsview32.exe %o")
        ("Okular" "okular --unique %o")
        ("Evince" "evince %o")
        ("Firefox" "firefox %o")))

;; 对于如上的示例而言，在 Windows 平台上绑定 SumatraPDF 为 pdf viewer， Miktex
;; 的组件 Yap 为 dvi viewer，而在 Linux 平台上，或许需要 Okular 作为 pdf 与 dvi
;; 的 viewer。当然对于 Gnomer 而言，Evince 应该是比 Okular 更好 的选择。

;; 在设置好了 viewer 之后，就需要在不同类型的文件类型与相应的 viewer 之间进行绑
;; 定。'TeX-view-program-selection' 变量用于指定如何用 viewer 查看指定类型的文件。

(cond
 ((eq system-type 'windows-nt)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq TeX-view-program-selection '((output-pdf "SumatraPDF")
                                                 (output-dvi "Yap"))))))

 ((eq system-type 'gnu/linux)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq TeX-view-program-selection '((output-pdf "Evince")
                                                 (output-dvi "Evince")))))))

;;;  多文件管理
;; 我暂时不需要对多文件进行组织和管理，设置 'TeX-master' 为 t 即可， 即假设当前
;; 的文件总为 master 文件。
(setq-default Tex-master t)

;; In order to get support for many of the LaTeX packages you will use in
;; your documents, you should enable document parsing as well, which can
;; be achieved by putting
(setq TeX-auto-save t)
(setq TeX-parse-self t)
;; into your init file. Finally, if you often use \include or \input, you
;; should make AUCTeX aware of the multi-file document structure. You can
;; do this by inserting
;; (setq-default TeX-master nil)
;; into your init file. Each time you open a new file, AUCTeX will then
;; ask you for a master file.



;;; 正向与反向搜索

;; 正向与反向搜索是 tex 文件很有用的特性，它可以关联产生的 pdf 文档与源代码 tex
;; 文件，对于方便地在源文件与 pdf 文件切换更改内容。通过正搜索，你可以 从 tex 源
;; 代码处跳转到输出的 pdf 文档位置，相应地通过反向搜索你也可以从 pdf 文档的某处
;; 重定位到 tex 文件里相应的代码位置。

;; auctex 支持三种模式的正反向搜索机制：
;; source specials 仅仅适用于 DVI 文件
;; pdfsync 仅仅适用于 pdf 文件
;; SyncTeX 适用于任何文件类型，现在比较流行的做法，TeXworks 也是使用 SyncTeX 支
;; 持反向搜索。

;; 假定在 auctex 中使用 SyncTex 支持反向搜索。而为了输出文档可以支持 SyncTex，需
;; 要 latex 中设定额外的 '-synctex' 选项，因此就需要在 auctex 中 设置 LaTeX 编译
;; 时额外的行为。

;; 在 auctex 中，打开正反向搜索机制的支持是通过选项 'TeX-source-correlate-mode'
;; 控制的，而选用哪种方式是通过 'TeX-source-correlate-method' 控制的。

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)


;; configuration for reftex
(setq reftex-revisit-to-follow t
      reftex-auto-recenter-toc t)
(add-hook 'TeX-mode-hook
          (lambda ()
            (setq reftex-plug-into-AUCTeX t)
            (turn-on-reftex)
            ))

;;setting bibtex
(setq bibtex-autokey-names 1
      bibtex-autokey-names-stretch 1
      bibtex-autokey-name-separator "-"
      bibtex-autokey-additional-names "-et.al."
      bibtex-autokey-name-case-convert 'identity
      bibtex-autokey-name-year-separator "-"
      bibtex-autokey-titlewords-stretch 0
      bibtex-autokey-titlewords 0
      bibtex-maintain-sorted-entries 'plain
      bibtex-entry-format '(opts-or-alts numerical-fields))

;; make the toc displayed on the left
(setq reftex-toc-split-windows-horizontally t)
;; adjust the fraction
;; (setq reftex-toc-split-windows-fraction 0.3)



(provide 'bcair-auctex)
;;; bcair-auctex.el ends here
