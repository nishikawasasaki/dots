;;; Author: Ethan Schoonover, Solarized; Greg Pfeil, Emacs adaptation
;;; URL: http://ethanschoonover.com/solarized

;;; This file is not (YET) part of GNU Emacs.

;;; # Usage

;;; 1. Install the color-theme package
;;;   (http://www.emacswiki.org/cgi-bin/wiki/ColorTheme)
;;; 2. Load this file
;;; 3. M-x color-theme-solarized-[dark|light]

(eval-when-compile
  (require 'color-theme))

(defun color-theme-solarized (mode)
  "Color theme by Ethan Schoonover, created 2011-03-24.
Ported to Emacs by Greg Pfeil, http://ethanschoonover.com/solarized."
  (interactive "Slight or dark? ")
  (let ((base03  "#002b36")
        (base02  "#073642")
        (base01  "#586e75")
        (base00  "#657b83")
        (base0   "#839496")
        (base1   "#93a1a1")
        (base2   "#eee8d5")
        ;; (base3   "#fdf6e3")
        (base3   "#fefbf3")
        (base31   "#faebc3")
        (magenta "#d33682")
        (violet  "#6c71c4")
        (cyan    "#2aa198")
        (red "#c82829")
        (orange "#f5871f")
        (yellow "#eab700")
        (green "#718c00")
        (aqua "#3e999f")
        (blue "#4271ae")
        (purple "#8959a8")
        (white "#ffffff")
        )
    (when (eq 'light mode)
      (rotatef base03 base3)
      (rotatef base02 base2)
      (rotatef base01 base1)
      (rotatef base00 base0))
    (color-theme-install
     `(color-theme-solarized
       ;; ((foreground-color . ,base0)
       ((foreground-color . ,"#111111")
        (background-color . ,base03)
        (background-mode . ,mode)
        (cursor-color . ,red))
       ;; basic
       (default ((t (:foreground ,base0))))
       (cursor ((t (:foreground ,base0 :background ,base03 :inverse-video t))))
       (escape-glyph-face ((t (:foreground ,red))))
       (fringe ((t (:foreground ,base01 :background ,base03))))
       ;; (header-line ((t (:foreground ,base0 :background ,base2))))
       (highlight ((t (:background ,base02))))
       ;; (isearch ((t (:foreground ,orange :inverse-video t))))
       (isearch ((t (:background ,orange :foreground ,white))))
       (isearch-lazy-highlight-face ((t (:background ,orange))))
       (menu ((t (:foreground ,base0 :background ,base02))))
       (minibuffer-prompt ((t (:foreground ,blue))))
       (mode-line
        ((t (:foreground ,base1 :background ,base02
                         :box (:line-width 1 :color ,base1)))))
       (mode-line-buffer-id ((t (:foreground ,base1))))
       (mode-line-inactive
        ((t (:foreground ,base0  :background ,base02
                         :box (:line-width 1 :color ,base02)))))
       (region ((t (:background ,base31))))
       (secondary-selection ((t (:background ,base02))))
       (trailing-whitespace ((t (:foreground ,red :inverse-video t))))
       (vertical-border ((t (:foreground ,base0))))
       ;; compilation
       (compilation-info ((t (:forground ,green :bold t))))
       (compilation-warning ((t (:foreground ,orange :bold t))))
       ;; customize
       (custom-button
        ((t (:background ,base02 :box (:line-width 2 :style released-button)))))
       (custom-button-mouse ((t (:inherit custom-button :foreground ,base1))))
       (custom-button-pressed
        ((t (:inherit custom-button-mouse
                      :box (:line-width 2 :style pressed-button)))))
       (custom-comment-tag ((t (:background ,base02))))
       (custom-comment-tag ((t (:background ,base02))))
       (custom-documentation ((t (:inherit default))))
       (custom-group-tag ((t (:foreground ,orange :bold t))))
       (custom-link ((t (:foreground ,violet))))
       (custom-state ((t (:foreground ,green))))
       (custom-variable-tag ((t (:foreground ,orange :bold t))))
       ;; diff
       (diff-added ((t (:foreground ,green :inverse-video t))))
       (diff-changed ((t (:foreground ,yellow :inverse-video t))))
       (diff-removed ((t (:foreground ,red :inverse-video t))))
       ;; emacs-wiki
       (emacs-wiki-bad-link-face ((t (:foreground ,red :underline t))))
       (emacs-wiki-link-face ((t (:foreground ,blue :underline t))))
       (emacs-wiki-verbatim-face ((t (:foreground ,base00 :underline t))))
       ;; font-lock
       (font-lock-builtin-face ((t (:foreground ,green))))
       ;; (font-lock-comment-face ((t (:foreground ,base01 :italic t))))
       (font-lock-comment-face ((t (:foreground ,base01))))
       (font-lock-constant-face ((t (:foreground ,cyan))))
       (font-lock-function-name-face ((t (:foreground ,blue))))
       (font-lock-keyword-face ((t (:foreground ,green))))
       (font-lock-string-face ((t (:foreground ,cyan))))
       (font-lock-type-face ((t (:foreground ,yellow))))
       (font-lock-variable-name-face ((t (:foreground ,blue))))
       (font-lock-warning-face ((t (:foreground ,red :bold t))))
       ;; info
       (info-xref ((t (:foreground ,blue :underline t))))
       (info-xref-visited ((t (:inherit info-xref :foreground ,magenta))))
       ;; org
       (org-hide ((t (:foreground ,base03))))
       (org-todo ((t (:foreground ,red :bold t))))
       (org-done ((t (:foreground ,green :bold t))))
       ;; show-paren
       (show-paren-match-face ((t (:background ,blue :foreground ,nil))))
       (show-paren-mismatch-face ((t (:background ,orange :foreground ,nil))))

       ;; helm
       (helm-header ((t (:background ,"#81a2be" :foreground ,base3))))
       (header-line ((t (:background ,"#81a2be" :foreground ,base3))))
       (helm-source-header ((t (:background ,"#81a2be" :foreground ,base3))))
       (helm-selection ((t (:background ,"#b5bd68" :foreground ,base3))))
       (helm-visible-mark ((t (:background ,red :foreground ,base3))))
       (helm-ff-directory ((t (:background ,nil :foreground ,blue))))
       (helm-candidate-number ((t (:background ,nil :foreground ,yellow))))

       ;; elscreen
       (elscreen-tab-background-face ((t (:background ,base03))))
       (elscreen-tab-control-face ((t (:background ,base03 :foreground ,base3))))
       (elscreen-tab-current-screen-face ((t (:background ,base03 :foreground ,red))))
       (elscreen-tab-other-screen-face ((t (:background ,base03 :foreground ,base3))))

       ;; yalinum
       (yalinum-face ((t (:background ,base03 :foreground ,base3))))
       (yalinum-bar-face ((t (:background "#b5bd68" :foreground ,base3))))

       ;; speebar
       (speedbar-tag-face ((t (:background ,base03 :foreground ,base3))))
       (speedbar-selected-face ((t (:background ,base03 :foreground ,red))))
       (speedbar-file-face ((t (:background ,base03 :foreground ,"#888888"))))

       ;; eshell
       (eshell-prompt ((t (:foreground ,"#888888"))))
       (eshell-ls-executable ((t (:foreground ,red))))
       (eshell-ls-missing ((t (:foreground ,orange))))
       (eshell-ls-archive ((t (:foreground ,green))))
       (eshell-ls-directory ((t (:foreground ,blue))))
       (eshell-ls-readonly ((t (:foreground ,yellow))))
       (eshell-ls-symlink ((t (:foreground ,violet))))

       ;; dired
       (dired-flagged ((t (:background ,base03 :foreground ,orange))))

       ;; slime
       (slime-repl-inputed-output-face ((t (:foreground ,red))))

       ;; magit
       (magit-diff-add ((t (:foreground ,red))))
       (magit-diff-del ((t (:foreground ,red))))
       (magit-section-title ((t (:foreground ,red))))
       (magit-header ((t (:foreground ,red :box (:line-width 1)))))

       ))))


(defun color-theme-solarized-dark ()
  (interactive)
  (color-theme-solarized 'dark))

(defun color-theme-solarized-light ()
  (interactive)
  (color-theme-solarized 'light))

(add-to-list 'color-themes
             '(color-theme-solarized-light
               "Solarized Light"
               "Ethan Schoonover & Greg Pfeil <greg@technomadic.org>"))
(add-to-list 'color-themes
             '(color-theme-solarized-dark
               "Solarized Dark"
               "Ethan Schoonover & Greg Pfeil <greg@technomadic.org>"))

(provide 'color-theme-solarized)
