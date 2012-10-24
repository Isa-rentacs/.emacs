;; .emacs
(setq make-backup-files nil)
(setq auto-save-default nil)

;;php-mode
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(load-library "php-mode")
(load-library "mmm-mode")
(require 'php-mode)
(require 'mmm-mode)

;;mmm-mode
(setq mmm-global-mode 'maybe)
;; set default tab width
(setq default-tab-width 4)
(setq-default tab-width 4 indent-tabs-mode nil)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq c-basic-offset 4)

(add-hook 'php-mode-user-hook 
'(lambda () 
(setq tab-width 4) 
(setq indent-tabs-mode nil)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq c-basic-offset 4)
))

(setq mmm-global-mode 'maybe)
(mmm-add-mode-ext-class nil "\\.ctp?\\'" 'html-php)
(mmm-add-classes
 '((html-php
    :submode php-mode
    :front "<\\?\\(php\\)?"
    :back "\\?>")))
(add-to-list 'auto-mode-alist '("\\.ctp?\\'" . xml-mode))

(add-hook 'html-php-mode-hook 
'(lambda () 
(setq tab-width 4) 
(setq indent-tabs-mode nil)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq c-basic-offset 4)
))

(defun save-mmm-c-locals ()
  (with-temp-buffer
    (php-mode)
    (dolist (v (buffer-local-variables))
      (when (string-match "\\`c-" (symbol-name (car v)))
        (add-to-list 'mmm-save-local-variables `(,(car v) nil ,mmm-c-derived-modes))
        )
      )
    )
  )

(save-mmm-c-locals)

;;; uncomment this line to disable loading of "default.el" at startup
;;(setq inhibit-default-init t)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

;; set default tab width
(setq default-tab-width 4)
(setq-default tab-width 4 indent-tabs-mode nil)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                      64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

;;indent depth on c++
;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "cc-mode")))

;;C style
(add-hook 'c-mode-hook
          '(lambda()
             (c-set-style "cc-mode")))

;;configuration for YaTeX
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(setq load-path (cons (expand-file-name "~/src/emacs/yatex") load-path))
(setq make-backup-files nil)

;; do not separate on running
(setq inhibit-startup-message t)

;; flymake for C++
(require 'flymake)

(defun flymake-cc-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "g++" (list "-Wall" "-Wextra" "-fsyntax-only" local-file))))

(push '("\\.cpp$" flymake-cc-init) flymake-allowed-file-name-masks)

(add-hook 'c++-mode-hook
          '(lambda ()
             (flymake-mode t)))

;(define-key key-translation-map [(M j)] [(C b)])
;(define-key key-translation-map [(C b)] [(M j)])

;(define-key key-translation-map [(M i)] [(C p)])
;(define-key key-translation-map [(C p)] [(M i)])

;(define-key key-translation-map [(M k)] [(C n)])
;(define-key key-translation-map [(C n)] [(M k)])

;(define-key key-translation-map [(M l)] [(C f)])
;(define-key key-translation-map [(C f)] [(M l)])

(set-default-coding-systems 'utf-8)