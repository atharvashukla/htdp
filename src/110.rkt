;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |110|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 110.
;; -------------
;; A checked version of area-of-disk can also enforce that the arguments to the
;; function are positive numbers, not just arbitrary numbers. Modify
;; checked-area-of-disk in this way. 
;; -----------------------------------------------------------------------------



; Number -> Number
; computes the area of a disk with radius r

(check-within (area-of-disk 5) 78.5 0.01)
(check-within (area-of-disk 10) 314 0.01)

(define (area-of-disk r)
  (* 3.14 (* r r)))



; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number

(check-error (checked-area-of-disk "my disk")
             "area-of-disk: positive number expected")

(check-error (checked-area-of-disk -3)
             "area-of-disk: positive number expected")

(check-within (checked-area-of-disk 10) 314 0.01)

(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (positive? v)) (area-of-disk v)]
    [else (error "area-of-disk: positive number expected")]))
