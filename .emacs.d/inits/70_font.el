;;====================
;; フォント
;;====================
;; 01234567890123456789
;;  あいうえおかきくけこ
;;   abcdefghijklmnopqrstuvwxyz
;; 下の縦棒が揃うこと
;; | 数字 | アルファベット | 日本語     |
;; | 0123 | abcdefghijklmn | こんにちは |
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
  (set-default-font "ricty-10.5")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp"))

)
(when is_mac
  (set-default-font "ricty-14")
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("ricty" . "unicode-bmp"))
  ;; バラバラに設定する場合
  ;; ;; 英字フォント
  ;; (set-face-attribute 'default nil
  ;;                     :family "ricty"
  ;;                     :height 140)
  ;; ;; 漢字フォント
  ;; (set-fontset-font
  ;;  nil 'japanese-jisx0208
  ;;  (font-spec :family "NfMotoyaAporo"))
  ;; ;; ひらがなかたかな
  ;; (set-fontset-font
  ;;  nil '(#x3040 . #x30ff)
  ;;  (font-spec :family "NfMotoyaAporo"))

  ;; (setq face-font-rescale-alist
  ;;       '((".ricty.*" . 1.0)
  ;;         (".NfMotoyaAporo.*" . 1.0)
  ;;         ("-cdac$" . 1.0)))
)


