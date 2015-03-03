;;; color-theme-tomorrow.el --- GNU Emacs port of the Tomorrow Theme.

;;; Commentary:
;;
;;; Tomorrow Theme
;;
;; Originally by Chris Kempson https://github.com/ChrisKempson/Tomorrow-Theme
;; Ported to GNU Emacs by Chris Charles

(require 'color-theme)

;;; Code:

(defun color-theme-tomorrow-real (&optional variant)
  "Enable the appropriate Tomorrow theme based on VARIANT.

VARIANT can be 'night, 'night-eighties, 'night-blue or
'night-bright.  If VARIANT is not present, the light Tomorrow
theme will be used."

  (let ((background "#ffffff")
        (current-line "#e9efff")
        (mode-line "#e9efff")
        (mode-line-inactive "#e9efff")
        (selection "#c5cce9")
        (foreground "#4d4d4c")
        (comment "#8e908c")
        (cursor "#aeafad")
        (red "#c82829")
        (orange "#f5871f")
        (yellow "#eab700")
        (green "#718c00")
        (lgreen "#e1e7cb")
        (aqua "#3e999f")
        (blue "#4271ae")
        (purple "#8959a8")
        (magenta "#d33682")
        (cyan    "#2aa198")
        (violet  "#6c71c4")

        (white "#ffffff")
        (black "#2d282a")

        (base03  "#002b36")
        (base02  "#073642")
        (base01  "#586e75")
        (base00  "#657b83")
        (base0   "#839496")
        (base1   "#93a1a1")
        (base2   "#eee8d5")
        (base2o   "#eee8d5")
        ;; (base3   "#fdf6e3")
        (base3   "#fefbf3")
        (base3o   "#fefbf3")
        (base31   "#f6db94")

        )

    (cond ((eq variant 'night)
;;           (setq background "#1d1f21"
           (setq background "#191818"
                 current-line "#282a2e"
                 ;; mode-line "#81a2be"
                 mode-line "#f0c674"
                 mode-line-inactive "#81a2be"
                 ;; selection "#373b41"
                 selection "#515151"
;;                 foreground "#c5c8c6"
                 foreground "#e5e8e6"
                 comment "#8c9898"
                 cursor "#aeafad"
                 red "#cc6666"
                 orange "#de935f"
                 yellow "#f0c674"
                 green "#b5bd68"
                 aqua "#8abeb7"
                 blue "#81a2be"
                 purple "#b294bb"
                 white "#ffffff"))

          ((eq variant 'night-eighties)
           (setq background "#2d2d2d"
                 current-line "#393939"
                 mode-line "#393939"
                 mode-line-inactive "#393939"
                 selection "#515151"
                 foreground "#cccccc"
                 comment "#999999"
                 cursor "#cccccc"
                 red "#f2777a"
                 orange "#f99157"
                 yellow "#ffcc66"
                 green "#99cc99"
                 aqua "#009999"
                 blue "#99cccc"
                 purple "#cc99cc"
                 white "#ffffff"))

          ((eq variant 'night-blue)
           (setq background "#002451"
                 current-line "#00346e"
                 mode-line "#00346e"
                 mode-line-inactive "#00346e"
                 selection "#003f8e"
                 foreground "#ffffff"
                 comment "#7285b7"
                 cursor "#ffffff"
                 red "#ff9da4"
                 orange "#ffc58f"
                 yellow "#ffeead"
                 green "#d1f1a9"
                 aqua "#99ffff"
                 blue "#bbdaff"
                 purple "#ebbbff"
                 white "#ffffff"))

          ((eq variant 'night-bright)
           (setq background "#000000"
                 current-line "#2a2a2a"
                 mode-line "#2a2a2a"
                 mode-line-inactive "#2a2a2a"
                 selection "#424242"
                 foreground "#dedede"
                 comment "#969896"
                 cursor "#9f9f9f"
                 red "#d54e53"
                 orange "#e78c45"
                 yellow "#e7c547"
                 green "#b9ca4a"
                 aqua "#70c0b1"
                 blue "#7aa6da"
                 purple "#c397d8"
                 white "#ffffff")))

    (color-theme-install
     `(color-theme-tomorrow-real
       ((background . ,background)
        (background-mode . dark)
        (border-color . ,cursor)
        ;; (cursor-color . ,cursor)
        (cursor-color . ,yellow)
        (foreground-color . ,foreground))

       ;; Built-in stuff (Emacs 23)
       (default ((t (:background ,background :foreground ,foreground))))
       (fringe ((t (:background ,current-line))))
       (minibuffer-prompt ((t (:foreground ,blue))))
       ;; (mode-line ((t (:background ,mode-line :foreground ,foreground))))
       (mode-line ((t (:background ,"#555555" :foreground ,yellow))))
       (mode-line-inactive ((t (:background ,"#555555" :foreground ,foreground))))
       (region ((t (:background ,selection))))
       (highlight ((t (:background ,current-line))))
       (hi-line ((t (:background ,current-line))))

       ;; Font-lock stuff
       (font-lock-comment-face ((t (:foreground ,comment))))
       (font-lock-constant-face ((t (:foreground ,green))))
       (font-lock-doc-string-face ((t (:foreground ,comment))))
       (font-lock-function-name-face ((t (:foreground ,blue))))
       (font-lock-keyword-face ((t (:foreground ,purple))))
       (font-lock-string-face ((t (:foreground ,green))))
       (font-lock-type-face ((t (:foreground ,yellow))))
       (font-lock-variable-name-face ((t (:foreground ,red))))
       (font-lock-warning-face ((t (:foreground ,red))))

       ;; hl-line-mode
       ;; (hl-line ((t (:background ,current-line))))
       ;; (hl-line ((t (:background ,"grey15"))))

       ;; linum-mode
       (linum ((t (:background ,current-line :foreground ,foreground))))

       ;; org-mode
       (org-date ((t (:foreground ,purple))))
       (org-done ((t (:foreground ,green))))
       (org-hide ((t (:foreground ,current-line))))
       (org-link ((t (:foreground ,blue))))
       (org-todo ((t (:foreground ,red))))
       (org-level-1 ((t (:foreground ,red))))
       (org-level-2 ((t (:foreground ,blue))))
       (org-level-3 ((t (:foreground ,green))))
       (org-level-4 ((t (:foreground ,yellow))))
       (org-level-5 ((t (:foreground ,purple))))

       ;; ;; rst-mode
       ;; (rst-level-1-face ((t (:foreground ,red))))
       (rst-level-1-face ((t (:background ,red :foreground ,white))))
       (rst-level-2-face ((t (:background ,green :foreground ,white))))
       (rst-level-3-face ((t (:background ,blue :foreground ,white))))
       (rst-level-4-face ((t (:background ,yellow :foreground ,white))))
       (rst-level-5-face ((t (:background ,orange :foreground ,white))))
       ;; (rst-level-2-face ((t (:foreground ,blue))))
       ;; (rst-level-3-face ((t (:foreground purple))))

       ;; ;; anything
       ;; (anything-header ((t (:background ,green :foreground ,background))))
       ;; (anything-overlay-line-face ((t (:foreground ,red :background ,blue))))

       ;; show-paren-mode
       (show-paren-match-face ((t (:background ,blue :foreground ,current-line))))
       (show-paren-mismatch-face ((t (:background ,orange :foreground ,current-line))))

       ;; elscreen
       ;; (elscreen-tab-background-face ((t (:background "#000000"))))
       (elscreen-tab-background-face ((t (:background ,"#555555"))))
       (elscreen-tab-control-face ((t (:background ,"#555555"))))
       (elscreen-tab-current-screen-face ((t (:background ,"#555555" :foreground ,yellow))))
       (elscreen-tab-other-screen-face ((t (:background ,"#555555" :foreground ,white))))

       ;; helm
       (helm-header ((t (:background ,"grey22"))))
       (helm-source-header ((t (:background ,"grey40"))))
       ;; (helm-selection ((t (:background ,"grey15" :foreground ,yellow))))
       (helm-selection ((t (:background ,"grey25"  :underline, nil))))
       ;; (helm-selection ((t (:foreground ,yellow))))
       (helm-visible-mark ((t (:background ,red))))
       (helm-ff-directory ((t (:background ,nil :foreground ,blue))))
       (helm-candidate-number ((t (:background ,nil :foreground ,white))))


       ;; yalinum
       ;; (yalinum-face ((t (:background ,base03 :foreground ,base3))))
       (yalinum-bar-face ((t (:background "#b5bd68" :foreground "#000000"))))

       ;; speebar
       ;; (speedbar-tag-face ((t (:foreground ,base3))))
       (speedbar-selected-face ((t (:foreground ,red))))
       (speedbar-file-face ((t (:foreground ,"#888888"))))

       ;; eshell
       (eshell-prompt ((t (:foreground ,"#888888"))))
       (eshell-ls-executable ((t (:foreground ,red))))
       (eshell-ls-missing ((t (:foreground ,orange))))
       (eshell-ls-archive ((t (:foreground ,green))))
       (eshell-ls-directory ((t (:foreground ,blue))))
       (eshell-ls-readonly ((t (:foreground ,yellow))))
       (eshell-ls-symlink ((t (:foreground ,purple))))

       ;; dired
       (dired-flagged ((t (:foreground ,orange))))

       ;; auto-complete
       (ac-candidate-face ((t (:background ,green :foreground ,"#ffffff"))))
       (ac-selection-face ((t (:background ,yellow :foreground ,"#000000"))))
       ;; (set-face-underline 'ac-candidate-face "#b9ca4a")

       ;; slime
       (slime-repl-inputed-output-face ((t (:foreground ,red))))

              (slime-repl-inputed-output-face ((t (:foreground ,red))))

       ;; diff
       (diff-add ((t (:foreground ,green :background ,base03))))
       (diff-removed ((t (:foreground ,red :background ,base03))))
       (diff-changed ((t (:foreground ,yellow :inverse-video t))))

       ;; magit
       (magit-diff-add ((t (:foreground ,green :background ,base03))))
       (magit-diff-del ((t (:foreground ,red :background ,base03))))
       (magit-diff-none ((t (:background ,base03))))
       (magit-header ((t (:foreground ,green :box (:line-width 1)))))
       (magit-item-highlight ((t (:foreground nil :background ,base02))))

       ;; auto-complete
       ;; (ac-candidate-face ((t (:background ,green :foreground ,"#ffffff"))))
       ;; (ac-selection-face ((t (:background ,yellow :foreground ,"#000000"))))
       (ac-candidate-face ((t (:background ,base2o :foreground ,"#a9a497"))))
       (ac-selection-face ((t (:background ,base31 :foreground ,black))))
       ;; (set-face-underline 'ac-candidate-face "#b9ca4a")

       (sh-heredoc ((t (:foreground ,yellow))))

       ;; rainbow-delimiters
       (rainbow-delimiters-depth-1-face ((t (:foreground ,orange :bold t))))
       (rainbow-delimiters-depth-2-face ((t (:foreground ,blue :bold t))))
       (rainbow-delimiters-depth-3-face ((t (:foreground ,magenta :bold t))))
       (rainbow-delimiters-depth-4-face ((t (:foreground ,cyan :bold t))))
       (rainbow-delimiters-depth-5-face ((t (:foreground ,green :bold t))))
       (rainbow-delimiters-depth-6-face ((t (:foreground ,yellow :bold t))))
       (rainbow-delimiters-depth-7-face ((t (:foreground ,violet :bold t))))
       (rainbow-delimiters-depth-8-face ((t (:foreground ,base01 :bold t))))
       (rainbow-delimiters-depth-9-face ((t (:foreground ,aqua :bold t))))

       ;; highlight-indentation
       (highlight-indentation-face ((t (:background "#fcf5dd"))))

       ;; auto-highlight-symbol
       ;; (ahs-face ((t (:background ,base31))))
       (ahs-face ((t (:background ,red))))
       (ahs-definition-face ((t (:background ,yellow :foreground ,black))))
       ;; (ahs-warning-face ((t (:background ,base2o :foreground ,"#a9a497"))))
       (ahs-plugin-defalt-face ((t (:background nil :foreground nil))))
       ;; (ahs-plugin-whole-buffer-face ((t (:background ,base2o :foreground ,"#a9a497"))))
       ;; (ahs-plugin-bod-face ((t (:background ,base2o :foreground ,"#a9a497"))))
       ;; (ahs-edit-mode-face ((t (:background ,base2o :foreground ,"#a9a497"))))

       ;; moccur
       (moccur-face ((t (:background ,base31))))
       (moccur-current-line-face ((t (:background ,lgreen))))

       ;; auto-highlight-symbol
       (ahs-face ((t (:background ,base31))))
       (ahs-definition-face ((t (:background ,yellow :foreground ,black))))
       ;; (ahs-warning-face ((t (:background ,base2o :foreground ,"#a9a497"))))
       (ahs-plugin-defalt-face ((t (:background nil :foreground nil))))
       ;; (ahs-plugin-whole-buffer-face ((t (:background ,base2o :foreground ,"#a9a497"))))
       ;; (ahs-plugin-bod-face ((t (:background ,base2o :foreground ,"#a9a497"))))
       ;; (ahs-edit-mode-face ((t (:background ,base2o :foreground ,"#a9a497"))))

       ;;emacs-anzu
       (anzu-mode-line ((t (:foreground ,blue :bold t))))

       ;; skk
       (skk-dcomp-face ((t (:foreground ,base01))))
       (skk-show-mode-inline-face ((t (:background ,base03))))


))))




(defun color-theme-tomorrow ()
  "Base light Tomorrow theme."
  (interactive)
  (color-theme-tomorrow-real))
(provide 'color-theme-tomorrow)

(defun color-theme-tomorrow-night ()
  "Dark Tomorrow theme."
  (interactive)
  (color-theme-tomorrow-real 'night))
(provide 'color-theme-tomorrow-night)

(defun color-theme-tomorrow-night-eighties ()
  "Somewhat lighter dark Tomorrow theme."
  (interactive)
  (color-theme-tomorrow-real 'night-eighties))
(provide 'color-theme-tomorrow-night-eighties)

(defun color-theme-tomorrow-night-blue ()
  "Dark Tomorrow theme with a blue background."
  (interactive)
  (color-theme-tomorrow-real 'night-blue))
(provide 'color-theme-tomorrow-night-blue)

(defun color-theme-tomorrow-night-bright ()
  "Dark Tomorrow theme with a brighter, higher-contrast look."
  (interactive)
  (color-theme-tomorrow-real 'night-bright))
(provide 'color-theme-tomorrow-night-bright)


(add-to-list 'color-themes
             '(color-theme-tomorrow
               "Tomorrow" "Chris Kempson (ported by Chris Charles)"))
(add-to-list 'color-themes
             '(color-theme-tomorrow-night
               "Tomorrow Night" "Chris Kempson (ported by Chris Charles)"))
(add-to-list 'color-themes
             '(color-theme-tomorrow-night-eighties
               "Tomorrow Night Eighties" "Chris Kempson (ported by Chris Charles)"))
(add-to-list 'color-themes
             '(color-theme-tomorrow-night-blue
               "Tomorrow Night Blue" "Chris Kempson (ported by Chris Charles)"))
(add-to-list 'color-themes
             '(color-theme-tomorrow-night-bright
               "Tomorrow Night Bright" "Chris Kempson (ported by Chris Charles)"))

;;; color-theme-tomorrow.el ends here