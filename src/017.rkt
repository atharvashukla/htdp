#lang htdp/bsl

; Exercise 17.
; ------------
; Define the function image-classify, which consumes an image and
; conditionally produces "tall" if the image is taller than wide, "wide" if it
; is wider than tall, or "square" if its width and height are the same. See
; exercise 8 for ideas. 
; ------------------------------------------------------------------------------

(require 2htdp/image)

(define (image-classify img)
  (if (> (image-height img) (image-width img))
      "tall"
      (if (> (image-width img) (image-height img))
          "wide"
          "square")))

(image-classify (rectangle 10 10 "solid" "black"))
; => "square"
(image-classify (rectangle 10 20 "solid" "black"))
; => "tall"
(image-classify (rectangle 20 10 "solid" "black"))
; => "wide"