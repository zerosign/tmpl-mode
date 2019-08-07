;;; tmpl-mode.el -- major mode for editing tmpl files

;; https://www.emacswiki.org/emacs/ModeTutorial

;; Copyright 2019, by zerosign <r1nlx0@gmail.com>

;; Author: zerosign <r1nlx0@gmail.com>
;; Version: 0.0.1
;; Created: 3 July 2019
;; Keywords: Languages

;; Derived from jinja2 mode
;; https://github.com/paradoxxxzero/jinja2-mode/blob/master/jinja2-mode.el


;;; Commentary:
;;

(require 'sgml-mode)

;;; Code:

(defvar tmpl-mode-hook nil)

(defgroup tmpl nil
  "Major mode for editing tmpl code."
  :prefix "tmpl-"
  :group 'languages)

(defcustom tmpl-user-keywords nil
  "custom keyword names"
  :type '(repeat string)
  :group 'tmpl)

(defcustom tmpl-user-functions nil
  "custom function names"
  :type '(repeat string)
  :group 'tmpl)

(defun tmpl-closing-keywords ()
  (append tmpl-user-keywords '("for" "if" "block" "func")))

(defun tmpl-identing-keywords ()
  (append (tmpl-closing-keywords) '("else" "elsif")))

(defun tmpl-builtin-keywords ()
  '("in" "true" "false" "do" "end"))

(defun tmpl-functions-keywords ()
  (append
   tmpl-user-functions
   '("rlookup" "alookup" "hlookup" "lookup"
     "encode" "encrypt" "decrypt" "decode")))

(defun tmpl-insert-comment ()
  "insert comment tag"
  (interactive)
  (insert "{# ")
  (save-excursion
    (inser " #}")
    (tmpl-ident-line)))

(defun tmpl-ident-line ()
  "indent current line as tmpl code"
  (interactive))

;;;###autoload
(define-derived-mode tmpl-mode html-mode "tmpl-mode"
  "Major mode for editing tmpl-mode files"
  :group 'tmpl
  (set (make-local-variable 'comment-start "{#")
       (make-local-variable 'comment-start-skip "{#")
       (make-local-variable 'comment-end "#}")
       (make-local-variable 'comment-end-skip "#}")
       (make-local-variable 'font-lock-defaults)
       '((tmpl-font-lock-keywords) nil t nil nil
         (font-lock-syntatic-keywords
          sgml-font-lock-syntatic-keywords))
       (make-local-variable 'ident-line-function) 'tmpl-ident-line))

(define-key tmpl-mode-map (kbd "C-c c") 'tmpl-close-tag)
(define-key tmpl-mode-map (kbd "C-c t") 'tmpl-insert-tag)
(define-key tmpl-mode-map (kbd "C-c v") 'tmpl-insert-var)
(define-key tmpl-mode-map (kbd "C-c #") 'tmpl-insert-comment)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.tmpl$" . tmpl-mode))

(provide 'tmpl-mode)
;;; tmpl-mode.el ends here
