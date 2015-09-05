(use-package elscreen
  ;; :disabled t
  :ensure t
  :defer t
  :bind (("<C-tab>" . elscreen-next)
         ("<C-S-tab>" . elscreen-previous)
         ("<C-S-iso-lefttab>" . elscreen-previous)
         ("C-:" . helm-with-new-elscreen)
         ("C-x j" . dired-with-new-elscreen)
         ("C-q c" . elscreen-create)
         ("C-q C-c" . elscreen-clone)
         ("C-q x" . elscreen-kill)
         ("C-q X" . elscreen-kill-screen-and-buffers)
         ("C-q C-x" . elscreen-kill-screen-and-buffers))
  :init
  (elscreen-start)
  :config
  (setq elscreen-prefix-key "\C-q")
  ;; タブコントロールを左端に表示しない
  (setq elscreen-tab-display-control nil)
  ;; タブを閉じる [X] を表示しない
  (setq elscreen-tab-display-kill-screen nil)
  ;; タブの幅
  (setq elscreen-display-tab 22)

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
  ;; :disabled t
  :ensure t
  ;; :defer t ; can't revert if defer is t
  :config
  (elscreen-persist-mode 1)
  )

(use-package shackle
  ;; :disabled t
  :ensure t
  :config
  (setq shackle-rules
        '(;; *compilation*は下部に2割の大きさで表示
          (compilation-mode :align below :ratio 0.2)
          ("*Help*" :align right :select t :ratio 0.4)
          ("*Backtrace*" :align right :select t :ratio 0.4)
          ("*Completions*" :align below :ratio 0.3)
          ("*Compile-Log*" :align below :ratio 0.3)
          ("\*helm" :regexp t :ratio 0.375 :align right)
          ("\*magit" :regexp t :align right :ratio 0.4)
          ("*Moccur*" :align right :ratio 0.4 :same t)
          ;; 上部に表示
          ;; ("foo" :align above)
          ;; 別フレームで表示
          ;; ("bar" :frame t)
          ;; 同じウィンドウで表示
          ;; ("baz" :same t)
          ;; ポップアップで表示
          ;; ("hoge" :popup t)
          ;; 選択する
          ;; ("abc" :select t)
          ))

  (shackle-mode 1)
  (setq shackle-lighter "")

  ;; C-zで直前のウィンドウ構成に戻す
  ;; (winner-mode 1)
  ;; (global-set-key (kbd "C-g") 'winner-undo)
  )

(use-package popwin
  :disabled t
  :ensure t
  ;; :defer t
  :config
  (setq display-buffer-function 'popwin:display-buffer)

  ;; popwinのデフォルトサイズ
  (setq popwin:popup-window-height 0.4)
  ;; popwinを使う表示を設定
  (setq popwin:special-display-config
        (append '(("*Remember*" :stick t)
                  ("*Backtrace*")
                  ("*Messages*")
                  ("*Completion*" :height 0.2)
                  ("*Compile-Log*")
                  ("*compilation*") ; for rst-compile
                  ("*sdic*" :noselect t)
                  ("*helm \\(.*\\)*" :regexp t :height 0.35 )
                  ;; ("*helm my*" :position bottom)
                  ;; ("\\(.*\\) \\[Dired\\]" :regexp t :height 0.4 :position top :stick t)
                  ;;("*Moccur*" :height 20)
                  ("*Directory*" :height 20)
                  ("*magit:\\(.*\\)*" :regexp t :height 0.65 :dedicated t)
                  ("COMMIT_EDITMSG" :dedicated t)
                  ;; slime
                  ("*slime-apropos*")
                  ("*slime-macroexpansion*")
                  ("*slime-description*")
                  ("*slime-compilation*" :noselect t)
                  ("*slime-xref*")
                  ("*slime-repl clojure*" :height 30)
                  ("*slime-repl ccl*" :height 30)
                  ("\\*sldb clojure*" :regexp t :height 30)
                  (sldb-mode :stick t)
                  (slime-repl-mode)
                  (slime-connection-list-mode)
                  (direx:direx-mode :position left :width 0.3)
                  ("*auto-async-byte-compile*" :height 20)
                  ("*Shell Command Output*" :height 25)
                  ("*svn output*" :stick t :position right)
                  ("\\*nrepl-*" :height 0.3 :regexp t)
                  )
                popwin:special-display-config))
  )


(use-package scratch-log
  :ensure t
  :config
  (setq sl-scratch-log-file "~/.emacs.d/.scratch-log")
  (setq sl-prev-scratch-string-file "~/.emacs.d/.scratch-log-prev")

  ;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
  (setq sl-restore-scratch-p t)
  ;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
  (setq sl-prohibit-kill-scratch-buffer-p t)
  )

(use-package buffer-move
  :ensure t
  :bind (("C-q L" . buf-move-right)
         ("C-q H" . buf-move-left)
         ("C-q J" . buf-move-down)
         ("C-q K" . buf-move-up)))
