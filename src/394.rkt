;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 394ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 394
;; ------------
;; Design merge. The function consumes two lists of numbers, sorted in ascending
;; order. It produces a single sorted list of numbers that contains all the
;; numbers on both inputs lists. A number occurs in the output as many times as
;; it occurs on the two input lists together.
;; -----------------------------------------------------------------------------



; [List-of Number] [List-of Number] -> [List-of Number]
; merges the two sorted lists l and r into one
#;
(define (merge l r)
'())

(check-expect (merge '() '()) '())
(check-expect (merge '() '(1 2 3)) '(1 2 3))
(check-expect (merge '(1 2 3) '()) '(1 2 3))
(check-expect (merge '(1 2 3) '(1 2 3)) '(1 1 2 2 3 3))
(check-expect (merge '(1 1 1) '(1 1 1)) '(1 1 1 1 1 1))
(check-expect (merge '(1 1 2) '(1 2 2)) '(1 1 1 2 2 2))
(check-expect (merge '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))

#;
(define (merge l r)
  (cond
    [(empty? l) ...]
    [else (... (first l) ... (merge (rest l) r) ...)]))


(define (merge l r)
  (local (; Number [List-of Number] -> [List-of Number]
          ; inserts n into a sorted list l
          (define (insert n l)
            (cond
              [(empty? l) (cons n '())]
              [else (if (<= n (first l))
                        (cons n l)
                        (cons (first l) (insert n (rest l))))])))
    (cond
      [(empty? l) r]
      [else (insert (first l) (merge (rest l) r))])))


