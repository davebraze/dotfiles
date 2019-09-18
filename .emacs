;;;;;;;;; NOTES

;; to take advantage of emacsclient, call 1st emacs instance as
;; > emacsclientw.exe -na runemacs.exe -c
;; possibly set up shortcut like this:
;; "C:\Program Files (x86)\GNU Emacs 23.1\bin\emacsclientw.exe" -na runemacs.exe -c

;; Install new packages by calling "M-x package-list-packages"
;; The package manager installs packages to directories under "~/.emacs.d/elpa/"
;; and adds the new package directory to load-path.

;;;;;;;;; beginning of my dot-emacs

;;;; general customization  ;;;;;;
(setq inhibit-startup-message        t
      visible-bell                   t
      gnus-inhibit-startup-message   t
      inhibit-default-init           nil
      insert-default-directory       nil
      default-major-mode             'indented-text-mode
      fill-column                    100
      search-exit-option             nil	  ; require ESC to end an incremental search
      search-highlight               t
      scroll-step                    '1
      sort-fold-case                 t            ; Do NOT sort uppercase before lower case
      uniquify-buffer-name-style     'post-forward
      line-number-display-limit      nil
      compilation-scroll-output      t		  ; force compilation window to scroll automatically
      truncate-partial-width-windows t            ; don't wrap lines
      truncate-lines                 t            ;
      gnuserv-frame (selected-frame)		  ; open files in existing frame
      next-line-add-newlines         nil	  ; don't add newlines if cursor goes past last line
      column-number-mode             t		  ; show column numbers
      highlight-nonselected-windows  t
      eol-mnemonic-dos               "DOS"
      eol-mnemonic-unix              "Unix"
      eol-mnemonic-mac               "Mac"
      eol-mnemonic-undecided         "?"
      ; ls-lisp-use-insert-directory-program t      ; use gnu ls instead of the elisp emulation
      )

;; more customization
(display-time)
(tool-bar-mode -1)


(global-set-key (kbd "C-c t") 'insert-time)
(defun insert-time ()
  "Insert the current time in 24 hour format"
  (interactive)
  (insert (format-time-string "%H:%M")))

(global-set-key (kbd "C-c d") 'insert-date)
(defun insert-date ()
  "Insert the current date in long format"
  (interactive)
  (insert (format-time-string "%B %d, %Y")))


;; coding system stuff
;; (prefer-coding-system 'utf-8-with-signature-dos)
;; (setq coding-system-for-read 'utf-8-with-signature-dos)
;; (setq coding-system-for-write 'utf-8-with-signature-dos)
; also consider (setq-default buffer-file-coding-system 'utf-8-with-signature-dos)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; keep recent file list across sessions
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 20)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;;; pre-load some stuff ;;;;
(require 'uniquify)		  ; ensure unique mode lines
(require 'hl-line)                ; highlight the current line
(require 'package)
(package-initialize)              ; this causes a weird warning on startup. Do I need it?
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

;(require 'fdb-misc)               ; some of my own utility functions
;(require 'jka-compr)              ; see if this does anything interesting
(server-start)			  ; use emacsclientw.exe for file associations and 'sendto' menu.

;; control minibuffer completion behavior. See complete.el
(setq PC-meta-flag nil)

;;; window setup ;;;
;; frame title set to file name with path or to buffer name for buffers not associated with files
(setq frame-title-format
      (list 'buffer-file-name
	    (concat " %f")
	    (concat " %b")))
(setq-default icon-title-format "%b")	; set icon title to buffer name


;; geometry
;;
;; for initial values, position window as desired and then run these functions (c-x c-e)
;; (frame-position) ;; pixels
;; (frame-text-height) ;; in pixels
;; (frame-text-width)
;; (frame-height) ;; in characters
;; (frame-width)

;; figure out how to set frame width/height as a proportion of screen size
;; (ffloor (* (display-pixel-width) .40))
;; (- (display-pixel-height) 65)
(setq initial-frame-alist
      '((top . 0)
	(left . 100)
	;; (height . (text-pixels . (- (display-pixel-height) 65)))
	;; (width . (text-pixels . (ffloor (* (display-pixel-width) .40))))))
	(height . (text-pixels . 1375))
	(width . (text-pixels . 1024))))

(setq default-frame-alist
      '((top . 20)
	(left . 162)
 	(width . 100)
	(height . 55)
 	(cursor-color . "blue")
 	(cursor-type . box)
 	(foreground-color . "black")
 	(background-color . "ivory")
	(font . "-outline-Consolas-normal-normal-normal-mono-*-*-*-*-c-*-iso8859-1")))

;; more face settings
(copy-face 'highlight 'my-hl-line)
(set-face-background 'my-hl-line "cornsilk2")
(setq hl-line-face 'my-hl-line)

(set-face-attribute 'mode-line
                    nil
                    :foreground "black"
                    :background "lightgreen"
                    :box '(:line-width 1 :style released-button))
(set-face-attribute 'mode-line-inactive
                    nil
                    :foreground "black"
                    :background "darkgreen"
                    :box '(:line-width 1 :style released-button))

;; (set-face-attribute 'menu
;; 		    nil)


;; (set-face-attribute 'default nil :height 75)
;; (set-face-font 'bold-italic "-outline-Consolas-normal-italic-normal-mono-*-75-*-*-c-*-iso8859-1")
;; (set-face-font 'italic "-outline-Consolas-bold-italic-normal-mono-*-75-*-*-c-*-iso8859-1")
;; (set-face-font 'bold "-outline-Consolas-bold-normal-normal-mono-*-75-*-*-c-*-iso8859-1")
;; (set-face-font 'default "-outline-Consolas-normal-normal-normal-mono-*-75-*-*-c-*-iso8859-1")

;; ; A long font name has the following form. Change the value of HEIGHT to change font size.
;; ; look in emacs info node 'font X' for details:
;; ; -MAKER-FAMILY-WEIGHT-SLANT-WIDTHTYPE-STYLE-PIXELS-HEIGHT-HORIZ-VERT-SPACING-WIDTH-CHARSET
;; ;; run this code to find list of available fonts
;; ;;(insert (prin1-to-string (x-list-fonts "*")))

;;;; because I'm impatient ;;;
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)

;;;;;; Mode Specific Stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; aspell ;;;;
;; download and install:
;; aspell http://ftp.gnu.org/gnu/aspell/w32/Aspell-0-50-3-3-Setup.exe
;; English dictionary http://ftp.gnu.org/gnu/aspell/w32/Aspell-en-0.50-2-3.exe.

;; point to aspell binary
(setq-default ispell-program-name "aspell.exe")
(add-to-list 'exec-path  "D:/winbin/Aspell/bin/")
(setq ispell-personal-dictionary "~/.ispell")
(require 'ispell)

;;;; org mode extensions
;;;; ox-pandoc
;; install pandoc: http://pandoc.org/installing.html
;; Windows installer gives no choice about where to locate pandoc: C:\Users\Dave\AppData\Local\Pandoc\pandoc.exe
(require 'ox-html5slide) ;; export to html5 slide
(require 'ox-ioslide)    ;; export to Google I/O html5 slide
(require 'ox-pandoc)     ;; org exporter for pandoc
(require 'ox-reveal)     ;; reveal.js slideshow exporter
(require 'ox-tufte)      ;; Tufte html exporter



;;;; arc-mode ;;;
(setq
 archive-zip-use-pkzip   nil
 archive-zip-extract     '("unzip" "-qq" "-p")
 archive-zip-expunge     '("zip" "-q" "-d")
 archive-zip-update      '("zip" "-q")
 archive-zip-update-case '("zip" "-q" "-k"))

;;;; c-mode ;;;
;(setq c-mode-hook nil)
(add-hook 'c-mode-hook
	  #'(lambda ()
	      (setq comment-column 35
		    truncate-lines t)
	      (message "c-mode-hook done")))

;;;; csv-mode
(add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode))
(autoload 'csv-mode "csv-mode"
  "Major mode for editing comma-separated value files." t)

;;;; delim-col
;; useful for formatting data copied from spreadsheet and pasted into R scripts
(setq delimit-columns-str-before "")
(setq delimit-columns-str-after "")
(setq delimit-columns-str-separator "")
(setq delimit-columns-before "")
(setq delimit-columns-after " ")
(setq delimit-columns-separator "\t")
(setq delimit-columns-format 'separator)
(setq delimit-columns-extra t)

;;;; projectile ;;;;
(projectile-mode)

;;;; dired ;;;
(add-hook 'dired-load-hook
 	  #'(lambda ()
 	      (require 'dired-x)
 	      (setq dired-x-hands-off-my-keys t)
; 	      (require 'dired-a)
 	      (message "dired-load-hook done")))

(add-hook 'dired-mode-hook
	  #'(lambda ()
 	      (message "dired-mode-hook done")))

(add-hook 'dired-after-readin-hook
 	  #'(lambda ()
 	      (hl-line-mode 1)
 	      (message "dired-after-readin-hook done")))

;;;; elpy seems broken, sort it out
;;;; elpy mode, for python ;;;
(setq python-shell-prompt-detect-failure-warning nil)
(setq python-shell-completion-native-enable nil)
(elpy-enable) ; something strange going on here in combination with (package-initialize)
(defun python-shell-send-line ()
  "Select the current line and send to Python. Advance to next line."
  (interactive)
  (end-of-line)						; Move to end of line
  (set-mark (line-beginning-position))			; Mark to beginning
  (call-interactively 'python-shell-send-region)	; Send region
  (next-line)
  )
(add-hook 'python-mode-hook		; For Python script
          #'(lambda()
	     (local-set-key (kbd "<C-return>") 'python-shell-send-line)
	     ))


;;;; emacs-lisp-mode ;;;
(add-hook 'emacs-lisp-mode-hook
	  #'(lambda ()
	      (setq comment-column 60
		    fill-column 120
		    truncate-lines t)
	      (message "emacs-lisp-mode-hook done")))

;;;; ESS-mode ;;;
(setq ess-use-eldoc                  'script-only
      inferior-ess-own-frame         nil
      inferior-ess-same-window       nil
      ess-help-own-frame             'one)          ; all ess help goes to same dedicated frame

(add-hook 'ess-mode-hook
          #'(lambda ()
              (local-set-key (vector '(meta s))
			     'nonincremental-repeat-search-forward)
              (local-set-key (vector '(control ?:)) 'comment-dwim)
              (font-lock-mode t)
	      (electric-pair-local-mode)
              (setq truncate-lines                 t
		    ess-nuke-trailing-whitespace-p nil            ; leaving trailing whitespace alone. Important for Rmarkdown files.
                    fill-column                    100
                    comment-column                 40)
              (message "ess-mode-hook done")))

;;;; font-lock ;;;
(add-hook 'font-lock-mode-hook
	  #'(lambda ()
 	      (setq font-lock-maximum-decoration t)        ; Maximum colors
 	      (set-face-foreground font-lock-comment-face "darkcyan")
 	      (set-face-foreground font-lock-constant-face "darkred")))

(global-font-lock-mode t)	      ; Turn on font-lock in all modes that support it

;; ;;;; magit-mode ;;;
(setenv "GIT_ASKPASS" "git-gui--askpass")
;; (setq shell-file-name explicit-shell-file-name)
(add-to-list 'exec-path "D:/winbin/Git/bin") ;; why don't I just put git on the PATH?

;;;; matlab-mode ;;;
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)
(add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))

(setq matlab-shell-command-switches (quote ("-nojvm -nosplash"))
      matlab-shell-echoes           t
      matlab-shell-input-ring-size  128
      )

(add-hook 'matlab-mode-hook
          #'(lambda ()
              (local-set-key (vector '(meta s))
			     'nonincremental-repeat-search-forward)
              (local-set-key (vector '(control ?:)) 'comment-dwim)
              (font-lock-mode t)
              (setq truncate-lines t
                    fill-column    100
                    comment-column 40)
              (message "matlab-mode-hook done")))

;;;; markdown-mode ;;;
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; ;;;; Use polymode for rmarkdown files ;;;;
;; (setq load-path
;;       (append '("c:/users/Dave/.emacs.d/polymode"  "c:/users/Dave/.emacs.d/polymode/modes")
;;               load-path))
;; (require 'poly-R)
;; (require 'poly-markdown)
;; (add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

;;;; msb ;;;; mouse buffer menu minor mode
(msb-mode)

;;;;  text-mode ;;;
(toggle-text-mode-auto-fill)			 ; always auto-fill in text mode
(add-hook 'text-mode-hook
	  #'(lambda ()
	      (turn-on-auto-fill)
	      (setq truncate-lines t
		    fill-column 120)
	      (local-set-key "\M-s" 'nonincremental-repeat-search-forward)
	      (message "text-mode-hook done")))

;; ;;;; TRAMP for remote editing ;;;
;; ;; tramp won't work under windows until
;; ;; 1. tramp-sh.el is re-byte-compiled
;; ;; 2. M-x tramp-cleanup-all-connections <ret>
;; ;;
;; ;; To use do method:host:file
;; ;;
;; (require 'tramp)
;; (setq tramp-default-method "plink"
;;       tramp-default-user "braze"
;;       tramp-default-host "camille.haskins.yale.edu"
;;       )

;; ;;;; web-mode ;;;;
; (require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))


;; ;;;;;; Key Maps ;;;;;;

;;; Keys ;;;
;; CTL Keys ;;
(global-set-key (vector '(control I)) 'isearch-forward-regexp)
(global-set-key (vector '(control s)) 'nonincremental-re-search-forward)
(global-set-key (vector '(control r)) 'redraw-display)
(global-set-key (vector '(control n)) 'rename-buffer)
(global-set-key (vector '(control f)) 'forward-word)
(global-set-key (vector '(control z)) 'undo)
(global-set-key (vector '(control l)) 'goto-line)

;; esc-map / Alt-keys in NTemacs ;;
(global-set-key (vector '(meta s)) 'nonincremental-repeat-search-forward)
(global-set-key (vector '(meta c)) 'center-line)
(global-set-key (vector '(meta f)) 'fill-paragraph)
(global-set-key (vector '(meta up)) 'enlarge-window)
(global-set-key (vector '(meta down)) 'shrink-window)
(global-set-key (vector '(meta right)) 'enlarge-window-horizontally)
(global-set-key (vector '(meta left)) 'shrink-window-horizontally)

;; ctl-x-map ;;
(global-set-key (vector '(control x) ?l) 'recenter)	; current line to screen center
(global-set-key (vector '(control x) '(control m) ?u) 'set-buffer-eol-conversion-unix)
(global-set-key (vector '(control x) '(control m) ?d) 'set-buffer-eol-conversion-dos)
(global-set-key (vector '(control x) '(control m) ?m) 'set-buffer-eol-conversion-mac)

;; ctl-c prefixed ;;
(global-set-key (vector '(control c) ?l) 'downcase-word)    ; should fix all the case changing stuff to ensure that we are at the beginning of a word.
(global-set-key (vector '(control c) ?u) 'upcase-word)
(global-set-key (vector '(control c) ?c) 'capitalize-word)

 ;; other stuff ;;
(global-set-key (vector 'home) 'beginning-of-buffer)
(global-set-key (vector 'end) 'end-of-buffer)
(global-set-key (vector 'f11) 'compile)
(global-set-key (vector 'f12) 'recompile)

 ;;; Custom Section ;;;

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-image-file-mode t)
 '(case-fold-search t)
 '(column-number-mode t)
 '(display-time-mode t)
 '(ediff-merge-split-window-function (quote split-window-vertically))
 '(ediff-split-window-function (quote split-window-vertically))
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-sane-defaults)))
 '(ess-ask-for-ess-directory nil)
 '(ess-bugs-batch-method (quote dos))
 '(ess-describe-at-point-method (quote tooltip))
 '(ess-developer-packages (quote ("FDBeye" "FDB1" "FDButils")))
 '(ess-eval-visibly t)
 '(ess-funcmenu-use-p t)
 '(ess-help-own-frame (quote one))
 '(ess-history-file nil)
 '(ess-keep-dump-files "always")
 '(ess-roxy-tags-param
   (quote
    ("author" "aliases" "concept" "description" "details" "examples" "format" "keywords" "method" "exportMethod" "name" "note" "param" "include" "references" "return" "seealso" "source" "docType" "title" "TODO" "usage" "import" "exportClass" "exportPattern" "S3method" "inheritParams" "importFrom" "importClassesFrom" "importMethodsFrom" "useDynLib" "rdname" "section" "slot")))
 '(ess-swv-processor (quote knitr))
 '(ess-tab-always-indent nil)
 '(ess-use-eldoc (quote script-only))
 '(ess-user-full-name "Dave Braze")
 '(explicit-shell-file-name nil)
 '(font-lock-verbose nil)
 '(inferior-ess-r-program "C:/Program Files/R/R-3.5.1/bin/x64/Rterm.exe")
 '(initial-buffer-choice t)
 '(initial-scratch-message nil)
 '(org-support-shift-select t)
 '(package-archives
   (quote
    (("melpa" . "http://melpa.milkbox.net/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("elpy" . "http://jorgenschaefer.github.io/packages/"))))
 '(package-selected-packages
   (quote
    (highlight-chars dired+ dired-quick-sort flx-ido ox-reveal ox-html5slide ox-ioslide ox-pandoc ox-tufte projectile magit lorem-ipsum helm elpy ego csv-mode)))
 '(python-shell-buffer-name "Python")
 '(python-shell-interpreter "python")
 '(recentf-auto-cleanup 300)
 '(recentf-max-menu-items 20)
 '(safe-local-variable-values
   (quote
    ((whitespace-style face tabs spaces trailing lines space-before-tab::space newline indentation::space empty space-after-tab::space space-mark tab-mark newline-mark))))
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(sql-mysql-program "C:/Program Files/MySQL/MySQL Server 5.5/bin/mysql")
 '(sql-password "")
 '(sql-product (quote mysql))
 '(sql-user "")
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(table-cell ((t (:background "SlateGray1" :foreground "black" :inverse-video nil)))))
(put 'dired-find-alternate-file 'disabled nil)
 
