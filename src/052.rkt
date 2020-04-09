#lang htdp/bsl

; Exercise 52
; ------------
; Which integers are contained in the four intervals above? 
; ------------------------------------------------------------------------------

(require 2htdp/image)

(bitmap "range1.png")
(bitmap "range2.png")
(bitmap "range3.png")
(bitmap "range4.png")

; [3,5] is a closed interval
; -> 3, 4, 5

; (3,5] is a left-open interval
; ->  4, 5

; [3,5) is a right-open interval
; -> 3, 4

; and (3,5) is an open interval
; -> 4
