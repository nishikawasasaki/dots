(require 'helm-config)
(helm-mode 1)

;; find-file では邪魔なので helm を使わない
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))

;; (require 'helm-gtags)
;; configuration helm variable
(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0.1) ; 入力後に候補を更新するまでの時間
(setq helm-candidate-number-limit 300) ; 候補数
(setq helm-buffer-max-length 80) ; バッファ名の最大長
(setq enable-recursive-minibuffers t)

(require 'helm-files)

;; action を buffer kill に入れ替えたものソース
(defun helm-c-buffers-list-R-persistent-action (candidate)
  (if current-prefix-arg
      (helm-c-switch-to-buffer candidate)
    (helm-c-buffers-persistent-kill candidate)))

(defvar helm-source-buffers-list-R
  `((name . "Buffers")
    (init . (lambda ()
              ;; Issue #51 Create the list before `helm-buffer' creation.
              (setq helm-buffers-list-cache (helm-buffer-list))
              (let ((result (cl-loop for b in helm-buffers-list-cache
                                     maximize (length b) into len-buf
                                     maximize (length (with-current-buffer b
                                                        (symbol-name major-mode)))
                                     into len-mode
                                     finally return (cons len-buf len-mode))))
                (unless helm-buffer-max-length
                  (setq helm-buffer-max-length (car result)))
                (unless helm-buffer-max-len-mode
                  ;; If a new buffer is longer that this value
                  ;; this value will be updated
                  (setq helm-buffer-max-len-mode (cdr result))))))
    (candidates . helm-buffers-list-cache)
    (no-matchplugin)
    (type . buffer)
    (match helm-buffer-match-major-mode)
    (persistent-action . helm-c-buffers-list-R-persistent-action)
    (keymap . ,helm-buffer-map)
    (volatile)
    (mode-line . helm-buffer-mode-line-string)
    (persistent-help
     . "Kill this buffer / C-u \\[helm-execute-persistent-action]: Show this buffer")))

;; ディレクトリだけのソース
(defvar helm-c-recentf-directory-source
  '((name . "Recentf Directry")
    (candidates . (lambda ()
                    (loop for file in recentf-list
                          when (file-directory-p file)
                          collect file)))
    (type . file)))
;; ファイルだけのソース
(defvar helm-c-recentf-file-source
  '((name . "Recentf File")
    (candidates . (lambda ()
                    (loop for file in recentf-list
                          when (not (file-directory-p file))
                          collect file)))
    (type . file)))

(defun helm-my ()
  (interactive)
  (helm-other-buffer '(
                       ;; helm-c-source-elscreen
                       helm-source-buffers-list-R
                       ;; helm-c-source-buffers-list
                       helm-c-recentf-file-source
                       helm-c-recentf-directory-source
                       helm-c-source-buffer-not-found)
                     "*helm my*"))

(define-key global-map (kbd "C-;") 'helm-my)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "M-i") 'helm-imenu)


;; git 管理ファイルを状態に応じて表示
(defun helm-c-sources-git-project-for (pwd)
  (loop for elt in
        '(("Modified files" . "--modified")
          ("Untracked files" . "--others --exclude-standard")
          ("All controlled files in this project" . nil))
        for title  = (format "%s (%s)" (car elt) pwd)
        for option = (cdr elt)
        for cmd    = (format "git ls-files %s" (or option ""))
        collect
        `((name . ,title)
          (init . (lambda ()
                    (unless (and (not ,option) (helm-candidate-buffer))
                      (with-current-buffer (helm-candidate-buffer 'global)
                        (call-process-shell-command ,cmd nil t nil)))))
          (candidates-in-buffer)
          (type . file))))
(defun helm-git-project-topdir ()
  (file-name-as-directory
   (replace-regexp-in-string
    "\n" ""
    (shell-command-to-string "git rev-parse --show-toplevel"))))
(defun helm-git-project ()
  (interactive)
  (let ((topdir (helm-git-project-topdir)))
    (unless (file-directory-p topdir)
      (error "I'm not in Git Repository!!"))
    (let* ((default-directory topdir)
           (sources (helm-c-sources-git-project-for default-directory)))
      (helm-other-buffer sources "*helm git project*"))))

(global-set-key (kbd "C-q ;") 'helm-git-project)
