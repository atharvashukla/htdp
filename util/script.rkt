#lang racket

; Number [List-of X] -> [List-of X]
; ASSUME: (> (length l) n)
(define (remove-lines n l)
  (if (> (length l) n)
      (begin
        (let loop ([n n] [l l])
          (if (= n 0)
              l
              (loop (sub1 n) (rest l)))))
      (error (string-append "remove-lines: the length of the list should be"
                            "greater than the no. of elements to be removed"))))

; [List-of String] -> [List-of String]
; adds the hash-lang line plus an empty line
(define (add-lang-line file-as-lines)
  (append (list "#lang htdp/bsl" "")
          file-as-lines))

; [[List-of String] -> [List-of String]]
(define (file-as-line-changer file-as-lines)
  (change-comment-style (add-lang-line (remove-lines 3 file-as-lines))))

; Number String [[List-of String] -> [List-of String]]
(define (change-file in-file out-file change-file-as-lines)
  (display-lines-to-file (file-as-line-changer (file->lines in-file)) out-file))

; String -> (U Error EFFECT)
(define (main in-files)
  (for ([in-file in-files])
    (define out-file (string-append "___" in-file))
    (if (file-exists? in-file)
        (change-file in-file out-file file-as-line-changer)
        (display (string-append "The file `" in-file "` does not exist!")))))

; [List-of String] -> [List-of String]
(define (change-comment-style los)
  (letrec ([change-line
            (λ (s) (if (and (>= (string-length s) 2)
                            (string=? ";" (substring s 0 1))
                            (string=? ";" (substring s 1 2)))
                       (string-append ";" (substring s 2))
                       s))])
    (map change-line los)))


