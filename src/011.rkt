#lang htdp/bsl

; Exercise 11.
; ------------
; Define a function that consumes two numbers, x and y, and that computes the
; distance of point (x,y) to the origin.
; 
; In exercise 1 you developed the right-hand side of this function for
; concrete values of x and y. Now add a header. 
; ------------------------------------------------------------------------------

(define (distance-of-point x y)
  (sqrt (+ (sqr x) (sqr y))))