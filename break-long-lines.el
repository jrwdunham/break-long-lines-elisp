;;; break-long-lines.el
;;; Version: 0.1.0
;;; Author: Joel Dunham

;; Defines ``break-long-line``, an interactive, zero-arg function that will
;; insert a newline character at the optimal location in the current line, where
;; "optimal" means the closest space character preceding the 80th character; or,
;; failing that, the first space character following the 80th character.

(defun line-too-long? ()
  (let ((original-point (point))
        (original-line-number (line-number-at-pos)))
    (beginning-of-line)
    (forward-char 81)
    (let ((ret (= original-line-number (line-number-at-pos))))
      (goto-char original-point)
      ret)))

(defun at-start-of-line? ()
  (let ((original-point (point)))
    (beginning-of-line)
    (let ((ret (= original-point (point))))
      (goto-char original-point)
      ret)))

(defun at-end-of-line? ()
  (let ((original-point (point)))
    (end-of-line)
    (let ((ret (= original-point (- (point) 1))))
      (goto-char original-point)
      ret)))

(defun find-preceding-space ()
  (let ((original-point (point))
        (original-line (line-number-at-pos)))
    (re-search-backward " ")
    (let ((ret (when (and (not (= (point) original-point))
                              (= original-line (line-number-at-pos)))
                 (point))))
      (goto-char original-point)
      ret)))

(defun find-following-space ()
  (let ((original-point (point))
        (original-line (line-number-at-pos)))
    (re-search-forward " ")
    (let ((ret (when (and (not (= (point) original-point))
                          (= original-line (line-number-at-pos)))
                 (- (point) 1))))
      (goto-char original-point)
      ret)))

(defun find-break-point ()
  (let ((original-point (point)))
    (beginning-of-line)
    (forward-char 80)
    (let ((ret (cond ((at-end-of-line?) nil)
                     ((= 32 (char-after (point))) (point))
                     ((find-preceding-space) (find-preceding-space))
                     ((find-following-space) (find-following-space))
                     (t nil))))
          (goto-char original-point)
  ret)))

(defun break-long-line ()
  "If line is over 80 chars, break it!"
  (interactive)
  (if (line-too-long?)
    (let ((break-point (find-break-point)))
      (if break-point
        (progn (goto-char break-point)
               (newline)
               (when (= 32 (char-after (point))) (delete-char 1)))
        (forward-line)))
    (forward-line)))

;; Map it to C-k
(global-set-key [(control ?k)] 'break-long-line)
