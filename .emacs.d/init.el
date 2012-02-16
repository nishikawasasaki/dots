;; ---------------------------------------------------------------------------------
;; OS Type Defvars
;; ---------------------------------------------------------------------------------

;; 環境切り分け用の定義作成
(defvar is_emacs22 (equal emacs-major-version 22))
(defvar is_emacs23 (equal emacs-major-version 23))
(defvar is_emacs24 (equal emacs-major-version 24))
(defvar is_window-sys (not (eq (symbol-value 'window-system) nil)))
;; Mac全般のとき
(defvar is_mac (or (eq window-system 'mac) (featurep 'ns)))
;; Carbon Emacsのとき
(defvar is_carbon (and is_mac is_emacs22 is_window-sys))
;; Cocoa Emacsのとき
(defvar is_cocoa (and is_mac is_emacs23 is_window-sys))
(defvar is_inline-patch (eq (boundp 'mac-input-method-parameters) t))
(defvar is_darwin (eq system-type 'darwin))
;; cygwinのとき
(defvar is_cygwin (eq system-type 'cygwin))
;; gnu/linuxの時
(defvar is_linux (eq system-type 'gnu/linux))
;; winNTのとき
(defvar is_winnt  (eq system-type 'windows-nt))
;; Win全般のとき
(defvar is_win (or is_cygwin is_winnt))
;; Winでない場合
(defvar is_not_win (or is_mac is_linux))


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


;; 行のどこにカーソルがあっても行全体削除
(defun kill-whole-line (&optional numlines)
  (interactive "p")
  (setq pos (current-column))
  (beginning-of-line)
  (kill-line numlines)
  (move-to-column pos))
(global-set-key (kbd "M-k") 'kill-whole-line)


;; "フォーマット"
(defun format-line-indent ()
  "バッファ全体のインデントを整える"
  (interactive)
  (indent-region (point-min) (point-max)))
(global-set-key (kbd "C-S-f") 'kill-whole-line)







                                        ; ごみ箱を有効
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


;;====================
;; Dired
;;====================
;; dired-x
(require 'dired-x)
;; Cygwin 利用時
(setq dired-guess-shell-gnutar "tar")
;; 以下，各ファイル別の設定
(setq dired-guess-shell-alist-user
      '(("\\.tar\\.gz\\'"  "tar ztvf")
        ("\\.taz\\'" "tar ztvf")
        ("\\.tar\\.bz2\\'" "tar Itvf")
        ("\\.zip\\'" "unzip -l")
        ("\\.\\(g\\|\\) z\\'" "zcat")
        ("\\.\\(jpg\\|JPG\\|gif\\|GIF\\)\\'"
         (if (eq system-type 'windows-nt)
             "fiber" "xv"))
        ("\\.ps\\'"
         (if (eq system-type 'windows-nt)
             "fiber" "ghostview"))
        ))

;; wdired
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 並び替えのキー
(defvar dired-various-sort-type
  '(("S" . "size")
    ("X" . "extension")
    ("v" . "version")
    ("t" . "date")
    (""  . "name")))

;; dired
(defun dired-various-sort-change (sort-type-alist &optional prior-pair)
  (when (eq major-mode 'dired-mode)
    (let* (case-fold-search
           get-next
           (options
            (mapconcat 'car sort-type-alist ""))
           (opt-desc-pair
            (or prior-pair
                (catch 'found
                  (dolist (pair sort-type-alist)
                    (when get-next
                      (throw 'found pair))
                    (setq get-next (string-match (car pair) dired-actual-switches)))
                  (car sort-type-alist)))))
      (setq dired-actual-switches
            (concat "-l" (dired-replace-in-string (concat "[l" options "-]")
                                                  ""
                                                  dired-actual-switches)
                    (car opt-desc-pair)))
      (setq mode-name
            (concat "Dired by " (cdr opt-desc-pair)))
      (force-mode-line-update)
      (revert-buffer))))

(defun dired-various-sort-change-or-edit (&optional arg)
  "Hehe"
  (interactive "P")
  (when dired-sort-inhibit
    (error "Cannot sort this dired buffer"))
  (if arg
      (dired-sort-other
       (read-string "ls switches (must contain -l): " dired-actual-switches))
    (dired-various-sort-change dired-various-sort-type)))

(defvar anything-c-source-dired-various-sort
  '((name . "Dired various sort type")
    (candidates . (lambda ()
                    (mapcar (lambda (x)
                              (cons (concat (cdr x) " (" (car x) ")") x))
                            dired-various-sort-type)))
    (action . (("Set sort type" . (lambda (candidate)
                                    (dired-various-sort-change dired-various-sort-type candidate)))))
    ))


(add-hook 'dired-mode-hook
          '(lambda ()
             (define-key dired-mode-map "s" 'dired-various-sort-change-or-edit)
             (define-key dired-mode-map "c"
               '(lambda ()
                  (interactive)
                  (anything '(anything-c-source-dired-various-sort))))
             ))


;; diredでマークをつけたファイルをfind/view
(eval-after-load "dired"
  '(progn
     (define-key dired-mode-map "F" 'my-dired-find-file)
     (defun my-dired-find-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'find-file fn-list)))
     (define-key dired-mode-map "V" 'my-dired-view-file)
     (defun my-dired-view-file (&optional arg)
       "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
       (interactive "P")
       (let* ((fn-list (dired-get-marked-files nil arg)))
         (mapc 'view-file fn-list)))))


;; diredでのファイルコピーを便利に
(setq dired-dwim-target t)


;;; フォルダを開く時, 新しいバッファを作成しない
;; バッファを作成したい時にはoやC-u ^を利用する
(defvar my-dired-before-buffer nil)
(defadvice dired-advertised-find-file
  (before kill-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))
(defadvice dired-advertised-find-file
  (after kill-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))
(defadvice dired-up-directory
  (before kill-up-dired-buffer activate)
  (setq my-dired-before-buffer (current-buffer)))
(defadvice dired-up-directory
  (after kill-up-dired-buffer-after activate)
  (if (eq major-mode 'dired-mode)
      (kill-buffer my-dired-before-buffer)))

;; Quick Look
(setq dired-load-hook '(lambda () (load "dired-x"))) 
(setq dired-guess-shell-alist-user
      '(("\\.png" "qlmanage -p")
        ("\\.jpg" "qlmanage -p")
        ("\\.pdf" "qlmanage -p")))

;; popwinでdiredを開くときのキー
(global-set-key (kbd "C-x j") 'dired-jump-other-window)

;; ----dired end ----------------------------------------------------------------



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


;; M-↑などで今の行をコピー
(defun duplicate-line-backward ()
  "Duplicate the current line backward."
  (interactive "*")
  (save-excursion
    (let ((contents
           (buffer-substring
            (line-beginning-position)
            (line-end-position))))
      (beginning-of-line)
      (insert contents ?\n)))
  (previous-line 1))

(defun duplicate-region-backward ()
  "If mark is active duplicates the region backward."
  (interactive "*")
  (if mark-active
      (let* (
             (deactivate-mark nil)
             (start (region-beginning))
             (end (region-end))
             (contents (buffer-substring
                        start
                        end)))
        (save-excursion
          (goto-char start)
          (insert contents))
        (goto-char end)
        (push-mark (+ end (- end start))))
    (error
     "Mark is not active. Region not duplicated.")))

(defun duplicate-line-forward ()
  "Duplicate the current line forward."
  (interactive "*")
  (save-excursion
    (let ((contents (buffer-substring
                     (line-beginning-position)
                     (line-end-position))))
      (end-of-line)
      (insert ?\n contents)))
  (next-line 1))

(defun duplicate-region-forward ()
  "If mark is active duplicates the region forward."
  (interactive "*")
  (if mark-active
      (let* (
             (deactivate-mark nil)
             (start (region-beginning))
             (end (region-end))
             (contents (buffer-substring
                        start
                        end)))
        (save-excursion
          (goto-char end)
          (insert contents))
        (goto-char start)
        (push-mark end)
        (exchange-point-and-mark))
    (error "Mark is not active. Region not duplicated.")))

(global-set-key [M-up]    'duplicate-line-backward)
(global-set-key [M-down]  'duplicate-line-forward)
(global-set-key [M-right] 'duplicate-region-forward)
(global-set-key [M-left]  'duplicate-region-backward)


;; 折り返し表示をトグル
(defun toggle-truncate-lines ()
  "折り返し表示をトグル動作します."
  (interactive)
  (if truncate-lines
      (setq truncate-lines nil)
    (setq truncate-lines t))
  (recenter))
(global-set-key (kbd "C-c C-l") 'toggle-truncate-lines) ; 折り返し表示ON/OFF


;; my window resize
(defun my-window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        action c)
    (catch 'end-flag
      (while t
        (setq action
              (read-key-sequence-vector (format "size[%dx%d]"
                                                (window-width)
                                                (window-height))))
        (setq c (aref action 0))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               ;;               (let ((last-command-char (aref action 0))
               (let ((last-command-event (aref action 0))
                     (command (key-binding action)))
                 (when command
                   (call-interactively command)))
               (message "Quit")
               (throw 'end-flag t)))))))


;; C-q -> pre-fix key
(define-key global-map "\C-q" (make-sparse-keymap))

;; quoted-insert -> C-q C-q
(global-set-key "\C-q\C-q" 'quoted-insert)

;; window-resizer C-q C-r (resize)
(global-set-key "\C-q\C-r" 'my-window-resizer)

;; window move
(global-set-key "\C-ql" 'windmove-right)
(global-set-key "\C-qh" 'windmove-left)
(global-set-key "\C-qj" 'windmove-down)
(global-set-key "\C-qk" 'windmove-up)

;; window split
(global-set-key "\C-q1" 'delete-other-windows)
(global-set-key "\C-q2" 'split-window-vertically)
(global-set-key "\C-q3" 'split-window-horizontally)
(defun split-for-twmode ()

  "現在のウィンドウを3等分する関数"
  (interactive)
  (progn
    (split-window-horizontally)
    (other-window 1)
    (split-window-vertically)
    (enlarge-window 7)
    (windmove-left)
    (twit)
    (windmove-right)
    (twit)
    (windmove-down)
    (twittering-replies-timeline)
    (windmove-up)
))
(global-set-key "\C-q4" 'split-for-twmode)

(global-set-key "\C-qt" 'twit)



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





;----------------------------------
;; etags の追加関数(タグファイルの作成)
;----------------------------------
;; (defadvice find-tag (before c-tag-file activate)
;;   "Automatically create tags file."
;;   (let ((tag-file (concat default-directory "TAGS")))
;;     (unless (file-exists-p tag-file)
;;       (shell-command "etags *.[ch] *.el .*.el -o TAGS 2>/dev/null"))
;;     (visit-tags-table tag-file)))
;; find . -name "*.java" -print | /cygdrive/c/my/programs/emacs/emacs-23.3/bin/etags -


;; ---------------------------------------------------------------------------------
;; OS Settings
;; ---------------------------------------------------------------------------------

;;====================
;; For Mac
;;====================

(when is_mac



  ;; ウィンドウサイズ設定
  (setq initial-frame-alist
        (append (list
                 '(width . 160) ;; ウィンドウ幅
                 '(height . 60) ;; ウィンドウ高さ
                 '(top . 300) ;; 表示位置
                 '(left . 340) ;; 表示位置
                 )
                initial-frame-alist))
  (setq default-frame-alist initial-frame-alist)
  
  
  ;; exec-pathとPATHに設定したいパスのリストを設定
  (dolist (dir (list
                "/usr/local/bin"
                "/usr/local/scala/bin"
                "~/bin"
                "/sbin"
                "/usr/sbin"
                "/bin"
                "/usr/bin"
                "/usr/local/ccl"
                (expand-file-name "~/bin")
                (expand-file-name "~/.emacs.d/bin")
                ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))
  
  
  
  
  ;; Command-Key and Option-Key
  ;; コマンドキーをMetaに、Optionキーをsuperに
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))
  
  
  ;; CmdキーをSuperに、OptionキーをMetaに
  ;; (setq mac-option-modifier 'meta)
  ;; (setq mac-command-modifier 'super)
  

  ;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
  ;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


  ;; (define-key global-map [?\] [?\\])  ;; \の代わりにバックスラッシュを入力する




  

  )


;;====================
;; For Win
;;====================

(when is_win

  ;; exec-pathとPATHに設定したいパスのリストを設定
  (dolist (dir (list
                "C:/scala/scala/bin"
                "C:/Python27"
                "C:/java/jdk1.7.0/bin"
                "C:/Program Files (x86)/Git/bin"
                (expand-file-name "~/bin")
                (expand-file-name "~/.emacs.d/bin")
                ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))

    ;; ファイル名の文字コード指定
    (setq file-name-coding-system 'shift_jis)

  ;; ウィンドウサイズ設定
  (setq initial-frame-alist
        (append (list
                 '(width . 80) ;; ウィンドウ幅
                 '(height . 40) ;; ウィンドウ高さ
                 '(top . 50) ;; 表示位置
                 '(left . 50) ;; 表示位置
                 )
                initial-frame-alist))
  (setq default-frame-alist initial-frame-alist)

  ;; プロクシの設定
  ;; (setq url-proxy-services '(("http" . "192.168.1.8:8080"))) 

  ;; Twittering-modeのプロクシ
  ;; (setq twittering-proxy-use t)
  ;; (setq twittering-proxy-server "192.168.1.8")
  ;; (setq twittering-proxy-port 8080)

  )



;;====================
;; For Linux
;;====================

(when is_linux

  ;; exec-pathとPATHに設定したいパスのリストを設定
  (dolist (dir (list
                "/usr/local/bin"
                "/usr/local/scala/bin"
                "~/bin"
                "/sbin"
                "/usr/sbin"
                "/bin"
                "/usr/bin"
                (expand-file-name "~/bin")
                (expand-file-name "~/.emacs.d/bin")
                ))
    ;; PATH と exec-path に同じ物を追加
    (when (and (file-exists-p dir) (not (member dir exec-path)))
      (setenv "PATH" (concat dir ":" (getenv "PATH")))
      (setq exec-path (append (list dir) exec-path))))
)




;; ---------------------------------------------------------------------------------
;; Mode Settings 
;; ---------------------------------------------------------------------------------


;;====================
;; text-mode
;;====================
(setq text-mode-hook 'turn-off-auto-fill)


;;====================
;; c-mode(c++)
;;====================

(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; センテンスの終了である ';' を入力したら、自動改行+インデント
             (c-toggle-auto-hungry-state 1)
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)
             ))


;; C-c c で compile コマンドを呼び出す
(define-key mode-specific-map "c" 'compile)



;;====================
;; Scheme
;;====================

(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)


(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

;; goshインタプリタのパスに合わせます。-iは対話モードを意味します。
(setq gosh-program-name "/usr/local/bin/gosh -i")

;; schemeモードとrun-schemeモードにcmuscheme.elを使用します。
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

;; ウィンドウを2つに分け、一方でgoshインタプリタを実行するコマンドを定義します。
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme gosh-program-name))

;; そのコマンドをCtrl-cSで呼び出します。
(define-key global-map
  "\C-cS" 'scheme-other-window)


;; 直前/直後の括弧に対応する括弧を光らせます。
(show-paren-mode t)



;;====================
;; Python
;;====================

;; Python-mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("Python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)


;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(eval-after-load "pymacs"
  '(add-to-list 'pymacs-load-path "~/app/emacs/elisp"))


;; 補完
;; (require 'pysmell)
;; (add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))



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


;;====================
;; clojure-mode
;;====================
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)





;;====================
;; bat-mode
;;====================
(setq auto-mode-alist 
       (append 
        (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
        ;; For DOS init files
        (list (cons "CONFIG\\."   'bat-mode))
        (list (cons "AUTOEXEC\\." 'bat-mode))
        auto-mode-alist))

(autoload 'bat-mode "bat-mode"
      "DOS and Windows BAT files" t)

;;====================
;; js2-mode
;;====================
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; (autoload 'js-mode "js")
;; (defun my-js2-indent-function ()
;;   (interactive)
;;   (save-restriction
;;     (widen)
;;     (let* ((inhibit-point-motion-hooks t)
;;            (parse-status (save-excursion (syntax-ppss (point-at-bol))))
;;            (offset (- (current-column) (current-indentation)))
;;            (indentation (js--proper-indentation parse-status))
;;            node)
;;       (save-excursion
;;         ;; I like to indent case and labels to half of the tab width
;;         (back-to-indentation)
;;         (if (looking-at "case\\s-")
;;             (setq indentation (+ indentation (/ js-indent-level 2))))
;;         ;; consecutive declarations in a var statement are nice if
;;         ;; properly aligned, i.e:
;;         ;; var foo = "bar",
;;         ;;     bar = "foo";
;;         (setq node (js2-node-at-point))
;;         (when (and node
;;                    (= js2-NAME (js2-node-type node))
;;                    (= js2-VAR (js2-node-type (js2-node-parent node))))
;;           (setq indentation (+ 4 indentation))))
;;       (indent-line-to indentation)
;;       (when (> offset 0) (forward-char offset)))))

;; (defun my-indent-sexp ()
;;   (interactive)
;;   (save-restriction
;;     (save-excursion
;;       (widen)
;;       (let* ((inhibit-point-motion-hooks t)
;;              (parse-status (syntax-ppss (point)))
;;              (beg (nth 1 parse-status))
;;              (end-marker (make-marker))
;;              (end (progn (goto-char beg) (forward-list) (point)))
;;              (ovl (make-overlay beg end)))
;;         (set-marker end-marker end)
;;         (overlay-put ovl 'face 'highlight)
;;         (goto-char beg)
;;         (while (< (point) (marker-position end-marker))
;;           ;; don't reindent blank lines so we don't set the "buffer
;;           ;; modified" property for nothing
;;           (beginning-of-line)
;;           (unless (looking-at "\\s-*$")
;;             (indent-according-to-mode))
;;           (forward-line))
;;         (run-with-timer 0.5 nil '(lambda(ovl)
;;                                    (delete-overlay ovl)) ovl)))))
;; (defun my-js2-mode-hook ()
;;   (require 'js)
;;   (setq js-indent-level 2
;;         indent-tabs-mode nil
;;         c-basic-offset 2)
;;   (c-toggle-auto-state 0)
;;   (c-toggle-hungry-state 1)
;;   (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
;; ;  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
;;   (define-key js2-mode-map [(meta control \;)]
;;     '(lambda()
;;        (interactive)
;;        (insert "/* -----[ ")
;;        (save-excursion
;;          (insert " ]----- */"))
;;        ))
;;   (define-key js2-mode-map [(return)] 'newline-and-indent)
;;   (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
;;   (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
;;   (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
;;   (if (featurep 'js2-highlight-vars)
;;     (js2-highlight-vars-mode))
;;   (message "My JS2 hook"))

;; (add-hook 'js2-mode-hook 'my-js2-mode-hook)


;;====================
;; nxhtml
;;====================
;; 重いので普段は使わない -> html-modeで十分
;;(load "~/.emacs.d/elisp/nxhtml/autostart.el")
;;(add-hook 'nxml-mode-hook
;;          '(lambda ()
;;             (local-set-key (kbd "C-c C-c") 'nxml-complete)))
(add-hook 'nxml-mode-hook
          (lambda ()
            (setq auto-fill-mode -1)
            ;; スラッシュの入力で終了タグを自動補完
            (setq nxml-slash-auto-complete-flag t)
            ;; タグのインデントをしない
            ;; (setq nxml-child-indent 0)
            ;; (setq indent-tabs-mode t)
            (setq tab-width 4)))


;; ---------------------------------------------------------------------------------
;; elisp Settings
;; ---------------------------------------------------------------------------------

;;====================
;; install-lisp
;;====================
(require 'install-elisp)
;; インストール場所
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")


;;====================
;; auto-install
;;====================
;; (require 'auto-install)
;; (setq auto-install-directory "~/.emacs.d/elisp/")
;; (auto-install-update-emacswiki-package-name t)
;; (auto-install-compatibility-setup)


(when is_emacs24

  ;;====================
  ;; package.el
  ;;====================
  (require 'package)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))

  ;; インストールする場所
  (setq package-user-dir (concat user-emacs-directory "elpa"))

  ;;インストールしたパッケージにロードパスを通してロードする
  (package-initialize)



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
                 :after (lambda ()
                          (define-key global-map (kbd "C-;") 'anything)
                          (setq
                           ;; ショートカットアルファベット表示
                           anything-enable-shortcuts 'alphabet
                           ;; 候補表示までの時間
                           anything-idle-delay 0.3
                           ;; 候補の多いときに体感速度を上げる
                           anything-quick-update t
                           )
                          (require 'anything-config)
                          (setq anything-sources
                                '(anything-c-source-buffers+
                                  anything-c-source-recentf
                                  anything-c-source-emacs-commands
                                  anything-c-source-emacs-functions
                                  anything-c-source-files-in-current-dir
                                  ))
                          ;; kill-ringもanythigで
                          (global-set-key (kbd "M-y") 'anything-show-kill-ring)
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
                 :after (lambda ()
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
                                          ("*sdic*" :noselect t)
                                          ("*anything*" :height 20)
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
                                          )
                                        popwin:special-display-config))

                          ;; 最後に表示したpopwinを再表示
                          (define-key global-map (kbd "C-x p") 'popwin:display-last-buffer)))
          (:name magit
                 ;; make するとエラーが出るので独自で git pull
                 :type git
                 :url "http://github.com/magit/magit.git"
                 :after (lambda ()
                          (require 'magit)
                          (global-set-key (kbd "C-q g") 'magit-status)
                          ;; 色変更
                          (set-face-foreground 'magit-diff-add "#b9ca4a")
                          (set-face-foreground 'magit-diff-del "#d54e53")
                          (set-face-background 'magit-item-highlight "gray25")
                          ))

          (:name auto-complete
                 :url "http://cx4a.org/repo/auto-complete.git"
                 :after (lambda ()
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
                 :after (lamda ()
                               (require 'historyf)
                               (define-key global-map (kbd "C-q l") 'historyf-forward)
                               (define-key global-map (kbd "C-q h") 'historyf-back)
                               ))
          (:name expand-region
                 :after (lambda ()
                          (require 'expand-region)
                          (global-set-key (kbd "C-@") 'er/expand-region)
                          (global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める
                          ))
          (:name wrap-region
                 :after (lamda ()
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
                 :after (lamda ()
                               (require 'jaunte)
                               ;; グローバルに設定
                               (setq jaunte-global-hint-unit 'symbol)
                               (global-set-key (kbd "C-c C-j") 'jaunte)
                               (key-chord-define-global "qf" 'jaunte)
                               ))
          (:name rainbow-delimiters
                 :type git
                 :url "git://github.com/jlr/rainbow-delimiters.git"
                 :after (lamda ()
                               (require 'rainbow-delimiters)
                               (global-rainbow-delimiters-mode)
                               ))
          (:name twittering-mode
                 :after (lamda ()
                               (require 'twittering-mode)
                               ;; (autoload 'twittering-numbering "twittering-numbering" t)
                               ;; (add-hook 'twittering-mode-hook 'twittering-numbering)
                               (setq twittering-use-master-password t)
                               (setq twittering-status-format "%i%S(%s) %p %R \n%C{%m/%d %H:%M:%S}(%@)  \n\n  %t \n\nfrom %f%L\n\n")

                               (setq twittering-retweet-format " RT @%s: %t")

                               (add-hook 'twittering-mode-hook
                                         '(lambda ()
                                            ;; TwitterのWebっぽく
                                            (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
                                            (define-key twittering-mode-map (kbd "R") 'twittering-reply-to-user)
                                            (define-key twittering-mode-map (kbd "Q") 'twittering-organic-retweet)
                                            (define-key twittering-mode-map (kbd "T") 'twittering-native-retweet)
                                            (define-key twittering-mode-map (kbd "M") 'twittering-direct-message)
                                            (define-key twittering-mode-map (kbd "N") 'twittering-update-status-interactive)
                                            (define-key twittering-mode-map (kbd "C-c C-f") 'twittering-home-timeline)
                                            (define-key twittering-mode-map (kbd "C-c C-r") 'twittering-replies-timeline)
                                            (define-key twittering-mode-map (kbd "C-c C-m") 'twittering-direct-messages-timeline)
                                            ;; "<"">"で先頭、最後尾へ移動
                                            (define-key twittering-mode-map (kbd "<") (lambda () (interactive) (goto-char (point-min))))
                                            (define-key twittering-mode-map (kbd ">") (lambda () (interactive) (goto-char (point-max))))))

                               ;; 起動時に読み込むタイムライン
                               (setq twittering-initial-timeline-spec-string
                                     '(":replies"
                                       ":home"))
                               ))


          ;; (:name asciidoc
          ;;        :type elpa
          ;;        :after (lambda ()
          ;;                 (autoload 'doc-mode "doc-mode" nil t)
          ;;                 (add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
          ;;                 (add-hook 'doc-mode-hook '(lambda () (turn-on-auto-fill) (require 'asciidoc)))))
          ))
  (setq my-packages
        (append '(el-get) (mapcar 'el-get-source-name el-get-sources)))
  (el-get 'sync my-packages)

)



;; auto-insert
;; ファイル形式に応じて自動でテンプレート挿入
;; (add-hook 'find-file-hooks 'auto-insert)
;; (setq auto-insert-directory "~/.emacs.d/templates")
;; (setq auto-insert-alist
;;       '((perl-mode . "perl-template.pl")
;;         (html-mode . "html-template.html")
;;         ("base.css" . "base.css")
;;         (css-mode . "css-template.css")))


;;====================
;; anything
;;====================
;; anything-kyr
(require 'anything-kyr-config)
;; anything-complete.el があれば読み込む
(when (require 'anything-complete nil t)
  ;; 補完を anything でやりたいならば
  (anything-read-string-mode 1))

;;; anything-c-moccurの設定
(require 'anything-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.2 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
                                        ;      anything-c-moccur-use-moccur-anything-map-flag nil ; non-nilならanything-c-moccurのデフォルトのキーバインドを使用する
      )

;;; キーバインドの割当(好みに合わせて設定してください)
;; (global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
;; (global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
;; (add-hook 'dired-mode-hook ;dired
;;           '(lambda ()
;;              (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))



;;====================
;; yasnippet
;;====================
;; (add-to-list 'load-path "~/.emacs.d/bundle/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)
(yas/load-directory "~/.emacs.d/snippets")

(defun my-yas/prompt (prompt choices &optional display-fn)
  (let* ((names (loop for choice in choices
                      collect (or (and display-fn (funcall display-fn choice))
                                  coice)))
         (selected (anything-other-buffer
                    `(((name . ,(format "%s" prompt))
                       (candidates . names)
                       (action . (("Insert snippet" . (lambda (arg) arg))))))
                    "*anything yas/prompt*")))
    (if selected
        (let ((n (position selected names :test 'equal)))
          (nth n choices))
      (signal 'quit "user quit!"))))
(custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))
(global-set-key (kbd "C-c y") 'yas/insert-snippet)




;; 最近使ったファイルに加えないファイルを正規表現で指定する
(setq recentf-exclude '("/TAGS$" "/var/tmp/"))
(require 'recentf-ext)


;; point-undo 
(require 'point-undo)
(define-key global-map (kbd "<f7>") 'point-undo)
(define-key global-map (kbd "C-q b") 'point-undo)
(define-key global-map (kbd "S-<f7>") 'point-redo)
(define-key global-map (kbd "C-q f") 'point-redo)


;; 最後の変更箇所にジャンプ
(require 'goto-chg)
(define-key global-map (kbd "<f8>") 'goto-last-change)
(define-key global-map (kbd "S-<f8>") 'goto-last-change-reverse)


;;====================
;; ElScreen
;;====================
;; EmacsでGNU screen風のインターフェイスを使う
(setq elscreen-prefix-key "\C-z")
(require 'elscreen)
(if window-system
    (define-key elscreen-map "\C-z" 'iconify-or-deiconify-frame)
  (define-key elscreen-map "\C-z" 'suspend-emacs))

;; 以下は自動でスクリーンを生成する場合の設定
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

(setq elscreen-display-tab 10) ; タブの幅（６以上じゃないとダメ）
(setq elscreen-tab-display-kill-screen nil) ; タブの左端の×を非表示

(global-set-key (kbd "C-z C-c") 'elscreen-clone) ; 今のウインドウを基に作成
(global-set-key (kbd "C-z C-k") 'elscreen-kill-screen-and-buffers) ; スクリーンとバッファをkill
(global-set-key [(C-tab)] 'elscreen-next) ; ブラウザみたいに
(global-set-key [(C-S-tab)] 'elscreen-previous) ; ブラウザみたいに　その2
(global-set-key [(C-S-iso-lefttab)] 'elscreen-previous) ; ブラウザみたいに　その2 (for linux)

;; elscreen-server
(require 'elscreen-server)

;; elscreen-dired
(require 'elscreen-dired)

;; elscreen-color-theme
(require 'elscreen-color-theme)



;;====================
;; color-moccur
;;====================
(require 'color-moccur)
(setq moccur-split-word t)

;; migemoがrequireできる環境ならmigemoを使う
;; (when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
;; (setq moccur-use-migemo t))

(global-set-key (kbd "M-o") 'occur-by-moccur)
(global-set-key (kbd "C-M-o") 'moccur-grep-find)
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'dired-do-moccur)))


;;====================
;; moccur-edit
;;====================
(require 'moccur-edit)
(setq moccur-split-word t)


;;====================
;; smooth-scroll
;;====================
(require 'smooth-scroll)
(smooth-scroll-mode t)

;; smooth scroll of the buffer
(set-variable 'smooth-scroll/vscroll-step-size 8)
(set-variable 'smooth-scroll/hscroll-step-size 8)
;; (setq scroll-step 1
;; scroll-conservatively 10000)


;;====================
;; cua
;;====================
;; 矩形処理にcuaを利用
(cua-mode t)
;; 矩形以外のcuaの機能をオフ
(setq cua-enable-cua-keys nil) 


;;====================
;; undo-tree
;;====================
;; undo redoを木構造で保存
(require 'undo-tree)
(global-undo-tree-mode)
(global-set-key (kbd "M-/") 'undo-tree-redo)


;;====================
;; thing-opt
;;====================
;; テキストオブジェクト(thing)選択
(require 'thing-opt)
(define-thing-commands)
(global-set-key (kbd "C-$") 'mark-word*) ; 単語を選択
(global-set-key (kbd "C-\"") 'mark-string) ; 文字列(""含む)を選択
(global-set-key (kbd "C-(") 'mark-up-list) ; リスト表記()を選択


;;====================
;; Keycord
;;====================
;; Keycordの設定
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-one-keys-delay 0.04)

;; don't hijack input method!
(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))
(key-chord-define-global "YY" 'copy-line)
(key-chord-define-global "VV" 'mark-line)
(key-chord-define-global "DD" 'kill-whole-line)
(key-chord-define-global "mk" 'kill-buffer)
(key-chord-define-global "cv" 'scroll-up)
(key-chord-define-global "vb" 'scroll-down)
(key-chord-define-global "MM" 'occur-by-moccur)

(key-chord-define-global "ql" 'windmove-right)
(key-chord-define-global "qh" 'windmove-left)
(key-chord-define-global "qj" 'windmove-down)
(key-chord-define-global "qk" 'windmove-up)


;;====================
;; uniquify
;;====================
;; 同一名の buffer があったとき、開いているファイルのパスの一部を表示して区別する
(when (locate-library "uniquify")
  (require 'uniquify)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))


;;====================
;; savekill
;;====================
;; kill ringの中身をファイル保存
(require 'savekill)


;;====================
;; howm
;;====================
;; メモを取ろう！！
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))

;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)

;; howm の時は auto-fill で
(add-hook 'howm-mode-on-hook 'auto-fill-mode)

;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)

;; メニューの予定表の表示範囲
;; ? 日前から
(setq howm-menu-schedule-days-before 10)
;; ? 日後まで
(setq howm-menu-schedule-days 10)

;; howm のファイル名
;; 以下のスタイルのうちどれかを選んでください
;; で，不要な行は削除してください
;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 日 1 ファイルであれば
;; (setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")

(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))


;;====================
;; keisen-mule
;;====================
;; 罫線を簡単に引くモード
;; srefをarefに置き換えて動かすための設定(ソースを修正したためコメントアウト)
;; (unless (fboundp 'sref) (defalias 'sref 'aref))
(if window-system
    (autoload 'keisen-mode "keisen-mouse" "MULE 版罫線モード + マウス" t)
  (autoload 'keisen-mode "keisen-mule" "MULE 版罫線モード" t))


;;====================
;; Eshell
;;====================
;; @see launch setting

;; 補完時に大文字小文字を区別しない
(setq eshell-cmpl-ignore-case t)
;; 確認なしでヒストリ保存
(setq eshell-ask-to-save-history (quote always))
;; 補完時にサイクルする
;;(setq eshell-cmpl-cycle-completions t)
(setq eshell-cmpl-cycle-completions nil)
;;補完候補がこの数値以下だとサイクルせずに候補表示
(setq eshell-cmpl-cycle-cutoff-length 5)
;; 履歴で重複を無視する
(setq eshell-hist-ignoredups t)
;; prompt 文字列の変更
(defun my-eshell-prompt ()
  (concat (eshell/pwd) "\n♪ " ))
(setq eshell-prompt-function 'my-eshell-prompt)
(setq eshell-prompt-regexp "^[^#$\n]*[#♪] ")


;; sudoのあとも補完可能に
(defun pcomplete/sudo ()
  "Completion rules for the `sudo' command."
  (let ((pcomplete-help "complete after sudo"))
    (pcomplete-here (pcomplete-here (eshell-complete-commands-list)))))

;; トグルする設定
(defun my-toggle-term ()
  "eshell と直前のバッファを行き来する。C-u 付きで呼ぶと 今いるバッファと同じディレクトリに cd して開く"
  (interactive)
  (let ((ignore-list '("*Help*" "*Minibuf-1*" "*Messages*" "*Completions*"
                       "*terminal<1>*" "*terminal<2>*" "*terminal<3>*"))
        (dir default-directory))
    (labels
        ((_my-toggle-term (target)
                          (if (null (member (buffer-name (second target)) ignore-list))
                              (if (equal "*eshell*" (buffer-name (window-buffer)))
                                  (switch-to-buffer (second target))
                                (switch-to-buffer "*eshell*")
                                (when current-prefix-arg
                                  (cd dir)
                                  (eshell-interactive-print (concat "cd " dir "\n"))
                                  (eshell-emit-prompt)))
                            (_my-toggle-term (cdr target)))))
      (_my-toggle-term (buffer-list)))))
(global-set-key (kbd "C-t") 'my-toggle-term)

;; eshell での補完に auto-complete.el を使う
;; (ac-define-source pcomplete
;;   '((candidates . pcomplete-completions)))
;; (defun nm-eshell-pcomplete ()
;;   (interactive)
;;   (let ((ac-sources '(ac-source-pcomplete
;;                       ac-source-filename)))
;;     (auto-complete)))
;; (defun nm-eshell-auto-complete ()
;;   (interactive)
;;   (let ((ac-sources '(ac-source-functions
;;                       ac-source-variables
;;                       ac-source-features
;;                       ac-source-symbols
;;                       ac-source-words-in-same-mode-buffers)))
;;     (auto-complete)))
;; (defun nm-eshell-mode-hook ()
;;   (local-unset-key (kbd "M-?"))
;;   (local-set-key (kbd "TAB") 'nm-eshell-pcomplete)
;;   (local-set-key [tab] 'nm-eshell-pcomplete)
;;   (local-set-key (kbd "M-TAB") 'nm-eshell-auto-complete)
;;   (local-set-key [M-tab] 'nm-eshell-auto-complete))
;; (add-hook 'eshell-mode-hook 'nm-eshell-mode-hook)


;; キーバインドの変更
(add-hook 'eshell-mode-hook
          '(lambda ()
             (progn
               (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
               (define-key eshell-mode-map [up] 'eshell-previous-matching-input-from-input)
               (define-key eshell-mode-map [down] 'eshell-next-matching-input-from-input)
               (define-key eshell-mode-map (kbd "C-p") 'previous-line)
               (define-key eshell-mode-map (kbd "C-n") 'next-line)
               )
             ))

;; aliasの設定
(eval-after-load "em-alias"
  '(progn (eshell/alias "ll" "ls -alh")
          (eshell/alias "ec" "emacsclient -n")))


;; lsのリストからディレクトリを開く
;;; From: http://www.emacswiki.org/cgi-bin/wiki.pl/EshellEnhancedLS
(eval-after-load "em-ls"
  '(progn
     ;; (defun ted-eshell-ls-find-file-at-point (point)
     ;;          "RET on Eshell's `ls' output to open files."
     ;;          (interactive "d")
     ;;          (find-file (buffer-substring-no-properties
     ;;                      (previous-single-property-change point 'help-echo)
     ;;                      (next-single-property-change point 'help-echo))))
     (defun pat-eshell-ls-find-file-at-mouse-click (event)
       "Middle click on Eshell's `ls' output to open files.
 From Patrick Anderson via the wiki."
       (interactive "e")
       (ted-eshell-ls-find-file-at-point (posn-point (event-end event))))
     (defun ted-eshell-ls-find-file ()
       (interactive)
       (let ((fname (buffer-substring-no-properties
                     (previous-single-property-change (point) 'help-echo)
                     (next-single-property-change (point) 'help-echo))))
         ;; Remove any leading whitespace, including newline that might
         ;; be fetched by buffer-substring-no-properties
         (setq fname (replace-regexp-in-string "^[ \t\n]*" "" fname))
         ;; Same for trailing whitespace and newline
         (setq fname (replace-regexp-in-string "[ \t\n]*$" "" fname))
         (cond
          ((equal "" fname)
           (message "No file name found at point"))
          (fname
           (find-file fname)))))
     (let ((map (make-sparse-keymap)))
       ;;          (define-key map (kbd "RET")      'ted-eshell-ls-find-file-at-point)
       ;;          (define-key map (kbd "<return>") 'ted-eshell-ls-find-file-at-point)
       (define-key map (kbd "RET")      'ted-eshell-ls-find-file)
       (define-key map (kbd "<return>") 'ted-eshell-ls-find-file)
       (define-key map (kbd "<mouse-2>") 'pat-eshell-ls-find-file-at-mouse-click)
       (defvar ted-eshell-ls-keymap map))
     (defadvice eshell-ls-decorated-name (after ted-electrify-ls activate)
       "Eshell's `ls' now lets you click or RET on file names to open them."
       (add-text-properties 0 (length ad-return-value)
                            (list 'help-echo "RET, mouse-2: visit this file"
                                  'mouse-face 'highlight
                                  'keymap ted-eshell-ls-keymap)
                            ad-return-value)
       ad-return-value)))


;;====================
;; slime
;;====================
;; Clozure CLをデフォルトのCommon Lisp処理系に設定

(when is_win
  (setq inferior-lisp-program "ccl.bat"))
(when is_mac
  (setq inferior-lisp-program "dx86cl64"))
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
             (define-key slime-mode-map [(tab)]     'slime-indent-and-complete-symbol)))

;; slime-repl再起動
(add-hook 'slime-repl-mode-hook
          '(lambda ()
             (define-key slime-repl-mode-map "\C-c\M-r" 'slime-restart-inferior-lisp)))


;;====================
;; ac-sime
;;====================
(require 'ac-slime)
(add-hook 'slime-mode-hook      'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                           (auto-complete-mode 1))))
(real-global-auto-complete-mode t)


;;====================
;; cl-indent-patches
;;====================
(when (require 'cl-indent-patches nil t)
  ;; emacs-lispのインデントと混同しないように
  (setq lisp-indent-function
        (lambda (&rest args)
          (apply (if (memq major-mode '(emacs-lisp-mode lisp-interaction-mode))
                     'lisp-indent-function
                   'common-lisp-indent-function)
                 args))))


;;====================
;; cyg-mount
;;====================
;; Cygwin のドライブ・プレフィックスを有効に
(setq cygwin-mount-cygwin-bin-directory "c:/cygwin/bin")
(require 'cygwin-mount)
(cygwin-mount-activate)



;;====================
;; rst
;;====================
;; @see launch setting
(require 'rst)
;; 拡張子の*.rst, *.restのファイルをrst-modeで開く
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
                ("\\.howm$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))
;; 背景が黒い場合はこうしないと見出しが見づらい
(setq frame-background-mode 'dark)
;; インデントをスペースで
(add-hook 'rst-mode-hook 
          '(lambda() 
             (setq indent-tabs-mode nil)
      ;;       (setq-default tab-width 3 indent-tabs-mode nil)
))


;;====================
;; scratch-log.el
;;====================
(require 'scratch-log)
;; (setq sl-scratch-log-file "~/.emacs.d/.scratch-log")
;; (setq sl-prev-scratch-string-file "~/.emacs.d/.scratch-log-prev")

;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
;; (setq sl-restore-scratch-p nil)
;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
;; (setq sl-prohibit-kill-scratch-buffer-p nil)


;;====================
;; gtags
;;====================
(when (locate-library "gtags")
  (require 'gtags)
)

(global-set-key "\M-t" 'gtags-find-tag)     ;関数の定義元へ
(global-set-key "\M-r" 'gtags-find-rtag)    ;関数の参照先へ
(global-set-key "\M-s" 'gtags-find-symbol)  ;変数の定義元/参照先へ
(global-set-key "\M-p" 'gtags-find-pattern)
;;(global-set-key "\M-f" 'gtags-find-file)    ;ファイルにジャンプ
(global-set-key [?\C-,] 'gtags-pop-stack)   ;前のバッファに戻る

(setq gtags-mode-hook
      '(lambda ()
         (setq gtags-select-buffer-single t)
         ))


;;====================
;; smartchr.el
;;====================
(require 'smartchr)
(global-set-key (kbd ">")
 (smartchr '(">" "-> " "=> " "-> '`!!''" "-> \"`!!'\"" "=> '`!!''" "=> \"`!!'\"" "")))
(global-set-key (kbd "\"") (smartchr '("\"" "\"`!!'\"" "'" "'`!!''" "")))
;; (global-set-key (kbd "(") (smartchr '("(" "(`!!')" "((" "")))
(global-set-key (kbd "G") (smartchr '("G" "ありがとうございます" "`!!'ありがとうございます" "")))



;;====================
;; popup-select-window.el
;;====================
(require 'popup)
(require 'popup-select-window)
(global-set-key "\C-xo" 'popup-select-window)
(key-chord-define-global "gh" 'popup-select-window)
;; モードラインハイライトをオフ
(setq popup-select-window-use-modeline-highlight nil)


;(when is_linux
  ;;====================
  ;; emacs-skype
  ;;====================
  ;(require 'skype)
  ;(setq skype--my-user-handle "nishikawasasaki")
  ;(global-set-key (kbd "M-9") 'skype--anything-command))


(when is_not_win
  ;;====================
  ;; emacs-evernote-mode
  ;;====================
  ;; (add-to-list 'load-path "<your load path>")
  (require 'evernote-mode)
  (setq evernote-username "momijishimeji") ; optional: you can use this username as default.
  ;; (setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8")) ; optional
  (global-set-key "\C-cec" 'evernote-create-note)
  (global-set-key "\C-ceo" 'evernote-open-note)
  (global-set-key "\C-ces" 'evernote-search-notes)
  (global-set-key "\C-ceS" 'evernote-do-saved-search)
  (global-set-key "\C-cew" 'evernote-write-note)
  (global-set-key "\C-cep" 'evernote-post-region)
  (global-set-key "\C-ceb" 'evernote-browser))


;;====================
;; malabar-mode
;;====================
;; (require 'malabar-mode nil t)
;; (setq malabar-groovy-lib-dir (expand-file-name "~/.emacs.d/elisp/malabar-1.5/malabar-lib")) ; お好みで
;; (add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

;; ;; 普段使わないパッケージを import 候補から除外
;; (add-to-list 'malabar-import-excluded-classes-regexp-list
;;              "^java\\.awt\\..*$")
;; (add-to-list 'malabar-import-excluded-classes-regexp-list
;;              "^com\\.sun\\..*$")
;; (add-to-list 'malabar-import-excluded-classes-regexp-list
;;              "^org\\.omg\\..*$")

;; ;; コンパイル前に保存する
;; (add-hook 'malabar-mode-hook
;;           (lambda ()
;;             (add-hook 'after-save-hook 'malabar-compile-file-silently nil t)))
;; ; 日本語だとコンパイルエラーメッセージが化けるので
;; (setq malabar-groovy-java-options '("-Duser.language=en")) 


;;====================
;; htmlize.el
;;====================
(load "htmlize.el")





;; ---------------------------------------------------------------------------------
;; Visual Settings
;; ---------------------------------------------------------------------------------

;; フォント
(when is_linux
;;  (add-to-list 'default-frame-alist '(font . "A-OTF 新ゴ Pro-11"))

  ;; (set-face-attribute 'default nil
  ;;                     ;; :family "Takaoゴシック"
  ;;                     ;; :family "Inconsolata"
  ;;                     ;; :family "VL ゴシック"
  ;;                     :family "ricty"
  ;;                     ;; :family "MeiryoKe_Console"
  ;;                     :height 115)

(set-default-font "MeiryoKe_Console-11.0")
(set-face-font 'variable-pitch "MeiryoKe_Console-11.0")
(set-fontset-font (frame-parameter nil 'font)
                 'japanese-jisx0208
                 '("MeiryoKe_Console" . "unicode-bmp"))
)

(when is_win
  (add-to-list 'default-frame-alist '(font . "ricty-10.5"))
  ;; (add-to-list 'default-frame-alist '(font . "MeiryoKe_Console-10.5"))
)

(when is_mac
  ;; フォント設定
  (setq my-font "-*-*-medium-r-normal--12-*-*-*-*-*-fontset-hiramaru")
  (set-face-attribute 'default nil
                      :family "Monaco"
                      :height 140)
                                        ;:height 90)
  (set-fontset-font "fontset-default"
                    'japanese-jisx0208
                    '("VL_Gothic" . "iso10646-1"))
  (set-fontset-font "fontset-default"
                    'katakana-jisx0201
                    '("VL_Gothic" . "iso10646-1"))
  (setq face-font-rescale-alist
        '((".*Monaco-bold.*" . 1.0)
          (".*Monaco-medium.*" . 1.0)
          (".*Osaka-bold.*" . 1.0)
          (".*Osaka-medium.*" . 1.0)
          ("-cdac$" . 1.4)))
)



;; color-themeの設定
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-andreas)
;; (color-theme-ns-w2)
;; (color-theme-ns)
;; (color-theme-tangotango)
(color-theme-tomorrow-night-bright)

;; ウィンドウを透明化
(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; キーワードのカラー表示を有効化
(global-font-lock-mode t)

;; 選択範囲をハイライト
(setq-default transient-mark-mode t)


;; モードライン (mode-line-format)での書式記号
;; %b -- print buffer name.
;; %f -- print visited file name.
;; %F -- print frame name.
;; %* -- print %, * or hyphen.
;; %+ -- print *, % or hyphen.
;;       %& is like %*, but ignore read-only-ness.
;;       % means buffer is read-only and * means it is modified.
;;       For a modified read-only buffer, %* gives % and %+ gives *.
;; %s -- print process status.   %l -- print the current line number.
;; %c -- print the current column number (this makes editing slower).
;;       To make the column number update correctly in all cases,`column-number-mode' must be non-nil.
;; %i -- print the size of the buffer.
;; %I -- like %i, but use k, M, G, etc., to abbreviate.
;; %p -- print percent of buffer above top of window, or Top, Bot or All.
;; %P -- print percent of buffer above bottom of window, perhaps plus Top, or print Bottom or All.
;; %n -- print Narrow if appropriate.
;; %t -- visited file is text or binary (if OS supports this distinction).
;; %z -- print mnemonics of keyboard, terminal, and buffer coding systems.
;; %Z -- like %z, but including the end-of-line format.
;; %e -- print error message about full memory.
;; %@ -- print @ or hyphen.  @ means that default-directory is on a remote machine.
;; %[ -- print one [ for each recursive editing level.  %] similar.
;; %% -- print %.
;; %- -- print infinitely many dashes.
;; モードライン
(setq-default mode-line-format
              (list "%*["
                    'mode-line-mule-info
                    "] L%l:C%c %P   %b   (%m"
                    'minor-mode-alist
                    ")"
                    )
              )

;; タイトルバー
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))


;; 対応するカッコをハイライト
(show-paren-mode 1)

;; ハイライト
(transient-mark-mode t)

;; 行数表示
(global-set-key "\M-n" 'linum-mode)

;; カーソル点滅
(blink-cursor-mode t)



;; カーソル行ハイライト
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "grey5"))
    (((class color)
      (background light))
;;     (:background "lemon chiffon"))
     (:background "#e8ff9e"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)


;; 1画面スクロールで前の表示を何行分残すか
(setq next-screen-context-lines 5)


;; タブ, 全角スペース, 行末空白表示
(defface my-face-b-1 '((t (:background "gray25"))) nil) ; 全角スペース
(defface my-face-b-2 '((t (:background "gray25"))) nil) ; タブ
;;(defface my-face-u-1 '((t (:background "SteelBlue" :underline t))) nil) ; 行末空白
(defface my-face-u-1 '((t (:background "gray20"))) nil) ; 行末空白
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

(add-to-list 'default-frame-alist '(cursor-type 'hollow-rectangle))

;; カーソル位置のフェースを調べる関数
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; ツールバーを消す
(cond
 (is_emacs23
  (menu-bar-mode nil))
 (is_emacs24
  (tool-bar-mode 0)))



(require 'cl)  ; loop, delete-duplicates

(defun anything-font-families ()
  "Preconfigured `anything' for font family."
  (interactive)
  (flet ((anything-mp-highlight-match () nil))
    (anything-other-buffer
     '(anything-c-source-font-families)
     "*anything font families*")))

(defun anything-font-families-create-buffer ()
  (with-current-buffer
      (get-buffer-create "*Fonts*")
    (loop for family in (sort (delete-duplicates (font-family-list)) 'string<)
          do (insert
              (propertize (concat family "\n")
                          'font-lock-face
                          (list :family family :height 2.0 :weight 'bold))))
    (font-lock-mode 1)))

(defvar anything-c-source-font-families
      '((name . "Fonts")
        (init lambda ()
              (unless (anything-candidate-buffer)
                (save-window-excursion
                  (anything-font-families-create-buffer))
                (anything-candidate-buffer
                 (get-buffer "*Fonts*"))))
        (candidates-in-buffer)
        (get-line . buffer-substring)
        (action
         ("Copy Name" lambda
          (candidate)
          (kill-new candidate))
         ("Insert Name" lambda
          (candidate)
          (with-current-buffer anything-current-buffer
            (insert candidate))))))




;; ---------------------------------------------------------------------------------
;; launch Settings
;; ---------------------------------------------------------------------------------
(add-hook 'after-init-hook
          (lambda()
            (eshell)
            (switch-to-buffer "*scratch*")
            (rst-mode)
            (wrap-region-mode)
))
