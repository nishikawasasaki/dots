;;====================
;; scala-mode
;;====================
(add-to-list 'load-path "~/.emacs.d/snippets/scala-mode")
(require 'scala-mode-auto)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))
(require 'scala-mode-feature-electric)
(add-hook 'scala-mode-hook
          (lambda ()
            (scala-electric-mode)
            (define-key scala-mode-map my-shell-pop-key 'shell-pop)
            (define-key scala-mode-map [(C-tab)] 'elscreen-next) ; ブラウザみたいに
            ))

;; ensime
;; (add-to-list 'load-path "~/.emacs.d/ensime/elisp/")
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


