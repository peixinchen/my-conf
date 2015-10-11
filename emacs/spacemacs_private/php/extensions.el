;;; extensions.el --- php Layer extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defvar php-pre-extensions
  '(
    ;; pre extension phps go here
    )
  "List of all extensions to load before the packages.")

(defvar php-post-extensions
  '(
    ;; post extension phps go here
    )
  "List of all extensions to load after the packages.")

(defun my-setup-php ()
;  ;; enable web-mode
;
;  (make-local-variable 'web-mode-code-indent-offset)
;  (make-local-variable 'web-mode-markup-indent-offset)
;  (make-local-variable 'web-mode-css-indent-offset)
;
;  ;; set indentation
;  (setq web-mode-code-indent-offset 4)
;  (setq web-mode-css-indent-offset 2)
;  (setq web-mode-markup-indent-offset 2)
;
;  (flycheck-select-checker my-php)
;  (flycheck-mode t)
;

    ;; ctags
(require 'eproject)
(require 'etags-select)
(defun build-ctags ()
 (interactive)
  (message "building project tags")
  (let ((root (eproject-root)))
    (shell-command (concat "ctags -e -R --extra=+fq --fields=+ailKSz --languages=php --exclude=.git --exclude=.svn -f " root "TAGS " root)))
  (visit-project-tags)
  (message "tags built successfully"))

(defun visit-project-tags ()
  (interactive)
  (let ((tags-file (concat (eproject-root) "TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))

(defun my-find-tag ()
    (interactive)
      (if (file-exists-p (concat (eproject-root) "TAGS"))
              (visit-project-tags)
                  (build-ctags))
        (etags-select-find-tag-at-point))

(global-set-key (kbd "M-.") 'my-find-tag)

)
;
(add-to-list 'auto-mode-alist '("\\.php$" . my-setup-php))
;
;(flycheck-define-checker my-php
;  :command ("php" "-l"  "-d" "error_reporting=E_ALL" "-d" "display_errors=1" "-d" "log_errors=0" source)
;  :error-patters
;  ((error line-start (or "Parse" "Fatal" "syntax") " error" (any ":" ",") " "
;          (message) " in " (file-name) " on line " line line-end))
;  :modes (php-mode php+-mode web-mode))

;; For each extension, define a function php/init-<extension-php>
;;
;; (defun php/init-my-extension ()
;;   "Initialize my extension"
;;   )
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
