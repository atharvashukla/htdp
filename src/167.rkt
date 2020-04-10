;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 167ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 167
;; ------------
;; Design the function sum, which consumes a list of Posns and produces the sum
;; of all of its x-coordinates.
;; -----------------------------------------------------------------------------

; List-of-posns -> Number
; sums all the x coordinates of lop

#;
(define (sum lop)
  0)

(define lop1 (cons (make-posn 1 2) '()))
(define lop2 (cons (make-posn 3 0) lop1))
(define lop3 (cons (make-posn -1 5) lop2))

(check-expect (sum '()) 0)
(check-expect (sum lop1) 1)
(check-expect (sum lop2) 4)
(check-expect (sum lop3) 3)

#;
(define (sum lop)
  (cond
    [(empty? lop) ...]
    [else (... (first lop) ... (rest lop) ...)]))

(define (sum lop)
  (cond
    [(empty? lop) 0]
    [else (+ (posn-x (first lop)) (sum (rest lop)))]))