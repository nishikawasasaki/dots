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
                    ;; "] L%l:C%c %P   %b   (%m"
                    "] L%l:C%c %P   %f   (%m"
                    'minor-mode-alist
                    ")"
                    )
              )

;; -> el-get の powerline で設定
