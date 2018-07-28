;;
;; url: http://hacks-galore.org/aleix/blog/archives/2013/01/08/install-emacs-packages-from-command-line
;; Install package from command line. Example:
;;
;;   $ emacs --batch --expr "(define pkg-to-install 'smex)" -l emacs-pkg-install.el
;;

(require 'package)
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa" .     "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(package-refresh-contents)

;; Fix HTTP1/1.1 problems
(setq url-http-attempt-keepalives nil)
;;(package-refresh-contents)
(package-install-file pkg-to-install)
