;; ;; install or upgrade
;; (package-initialize)
;; (if (require 'quelpa nil t)
;;     (quelpa-self-upgrade)
;;   (with-temp-buffer
;;     (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
;;     (eval-buffer)))
;;
;;
;; (quelpa '(helm :repo "emacs-helm/helm" :fetcher github))
;; (quelpa '(helm-descbinds :repo "emacs-helm/helm-descbinds" :fetcher github))
;; (quelpa '(popwin :repo "m2ym/popwin-el" :files ("popwin.el") :fetcher github))
;; (quelpa '(git-modes :repo "magit/git-modes" :fetcher github))
;; (quelpa '(magit :repo "magit/magit" :fetcher github))
;; (quelpa '(popup :repo "auto-complete/popup-el" :files ("popup.el") :fetcher github))
;; (quelpa '(popwin :repo "m2ym/popwin-el" :files ("popwin.el") :fetcher github))
;; (quelpa '(auto-complete :repo "auto-complete/auto-complete" :fetcher github))
;; (quelpa '(expand-region :repo "magnars/expand-region.el" :fetcher github))
;; (quelpa '(wrap-region :repo "rejeep/wrap-region.el" :fetcher github))
;; (quelpa '(rainbow-delimiters :repo "jlr/rainbow-delimiters" :fetcher github))
;; (quelpa '(twittering-mode :repo "hayamiz/twittering-mode" :fetcher github))
;; (quelpa '(scratch-log :repo "mori-dev/scratch-log" :fetcher github))
;; (quelpa '(haskell-mode :repo "haskell/haskell-mode" :fetcher github))
;; (quelpa '(yalinum :repo "tm8st/emacs-yalinum" :files ("yalinum.el") :fetcher github))
;; (quelpa '(elscreen :repo "nishikawasasaki/elscreen" :fetcher github))
;; (quelpa '(git-gutter :repo "syohex/git-gutter" :fetcher github))
;; (quelpa '(git-gutter-fringe :repo "syohex/emacs-git-gutter-fringe" :fetcher github))
;; (quelpa '(multiple-cursors :repo "magnars/multiple-cursors.el" :fetcher github))
;; (quelpa '(smartrep :repo "myuhe/smartrep.el" :fetcher github))
;; (quelpa '(clojure-mode :repo "clojure-emacs/clojure-mode" :fetcher github))
;; (quelpa '(guide-key :repo "kai2nenobu/guide-key" :fetcher github))
;; (quelpa '(js2-mode :repo "mooz/js2-mode" :fetcher github))
;; (quelpa '(scala-mode2 :repo "hvesalai/scala-mode2" :fetcher github))
;; (quelpa '(rotate :repo "daic-h/emacs-rotate" :fetcher github))
;; (quelpa '(anzu :repo "syohex/emacs-anzu" :fetcher github))
;; (quelpa '(web-mode :repo "fxbois/web-mode" :fetcher github))
;; (quelpa '(go-mode :repo "dominikh/go-mode.el" :fetcher github))
;; (quelpa '(smart-newline :repo "ainame/smart-newline.el" :fetcher github))
;; (quelpa '(markdown-mode :repo "defunkt/markdown-mode" :fetcher github))
;; (quelpa '(highlight-symbol :repo "tsdh/highlight-symbol.el" :fetcher github))
;; (quelpa '(ace-jump-mode :repo "winterTTr/ace-jump-mode" :fetcher github))
;; (quelpa '(ace-isearch :repo "tam17aki/ace-isearch" :fetcher github))
;; (quelpa '(historyf :repo "k1LoW/emacs-historyf" :fetcher github))
;; (quelpa '(migemo :repo "emacs-jp/migemo" :fetcher github))
;; (quelpa '(swoop :repo "ShingoFukuyama/emacs-swoop" :fetcher github))
;;
;;
;; (quelpa 'undo-tree)
;;
;;
;; (quelpa 'slime)
;; (quelpa 'ac-slime)
