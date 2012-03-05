(when is_emacs24

  ;;====================
  ;; el-get
  ;;====================
  (add-to-list 'load-path "~/.emacs.d/el-get/el-get")
  (unless (require 'el-get nil t)
    (url-retrieve
     "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
     (lambda (s)
       (let (el-get-master-branch)
         (end-of-buffer)
         (eval-print-last-sexp)))))
  (require 'el-get)

  (setq el-get-sources
        '(
          (:name anything
                 :after (progn
                          (setq
                           ;; ショートカットアルファベット表示
                           anything-enable-shortcuts 'alphabet
                           ;; 候補表示までの時間
                           anything-idle-delay 0.3
                           ;; 候補の多いときに体感速度を上げる
                           anything-quick-update t
                           )

                          (require 'anything-config)

                          ;; anything で欲しい物全部表示版
                          (defun my-anything-all ()
                            (interactive)
                            (anything-other-buffer
                             '(anything-c-source-buffers+
                               anything-c-source-elscreen
                               anything-c-source-recentf
                               anything-c-source-imenu
                               anything-c-source-emacs-commands
                               anything-c-source-emacs-functions
                               anything-c-source-files-in-current-dir)
                             "*my-anything-all*"))
                          (define-key global-map (kbd "C-;") 'my-anything-all)
                          ;; anything でバッファと elscreen 表示
                          (defun my-anything-buf-screens ()
                            (interactive)
                            (anything-other-buffer
                             '(
                               ;; anything-c-source-buffers+
                               anything-c-source-buffers+-howm-title
                               anything-c-source-elscreen)
                             "*my-anything-buf-screens*"))
                          (define-key global-map (kbd "C-x C-b") 'my-anything-buf-screens)

                          (defun anything-with-new-elscreen ()
                            "新しい elscreen で anything"
                            (interactive)
                            (elscreen-create)
                            (my-anything-all))
                          (define-key global-map (kbd "C-:") 'anything-with-new-elscreen)

                          ;; kill-ringもanythigで
                          (global-set-key (kbd "M-y") 'anything-show-kill-ring)
                          ))
          (:name anything-howm
                 :type git
                 :url "git://github.com/wakaran/anything-howm.git"
                 :after (progn
                          (require 'anything-howm)

                          (global-set-key (kbd "C-c C-, C-,") 'anything-howm-menu-command)

                          ;; 「最近のメモ」をいくつ表示するか
                          (setq anything-howm-recent-menu-number-limit 300)

                          ;; (global-set-key (kbd "C-2") 'anything-howm-menu-command)
                          ;; (global-set-key (kbd "C-3") 'anything-cached-howm-menu)

                          ;; howm のデータディレクトリへのパス
                          (setq anything-howm-data-directory "~/howm")

                          ))
;;          (:name yasnippet
;;       :type git
;;       :url "https://github.com/capitaomorte/yasnippet.git"
;;                 :after (lambda ()
;;                          (require 'yasnippet)
;;                          (yas/global-mode 1)
;;                          (yas/load-directory "~/.emacs.d/dict")
;;
;;                          (defun my-yas/prompt (prompt choices &optional display-fn)
;;                            (let* ((names (loop for choice in choices
;;                                                collect (or (and display-fn (funcall display-fn choice))
;;                                                            coice)))
;;                                   (selected (anything-other-buffer
;;                                              `(((name . ,(format "%s" prompt))
;;                                                 (candidates . names)
;;                                                 (action . (("Insert snippet" . (lambda (arg) arg))))))
;;                                              "*anything yas/prompt*")))
;;                              (if selected
;;                                  (let ((n (position selected names :test 'equal)))
;;                                    (nth n choices))
;;                                (signal 'quit "user quit!"))))
;;                          (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
;;                          (global-set-key (kbd "C-c y") 'yas/insert-snippet)
;;
;;                          ))
          (:name popwin
                 :after (progn
                          (require 'popwin)
                          (setq display-buffer-function 'popwin:display-buffer)
                          ;; anythingをpopwinで行うため
                          (setq anything-samewindow nil)
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
                                          ("*anything*" :height 20)
                                          ("*my-anything-all*" :height 20)
                                          ("*my-anything-buf-screens*" :height 20)
                                          ;;("*Moccur*" :height 20)
                                          ("*Directory*" :height 20)
                                          ("*undo-tree*" :height 20)
                                          ("\\*magit*" :regexp t :height 30)
                                          (dired-mode :position top :height 0.6)
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
                                          (direx:direx-mode :position left :width 25 :dedicated t)
                                          ("*auto-async-byte-compile*" :height 20)
                                          )
                                        popwin:special-display-config))

                          ;; 最後に表示したpopwinを再表示
                          (define-key global-map (kbd "C-x p") 'popwin:display-last-buffer)))
          (:name magit
                 ;; make するとエラーが出るので独自で git pull
                 :type git
                 :url "http://github.com/magit/magit.git"
                 :after (progn
                          (require 'magit)
                          (global-set-key (kbd "C-q g") 'magit-status)
                          ;; 色変更
                          (set-face-foreground 'magit-diff-add "#b9ca4a")
                          (set-face-foreground 'magit-diff-del "#d54e53")
                          (set-face-background 'magit-item-highlight "gray25")
                          ))

          (:name auto-complete
                 :url "git://github.com/m2ym/auto-complete.git"
                 :after (progn
                          (require 'auto-complete)
                          (require 'auto-complete-config)
                          (global-auto-complete-mode t)
                          (setq ac-dwim t)
                          ;; ;; 辞書ファイルの位置
                          (add-to-list 'ac-dictionary-directories "~/.emacs.d/bundle/auto-complete/dict")

                          ;; デフォルト設定有効
                          (ac-config-default)
                          ;; 補完を高度に
                          (define-key ac-mode-map (kbd "TAB") 'auto-complete)

                          ;; 自動補完
                          (setq ac-auto-start 3) ; ?文字以上で補完開始
                          ;; 手動補完するならこっち
                          ;; (setq ac-auto-start nil) ; 自動的に開始しない

                          ;; 一定時間後に保管開始
                          (setq ac-auto-show-menu 1.0)

                          ;; コンテキストに応じてTABで補完
                          (ac-set-trigger-key "TAB")
                          ;; 補完確定
                          (define-key ac-complete-mode-map "RET" 'ac-complete)

                          (setq ac-use-menu-map t)
                          ;; デフォルトで設定済み
                          ;; (define-key ac-menu-map "\C-n" 'ac-next)
                          ;; (define-key ac-menu-map "\C-p" 'ac-previous)

                          ;; tab補完で候補が選択されないようにする
                          (define-key ac-menu-map [(tab)] 'ac-next)
                          (define-key ac-menu-map [(S-tab)] 'ac-previous)


                          ;; 補完時大文字小文字の区別
                          ;; 大文字・小文字を区別しない
                          (setq ac-ignore-case t) ;区別無し

                          ;; 補完の色
                          (set-face-background 'ac-candidate-face "#b9ca4a")
                          (set-face-underline 'ac-candidate-face "#b9ca4a")
                          (set-face-background 'ac-selection-face "#d54e53")

                          ;; 候補を20行分表示
                          (setq ac-menu-height 20)


                          ;; 補完の情報源
                          (setq-default ac-sources
                                        '(ac-source-abbrev ac-source-yasnippet ac-source-filename ac-source-files-in-current-dir ac-source-words-in-same-mode-buffers ac-source-symbols))
                          ;; 補完するモードの追加
                          (setq ac-modes (append ac-modes '(text-mode sql-mode scala-mode)))
                          ))

          (:name emacs-historyf
                 :type git
                 :url "git://github.com/k1LoW/emacs-historyf.git"
                 :after (progn
                          (require 'historyf)
                          (define-key global-map (kbd "C-q l") 'historyf-forward)
                          (define-key global-map (kbd "C-q h") 'historyf-back)
                          (key-chord-define-global "bn" 'historyf-forward)
                          (key-chord-define-global "bp" 'historyf-back)
                          ))

          (:name expand-region
                 :after (progn
                          (require 'expand-region)
                          (global-set-key (kbd "C-@") 'er/expand-region)
                          (global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める
                          ))

          (:name wrap-region
                 :type git
                 :url "git://github.com/rejeep/wrap-region.git"
                 :after (progn
                               (require 'wrap-region)
                               ;; 第一引数:リージョンの先頭に挿入する文字
                               ;; 第二引数:リージョン末尾に挿入する文字
                               ;; 第三引数:トリガとなるキー
                               ;; 第四引数:有効にするモード
                               ;; (wrap-region-add-wrapper "(" ")" "(")
                               ))

          (:name jaunte.el
                 :type git
                 :url "git://github.com/kawaguchi/jaunte.el.git"
                 :after (progn
                          (require 'jaunte)
                          ;; グローバルに設定
                          (setq jaunte-global-hint-unit 'symbol)
                          (global-set-key (kbd "C-c C-j") 'jaunte)
                          (key-chord-define-global "qf" 'jaunte)
                          ))

          (:name rainbow-delimiters
                 :type git
                 :url "git://github.com/jlr/rainbow-delimiters.git"
                 :after (progn
                          (require 'rainbow-delimiters)
                          (global-rainbow-delimiters-mode)
                          ))

          (:name twittering-mode
                 :type git
                 :url "git://github.com/hayamiz/twittering-mode.git")

          (:name coffee-mode
                 :after (progn
                          (progn 
                            (require 'coffee-mode)
                            (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
                            (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode)))
                          ))

          ))
  (setq my-packages
        (append '(el-get) (mapcar 'el-get-source-name el-get-sources)))
  (el-get 'sync my-packages)

)

