;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 345ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+----------------------------------------------------------------------------+
| Exercise 345.                                                              |
| -------------                                                              |
| Formulate a data definition for the representation of BSL expressions      |
| based on the structure type definitions of add and mul. Let’s use BSL+expr |
| in analogy for S-expr for the new class of data.                           |
|                                                                            |
| Translate the following expressions into data:                             |
| (+ 10 -10)                                                                 |
| (+ (* 20 3) 33)                                                            |
| (+ (* 3.14 (* 2 3)) (* 3.14 (* -1 -9)))                                    |
|                                                                            |
| Interpret the following data as expressions:                               |
| (make-add -1 2)                                                            |
| (make-add (make-mul -2 -3) 33)                                             |
| (make-mul (make-add 1 (make-mul 2 3)) 3.14)                                |
+----------------------------------------------------------------------------+
|#

(define-struct add [left right])
; An Add is a Structure:
;  (make-add BSL-expr BSL-expr)
; interpretation. (make-add BSL-expr BSL-expr) shows
; the addition of two BSL-expr

(define-struct mul [left right])
; A Mul is a structure:
;  (make-mul BSL-expr BSL-expr)
; interpretation (make-mul BSL-expr BSL-expr) shows
; the multiplication of two BSL-expr

;; BSL-expr is one of
;; - Number
;; - (make-add BSL-expr BSL-expr)
;; - (make-mul BSL-expr BSL-expr)
;; interpretation. represents an addition/multiplication
;; of two numbers in Beginning Student Language

;; DATA EXAMPLES FROM THE BOOK

(define a1 (+ 10 -10))
(deifne a1-sol (make-add 10 -10))

(define a2 (+ (* 20 3) 33))
(define a2-sol (make-add (make-mul 20 3) 33))

(deifne a3 (+ (* 3.14 (* 2 3)) (* 3.14 (* -1 -9))))
(define a3-sol (make-add (make-mul 3.14 (make-mul 2 3)) (make-mul 3.14 (make-mul -1 -9))))

(define b1 (make-add -1 2))
(define b1-sol (+ -1 2))

(define b2 (make-add (make-mul -2 -3) 33))
(define b1-sol (+ (* -2 -3) 33))

(define b3 (make-mul (make-add 1 (make-mul 2 3)) 3.14))
(define b1-sol (* (+ 2 (* 2 3)) 3.14))