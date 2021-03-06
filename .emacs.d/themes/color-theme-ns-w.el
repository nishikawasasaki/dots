
(eval-when-compile
  (require 'color-theme))

(defun color-theme-ns-w ()
  (interactive)
  (color-theme-install
   '(color-theme-andreas
     ((background-mode . light)
      (background-color . "#FFFFFF")
      (background-toolbar-color . "#cccccccccccc")
      (border-color . "#000000000000")
      (bottom-toolbar-shadow-color . "#7a7a7a7a7a7a")
      (foreground-color . "black")
      (top-toolbar-shadow-color . "#f5f5f5f5f5f5"))
     ((gnus-mouse-face . highlight)
      (ispell-highlight-face . highlight))
     (default ((t (nil))))
     (OrangeRed ((t (nil))))
     (blue ((t (:foreground "blue"))))
     (bold ((t (:bold t))))
     (bold-italic ((t (:italic t :bold t))))
     (border-glyph ((t (nil))))
     (calendar-today-face ((t (:underline t))))
     (color-mode-face-@ ((t (:foreground "orange"))))
     (color-mode-face-a ((t (:foreground "blue"))))
     (color-mode-face-b ((t (:foreground "red"))))
     (color-mode-face-c ((t (:foreground "green3"))))
     (color-mode-face-d ((t (:background "red" :foreground "white"))))
     (color-mode-face-e ((t (:background "orange" :foreground "blue"))))
     (color-mode-face-f ((t (:background "blue" :foreground "yellow"))))
     (color-mode-face-g ((t (:background "lightblue" :foreground "brown"))))
     (color-mode-face-h ((t (:background "brown" :foreground "white"))))
     (custom-button-face ((t (:bold t))))
     (custom-changed-face ((t (:background "blue" :foreground "white"))))
     (custom-documentation-face ((t (nil))))
     (custom-face-tag-face ((t (:underline t))))
     (custom-group-tag-face ((t (:underline t :foreground "blue"))))
     (custom-group-tag-face-1 ((t (:underline t :foreground "red"))))
     (custom-invalid-face ((t (:background "red" :foreground "yellow"))))
     (custom-modified-face ((t (:background "blue" :foreground "white"))))
     (custom-rogue-face ((t (:background "black" :foreground "pink"))))
     (custom-saved-face ((t (:underline t))))
     (custom-set-face ((t (:background "white" :foreground "blue"))))
     (custom-state-face ((t (:foreground "dark green"))))
     (custom-variable-button-face ((t (:underline t :bold t :background "gray90"))))
     (custom-variable-tag-face ((t (:underline t :background "gray95" :foreground "blue"))))
     (diary-face ((t (:foreground "red"))))
     (display-time-mail-balloon-enhance-face ((t (:background "orange"))))
     (display-time-mail-balloon-gnus-group-face ((t (:foreground "blue"))))
     (display-time-time-balloon-face ((t (:foreground "red"))))
     (emacs-wiki-bad-link-face ((t (:bold t :foreground "red"))))
     (emacs-wiki-link-face ((t (:bold t :foreground "green"))))
     (font-lock-comment-face ((t (:foreground "orange1"))))
     (font-lock-doc-string-face ((t (:foreground "orange3"))))
     (font-lock-function-name-face ((t (:foreground "#edd400"))))
;;     (font-lock-keyword-face ((t (:foreground "red1"))))
     (font-lock-keyword-face ((t (:foreground "DodgerBlue3"))))
     (font-lock-preprocessor-face ((t (:foreground "blue3"))))
     (font-lock-reference-face ((t (:foreground "red3"))))
     (font-lock-string-face ((t (:foreground "chartreuse3"))))
     (font-lock-type-face ((t (:foreground "#6920ac"))))
     (font-lock-variable-name-face ((t (:foreground "OrangeRed"))))
     (font-lock-warning-face ((t (:bold t :foreground "Red"))))
     (font-lock-builtin-face ((t (:foreground "SteelBlue1"))))
     (font-lock-constant-face ((t (:foreground "OrangeRed3"))))
     (gnu-cite-face-3 ((t (nil))))
     (gnu-cite-face-4 ((t (nil))))
     (gnus-cite-attribution-face ((t (:underline t))))
     (gnus-cite-face-1 ((t (:foreground "MidnightBlue"))))
     (gnus-cite-face-10 ((t (:foreground "medium purple"))))
     (gnus-cite-face-11 ((t (:foreground "turquoise"))))
     (gnus-cite-face-2 ((t (:foreground "firebrick"))))
     (gnus-cite-face-3 ((t (:foreground "dark green"))))
     (gnus-cite-face-4 ((t (:foreground "OrangeRed"))))
     (gnus-cite-face-5 ((t (:foreground "dark khaki"))))
     (gnus-cite-face-6 ((t (:foreground "dark violet"))))
     (gnus-cite-face-7 ((t (:foreground "SteelBlue4"))))
     (gnus-cite-face-8 ((t (:foreground "magenta"))))
     (gnus-cite-face-9 ((t (:foreground "violet"))))
     (gnus-emphasis-bold ((t (:bold t))))
     (gnus-emphasis-bold-italic ((t (:italic t :bold t))))
     (gnus-emphasis-italic ((t (:italic t))))
     (gnus-emphasis-underline ((t (:underline t))))
     (gnus-emphasis-underline-bold ((t (:underline t :bold t))))
     (gnus-emphasis-underline-bold-italic ((t (:underline t :italic t :bold t))))
     (gnus-emphasis-underline-italic ((t (:underline t :italic t))))
     (gnus-group-mail-1-empty-face ((t (:foreground "DeepPink3"))))
     (gnus-group-mail-1-face ((t (:bold t :foreground "DeepPink3"))))
     (gnus-group-mail-2-empty-face ((t (:foreground "HotPink3"))))
     (gnus-group-mail-2-face ((t (:bold t :foreground "HotPink3"))))
     (gnus-group-mail-3-empty-face ((t (:foreground "magenta4"))))
     (gnus-group-mail-3-face ((t (:bold t :foreground "magenta4"))))
     (gnus-group-mail-low-empty-face ((t (:foreground "DeepPink4"))))
     (gnus-group-mail-low-face ((t (:bold t :foreground "DeepPink4"))))
     (gnus-group-news-1-empty-face ((t (:foreground "ForestGreen"))))
     (gnus-group-news-1-face ((t (:bold t :foreground "ForestGreen"))))
     (gnus-group-news-2-empty-face ((t (:foreground "CadetBlue4"))))
     (gnus-group-news-2-face ((t (:bold t :foreground "CadetBlue4"))))
     (gnus-group-news-3-empty-face ((t (nil))))
     (gnus-group-news-3-face ((t (:bold t))))
     (gnus-group-news-4-empty-face ((t (nil))))
     (gnus-group-news-4-face ((t (:bold t))))
     (gnus-group-news-5-empty-face ((t (nil))))
     (gnus-group-news-5-face ((t (:bold t))))
     (gnus-group-news-6-empty-face ((t (nil))))
     (gnus-group-news-6-face ((t (:bold t))))
     (gnus-group-news-low-empty-face ((t (:foreground "DarkGreen"))))
     (gnus-group-news-low-face ((t (:bold t :foreground "DarkGreen"))))
     (gnus-header-content-face ((t (:italic t :foreground "indianred4"))))
     (gnus-header-from-face ((t (:bold t :foreground "red3"))))
     (gnus-header-name-face ((t (:foreground "maroon"))))
     (gnus-header-newsgroups-face ((t (:italic t :bold t :foreground "MidnightBlue"))))
     (gnus-header-subject-face ((t (:bold t :foreground "red4"))))
     (gnus-splash-face ((t (:foreground "red"))))
     (gnus-summary-cancelled-face ((t (:background "black" :foreground "yellow"))))
     (gnus-summary-high-ancient-face ((t (:bold t :foreground "RoyalBlue"))))
     (gnus-summary-high-read-face ((t (:bold t :foreground "DarkGreen"))))
     (gnus-summary-high-ticked-face ((t (:bold t :foreground "DarkRed"))))
     (gnus-summary-high-unread-face ((t (:bold t))))
     (gnus-summary-low-ancient-face ((t (:italic t :foreground "RoyalBlue"))))
     (gnus-summary-low-read-face ((t (:italic t :foreground "DarkGreen"))))
     (gnus-summary-low-ticked-face ((t (:italic t :foreground "firebrick"))))
     (gnus-summary-low-unread-face ((t (:italic t))))
     (gnus-summary-normal-ancient-face ((t (:foreground "RoyalBlue"))))
     (gnus-summary-normal-read-face ((t (:foreground "DarkGreen"))))
     (gnus-summary-normal-ticked-face ((t (:foreground "Red"))))
     (gnus-summary-normal-unread-face ((t (nil))))
     (gnus-summary-selected-face ((t (:underline t))))
     (gnus-x-face ((t (nil))))
     (green ((t (:foreground "green"))))
     (gui-button-face ((t (:background "grey75"))))
     (gui-element ((t (:background "Gray80"))))
;;     (highlight ((t (nil))))
     (highlight ((t (:background "DarkOliveGreen1" :foreground "black"))))
     (holiday-face ((t (:background "pink"))))
     (hyper-apropos-documentation ((t (:foreground "darkred"))))
     (hyper-apropos-heading ((t (:bold t))))
     (hyper-apropos-hyperlink ((t (:foreground "blue4"))))
     (hyper-apropos-major-heading ((t (:bold t))))
     (hyper-apropos-section-heading ((t (:italic t :bold t))))
     (hyper-apropos-warning ((t (:bold t :foreground "red"))))
     (info-node ((t (:italic t :bold t))))
     (info-xref ((t (:bold t))))
     (isearch ((t (:background "yellow" :foreground "red"))))
     (italic ((t (:italic t))))
     (kai-gnus-cite-face-1 ((t (:foreground "LightCyan4"))))
     (kai-gnus-cite-face-2 ((t (:foreground "LightSkyBlue2"))))
     (kai-gnus-cite-face-3 ((t (:foreground "DodgerBlue3"))))
     (kai-gnus-group-mail-face ((t (:foreground "darkslategrey"))))
     (kai-gnus-group-nonempty-mail-face ((t (:foreground "DarkRed"))))
     (kai-gnus-group-starred-face ((t (:foreground "grey50"))))
     (left-margin ((t (nil))))
     (list-mode-item-selected ((t (:background "gray68"))))
     (message-cited-text ((t (:italic t))))
     (message-cited-text-face ((t (:foreground "red"))))
     (message-header-cc-face ((t (:foreground "MidnightBlue"))))
     (message-header-contents ((t (:italic t))))
     (message-header-name-face ((t (:foreground "cornflower blue"))))
     (message-header-newsgroups-face ((t (:italic t :bold t :foreground "blue4"))))
     (message-header-other-face ((t (:foreground "steel blue"))))
     (message-header-subject-face ((t (:bold t :foreground "navy blue"))))
     (message-header-to-face ((t (:bold t :foreground "MidnightBlue"))))
     (message-header-xheader-face ((t (:foreground "blue"))))
     (message-headers ((t (:bold t))))
     (message-highlighted-header-contents ((t (:italic t :bold t))))
     (message-mml-face ((t (:foreground "ForestGreen"))))
     (message-separator-face ((t (:foreground "brown"))))
     (modeline ((t (:background "chartreuse1" :foreground "Black"))))
     (modeline-buffer-id ((t (:background "chartreuse1" :foreground "Black"))))
     (modeline-mousable ((t (:background "chartreuse1" :foreground "firebrick"))))
     (modeline-mousable-minor-mode ((t (:background "chartreuse1" :foreground "green4"))))
     (paren-blink-off ((t (:foreground "gray80"))))
     (paren-match ((t (:background "red" :foreground "white"))))
     (paren-mismatch ((t (:background "DeepPink"))))
     (pointer ((t (:foreground "blue"))))
     (primary-selection ((t (:background "gray65"))))
     (red ((t (:foreground "red"))))
     (region ((t (:background "gray75"))))
     (right-margin ((t (nil))))
     (secondary-selection ((t (:background "paleturquoise"))))
     (text-cursor ((t (:background "red" :foreground "LightYellow1"))))
     (toolbar ((t (:background "Gray80"))))
     (underline ((t (:underline t))))
     (vertical-divider ((t (:background "Gray80"))))
     (widget-button-face ((t (:bold t))))
     (widget-button-pressed-face ((t (:foreground "red"))))
     (widget-documentation-face ((t (:foreground "dark green"))))
     (widget-field-face ((t (:background "gray85"))))
     (widget-inactive-face ((t (:foreground "dim gray"))))
     (x-face ((t (:background "white"))))
     (yellow ((t (:foreground "yellow"))))
     (zmacs-region ((t (:background "gray65" :foreground "yellow")))))))

(provide 'color-theme-ns-w)
