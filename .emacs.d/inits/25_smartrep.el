(use-package smartrep
  :ensure t
  :defer t
  :config
  (smartrep-define-key
   global-map "C-z" '(("c" . 'elscreen-create)
                      ("n" . 'elscreen-next)
                      ("p" . 'elscreen-previous)
                      ("a" . 'elscreen-toggle)
                      ("k" . 'elscreen-kill)
                      ))
  ;; ("a" . (lambda () (beginning-of-buffer-other-window 0)))
  ;; ("e" . (lambda () (end-of-buffer-other-window 0)))))

  ;; multiple-cursors
  (global-unset-key (kbd "C-c m"))
  (smartrep-define-key global-map (kbd "C-c m")
                       '(("n"        . 'mc/mark-next-like-this)
                         ("p"        . 'mc/mark-previous-like-this)
                         ("m"        . 'mc/mark-more-like-this-extended)
                         ("u"        . 'mc/unmark-next-like-this)
                         ("U"        . 'mc/unmark-previous-like-this)
                         ("s"        . 'mc/skip-to-next-like-this)
                         ("S"        . 'mc/skip-to-previous-like-this)
                         ("*"        . 'mc/mark-all-like-this)
                         ("d"        . 'mc/mark-all-like-this-dwim)
                         ("i"        . 'mc/insert-numbers)
                         ("o"        . 'mc/sort-regions)
                         ("O"        . 'mc/reverse-regions)))


  (smartrep-define-key global-map (kbd "C-q")
                       '(("["        . 'historyf-back)
                         ("]"        . 'historyf-forward)))

  (smartrep-define-key global-map (kbd "C-q")
                       '(("l"        . 'windmove-right)
                         ("h"        . 'windmove-left)
                         ("j"        . 'windmove-down)
                         ("k"        . 'windmove-up)))
  )
