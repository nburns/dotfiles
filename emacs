(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-keyboard-coding-system nil)

(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(evil company solarized-theme))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


(require 'evil)
(evil-mode 1)
