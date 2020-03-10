#lang htdp/bsl

; Exercise 25.
; ------------
; Take a look at this attempt to solve exercise 17:
;
;    (define (image-classify img)
;      (cond
;        [(>= (image-height img) (image-width img)) "tall"]
;        [(= (image-height img) (image-width img)) "square"]
;        [(<= (image-height img) (image-width img)) "wide"]))
;
; Does stepping through an application suggest a fix?
; ------------------------------------------------------------------------------

(require 2htdp/image)

(define (image-classify img)
  (cond
    [(>= (image-height img) (image-width img)) "tall"]
    [(= (image-height img) (image-width img)) "square"]
    [(<= (image-height img) (image-width img)) "wide"]))


(image-classify (square 20 "solid" "red"))

; Yes, the `>=` condition in the first clause
; should be `>` only, otherwise the dimensions of the
; square would compute to "tall" instead of "square"