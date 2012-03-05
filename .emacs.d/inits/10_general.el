;; ---------------------------------------------------------------------------------
;; General Settings
;; ---------------------------------------------------------------------------------


;; マウスの右クリックの割り当て(押しながらの操作)をはずす
(if window-system (progn
        (global-unset-key [down-mouse-3])
;; マウスの右クリックメニューを使えるようにする
(defun bingalls-edit-menu (event)  (interactive "e")
    (popup-menu menu-bar-edit-menu))
    (global-set-key [mouse-3] 'bingalls-edit-menu)))

;; C-hをヘルプから外すための設定
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat) (terminal-init-bobcat))

;; 共通ロードパスを通す OSごと設定は下の方で
(setq load-path (cons "~/.emacs.d/elisp" load-path))
;; emacs.d/elisp以下を再帰的にload-pathへ追加
(let ((default-directory (expand-file-name "~/.emacs.d/elisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; package.elでインストールしたelispをload-pathへ追加
(let ((default-directory (expand-file-name "~/.emacs.d/elpa")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))



;; language & code
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)


;; beepを消す
(setq visible-bell t)
(setq ring-bell-function 'ignore)


;; 起動時のメッセージを非表示
(setq inhibit-startup-message t)


;; ヘルプコマンドをC-^に割り当てる
(global-set-key "\C-^" 'help-command)


;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)


;; 現在位置のファイルを開く
(ffap-bindings)


;; タブは4
(setq-default tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60
                        64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
;; タブはスペースで
(setq-default tab-width 4 indent-tabs-mode nil)

;; バッファ一覧をまともに
(global-set-key "\C-x\C-b" 'bs-show)

;; 最近のファイル500個を保存する
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 30)


;; ごみ箱を有効
(setq delete-by-moving-to-trash t)

;; バックアップファイルを作らない
(setq backup-inhibited t)

;; オートセーブしない
(setq make-backup-files nil)

;; 保存時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; バックアップファイルの場所
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

;; 前回編集場所を記憶
(load "saveplace")
(setq-default save-place t)


;; 起動画面を表示しない
(setq inhibit-startup-message t)


;; Emacs serverを起動
(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))


;; ターミナルに戻る
(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key (kbd "C-x c") 'server-edit)


;; 置換(M-%)キーバインドを(C-c r)にも
(global-set-key (kbd "C-c r") 'query-replace)


;; オートコンパイル
;;(require 'auto-async-byte-compile)
;; オートコンパイル無効にする正規表現
;;(setq auto-async-byte-compile-exclude-file-regexp "/junk/")
;;(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)


;; 1画面戻る(M-v)を"Ctr-Shift-v"にも
(global-set-key (kbd "C-S-v") 'scroll-down)

;; リージョン選択した状態でisearchすると選択後を検索
(defadvice isearch-mode (around isearch-mode-default-string (forward &optional regexp op-fun recursive-edit word-p) activate)
  (if (and transient-mark-mode mark-active (not (eq (mark) (point))))
      (progn
        (isearch-update-ring (buffer-substring-no-properties (mark) (point)))
        (deactivate-mark)
        ad-do-it
        (if (not forward)
            (isearch-repeat-backward)
          (goto-char (mark))
          (isearch-repeat-forward)))
    ad-do-it))



;; ビューモード
;; (setq view-read-only t)
;; (defvar pager-keybind
;;       `( ;; vi-like
;;         ("h" . backward-word)
;;         ("l" . forward-word)
;;         ("j" . next-line)
;;         ("k" . previous-line)
;;         (";" . gene-word)
;;         ("b" . scroll-down)
;;         (" " . scroll-up)
;;         ;; w3m-like
;;         ("m" . gene-word)
;;         ("i" . win-delete-current-window-and-squeeze)
;;         ("w" . forward-word)
;;         ("e" . backward-word)
;;         ("(" . point-undo)
;;         (")" . point-redo)
;;         ("J" . ,(lambda () (interactive) (scroll-up 1)))
;;         ("K" . ,(lambda () (interactive) (scroll-down 1)))
;;         ;; bm-easy
;;         ("." . bm-toggle)
;;         ("[" . bm-previous)
;;         ("]" . bm-next)
;;         ;; langhelp-like
;;         ("c" . scroll-other-window-down)
;;         ("v" . scroll-other-window)
;;         ))

;; (defun define-many-keys (keymap key-table &optional includes)
;;   (let (key cmd)
;;     (dolist (key-cmd key-table)
;;       (setq key (car key-cmd)
;;             cmd (cdr key-cmd))
;;       (if (or (not includes) (member key includes))
;;         (define-key keymap key cmd))))
;;   keymap)


;; (defun view-mode-hook0 ()
;;   (define-many-keys view-mode-map pager-keybind)
;;   (hl-line-mode 1)
;;   (define-key view-mode-map " " 'scroll-up))
;; (add-hook 'view-mode-hook 'view-mode-hook0)


;; 書き込み不能なファイルはview-modeで開くように
;; (defadvice find-file
;;   (around find-file-switch-to-view-file (file &optional wild) activate)
;;   (if (and (not (file-writable-p file))
;;            (not (file-directory-p file)))
;;       (view-file file)
;;     ad-do-it))

;; 書き込み不能な場合はview-modeを抜けないように
;; (defvar view-mode-force-exit nil)
;; (defmacro do-not-exit-view-mode-unless-writable-advice (f)
;;   `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
;;      (if (and (buffer-file-name)
;;               (not view-mode-force-exit)
;;               (not (file-writable-p (buffer-file-name))))
;;          (message "File is unwritable, so stay in view-mode.")
;;        ad-do-it)))

;; (do-not-exit-view-mode-unless-writable-advice view-mode-exit)
;; (do-not-exit-view-mode-unless-writable-advice view-mode-disable)


;; M-Yで1行コピー
(global-set-key (kbd "M-Y") 'copy-line)


;; C-q -> pre-fix key
(define-key global-map "\C-q" (make-sparse-keymap))

;; quoted-insert -> C-q C-q
(global-set-key "\C-q\C-q" 'quoted-insert)


;; window move
(global-set-key "\C-ql" 'windmove-right)
(global-set-key "\C-qh" 'windmove-left)
(global-set-key "\C-qj" 'windmove-down)
(global-set-key "\C-qk" 'windmove-up)

;; window split
(global-set-key "\C-q1" 'delete-other-windows)
(global-set-key "\C-q2" 'split-window-vertically)
(global-set-key "\C-q3" 'split-window-horizontally)


;; 自動でchmod+x
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)


;; 折り返しあり
(setq truncate-lines nil)
;; 画面分割してもデフォルトで折り返す
(setq truncate-partial-width-windows nil)