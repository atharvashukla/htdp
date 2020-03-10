#lang htdp/bsl

; Exercise 36.
; ------------
; Design the function image-area, which counts the number of pixels in a given
; image. 
; -----------------------------------------------------------------------------

; +-------------------------------------------+
; | The Design Recipe Card                    |
; |-------------------------------------------|
; | From Problem Analysis to Data Definitions |
; | Signature, Purpose Statement, Header      |
; | Functional Examples                       |
; | Function Template                         |
; | Function Definition                       |
; | Testing                                   |
; +-------------------------------------------+

(require 2htdp/image)

; Image -> Number
; area of the image (1 unit = 1 px)
(define (image-area-stub img)
  empty-image)

; area of a square with height 5 and width 5 is 25
; area of a circle with radius 5 is 10 * 10 = 100

(define (image-area-template img)
  (... img ...))


(define (image-area img)
  (* (image-height img) (image-width img)))


(check-expect (image-area (square 5 "solid" "red")) 25)
(check-expect (image-area (circle 5 "solid" "green")) 100)
