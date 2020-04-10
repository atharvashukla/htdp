;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 260ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 260
;; ------------
;; Confirm the insight about the performance of inf.v2 by repeating the
;; performance experiment of exercise 238.
;; -----------------------------------------------------------------------------

(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (< (first l) (inf (rest l)))
              (first l)
              (inf (rest l)))]))

(define list1
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13
        12 11 10 9 8 7 6 5 4 3 2 1))

; very slow
(check-expect (inf list1) 1)


; Nelon -> Number
; determines the smallest number on l
(define (inf.v2 l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define smallest-in-rest (inf.v2 (rest l))))
       (if (< (first l) smallest-in-rest)
           (first l)
           smallest-in-rest))]))

; very fast
(check-expect (inf.v2 list1) 1)