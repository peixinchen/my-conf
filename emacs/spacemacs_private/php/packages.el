;;; packages.el --- php Layer packages File for Spacemacs
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

(defvar php-packages
  '(
    ;; package phps go here
    php-mode
    php-eldoc
    php-auto-yasnippets
    speedbar
    etags-select
    eproject
    )
  "List of all packages to install and/or initialize. Built-in packages
which require an initialization must be listed explicitly in the list.")

(defvar php-excluded-packages '()
  "List of packages to exclude.")

;; For each package, define a function php/init-<package-php>
;;
(defun php/init-my-package ()
  (use-package php-mode
    :defer t
    :mode ("\\.php\\'" . php-mode)
  )
)
;;
;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package
