(use-package elscreen
  :ensure t
 :defer t
  :bind (("<C-tab>" . elscreen-next)
         ("<C-S-tab>" . elscreen-previous)
         ("<C-S-iso-lefttab>" . elscreen-previous)
         ("C-:" . helm-with-new-elscreen)
         ("C-x j" . dired-with-new-elscreen)
         ("C-q c" . elscreen-clone)
         ("C-q x" . elscreen-kill)
         ("C-q X" . elscreen-kill-screen-and-buffers))
  :init
  (elscreen-start)
  :config
  ;; タブコントロールを左端に表示しない
  (setq elscreen-tab-display-control nil)
  ;; タブを閉じる [X] を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; タブの幅
  (setq elscreen-display-tab 15)

  ;; タブが1つの時にタブ移動をすると自動でスクリーンを生成する
  (defmacro elscreen-create-automatically (ad-do-it)
    `(if (not (elscreen-one-screen-p))
         ,ad-do-it
       (elscreen-create)
       (elscreen-notify-screen-modification 'force-immediately)
       (elscreen-message "New screen is automatically created")))
  (defadvice elscreen-next (around elscreen-create-automatically activate)
    (elscreen-create-automatically ad-do-it))
  (defadvice elscreen-previous (around elscreen-create-automatically activate)
    (elscreen-create-automatically ad-do-it))
  (defadvice elscreen-toggle (around elscreen-create-automatically activate)
    (elscreen-create-automatically ad-do-it))

  ;; emacsclient からは別のタブで開く
  (require 'elscreen-server nil t)

  (defun helm-with-new-elscreen ()
    "新しい elscreen で helm"
    (interactive)
    (elscreen-create)
    (helm-my))

  (defun dired-with-new-elscreen ()
    "新しい elscreen で dired"
    (interactive)
    (let ((current-dir (expand-file-name ".")))
      (elscreen-create)
      (dired current-dir)))
  )

(use-package elscreen-persist
  :ensure t
  ;; :defer t ; can't revert if defer is t
  :config
  (elscreen-persist-mode 1)
  )
