#lang htdp/bsl

; Exercise 12.
; ------------
; Define the function cvolume, which accepts the length of a side of an
; equilateral cube and computes its volume. If you have time, consider
; defining csurface, too.
;
; Hint An equilateral cube is a three-dimensional container bounded by six
; squares. You can determine the surface of a cube if you know that the
; square’s area is its length multiplied by itself. Its volume is the length
; multiplied with the area of one of its squares. (Why?) 
; ------------------------------------------------------------------------------

(define (cvolume s)
  (expt s 3))

(define (csurface s)
  (* 6 (sqr s)))

; Volume is the length multiplied by area of one of the squares because
; area is cross section multiplied by height.