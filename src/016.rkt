#lang htdp/bsl

; Exercise 16.
; ------------
; Define the function image-area, which counts the number of pixels in a given
; image. See exercise 6 for ideas. 
; ------------------------------------------------------------------------------

(require 2htdp/image)

(define (image-area im)
  (* (image-height im) (image-width im)))

(image-area (square 40 "solid" "slateblue"))
; => 1600