;;====================
;; slime
;;====================
;; Clozure CLをデフォルトのCommon Lisp処理系に設定

(when is_win
  (setq inferior-lisp-program "ccl.bat"))
(when is_mac
  (setq inferior-lisp-program "ccl"))
(when is_linux
  (setq inferior-lisp-program "ccl"))


;; ~/.emacs.d/slimeをload-pathに追加
(add-to-list 'load-path (expand-file-name "~/.emacs.d/slime"))
;; SLIMEのロード
(require 'slime)
(slime-setup '(slime-repl slime-fancy slime-banner))
;; SLIMEからの入力をUTF-8に設定
(setq slime-net-coding-system 'utf-8-unix)

;; slime キーバインドを設定
(add-hook 'slime-mode-hook
          '(lambda ()
             (define-key slime-mode-map [(tab)] 'slime-indent-and-complete-symbol)
             (define-key slime-mode-map (kbd "C-c C-d") 'slime-documentation)
             ))

;; slime-repl再起動
(add-hook 'slime-repl-mode-hook
          '(lambda ()
             (define-key slime-repl-mode-map "\C-c\M-r" 'slime-restart-inferior-lisp)))
