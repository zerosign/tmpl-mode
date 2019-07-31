;;; tmpl-mode.el -- major mode for editing tmpl files

;; https://www.emacswiki.org/emacs/ModeTutorial

;; Copyright 2019, by zerosign <r1nlx0@gmail.com>

;; Author: zerosign <r1nlx0@gmail.com>
;; Version: 0.0.1
;; Created: 3 July 2019
;; Keywords: Languages

(require 'sgml-mode)

(defvar tmpl-mode-hook nil)

(defgroup tmpl nil
  "Major mode for editing tmpl code."
  :prefix "tmpl-"
  :group 'languages)

(defcustom tmpl-user-keywords nil
  "custom keyword names"
  :type '(repeat string)
  :group 'tmpl)

(defun tmpl-closing-keywords ()
  (append tmpl-user-keywords '("for" "do" "if" "block" "func")))

(defun tmpl-identing-keywords ()
  (append (tmpl-closing-keywords) '("else" "elsif")))



;;;###autoload
(add-to-list 'auto-mode-alist '("\\.tmpl'" . tmpl-mode))
