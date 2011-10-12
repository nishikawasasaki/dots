(defun dial-scroll ()
  (interactive)
  (lexical-let ((last-rad 0.0))
    (run-with-timer 0.05 0.05
                    (lambda ()
                      (let* ((current-x (cadr (mouse-position)))
                             (current-y (cddr (mouse-position)))
                             (diff-x (float (- current-x (/ (window-width) 2))))
                             (diff-y (float (- current-y (/ (window-height) 2))))
                             (rad (+ (atan (/ diff-y diff-x))
                                     (if (> 0.0 diff-x) 0 pi)))
                             (diff (let ((d (- rad last-rad)))
                                     (cond ((< d (* -1 pi)) (+ d (* 2 pi)))
                                           ((> d pi) (- d (* 2 pi)))
                                           (t d)))))
                        (setq last-rad rad)
                        (scroll-up (cond ((< 0 diff) 1)
                                         ((> 0 diff) -1)
                                         (t 0))))))))
(provide 'dial-scroll)