;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |017|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 17.
; ------------
;
; Define the function image-classify, which consumes an image and
; conditionally produces "tall" if the image is taller than wide, "wide" if it
; is wider than tall, or "square" if its width and height are the same. See
; exercise 8 for ideas. 
;
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