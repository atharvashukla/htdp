;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 151ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 151.
;; -------------
;; Design the function multiply. It consumes a natural number n and multiplies
;; it with a number x without using *.
;;
;; Use DrRacket’s stepper to evaluate (multiply 3 x) for any x you like. How
;; does multiply relate to what you know from grade school? 
;; -----------------------------------------------------------------------------


; N Number -> Number
; multiplies n with x without using *

; examples
(check-expect (multiply 3 5) (* 3 5))
(check-expect (multiply 3 0) (* 3 0))
(check-expect (multiply 0 3) (* 0 3))

; stub
#;
(define (multiply n x)
  0)

; template
#;
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [(positive? n) (... (multiply (sub1 n) x) ...)]))

; function definition
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [(positive? n) (+ x (multiply (sub1 n) x))]))

;; multiplication is just repeated addition!
