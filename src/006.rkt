#lang htdp/bsl

; Exercise 6.
; -----------
; Add the following line to the definitions area:Copy and paste the image into
; your DrRacket.
; 
;    (define cat <image of the cat>)
;;
; Create an expression that counts the number of pixels in the image. 
; ------------------------------------------------------------------------------

(require 2htdp/image)


(define cat (bitmap "cat.png"))

; # of pixels in cat
(* (image-height cat) (image-width cat))
; => 8775