;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 8ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 8.
;; -----------

;; Add the following line to the definitions area:

;;    (define cat <image of the cat>)

;; Create a conditional expression that computes whether the image is tall or
;; wide. An image should be labeled "tall" if its height is larger than or equal
;; to its width; otherwise it is "wide". See exercise 1 for how to create such
;; expressions in DrRacket; as you experiment, replace the cat with a rectangle
;; of your choice to ensure that you know the expected answer.

;; Now try the following modification. Create an expression that computes
;; whether a picture is "tall", "wide", or "square".

;; -----------------------------------------------------------------------------

(require 2htdp/image)

(define cat (bitmap "cat.png"))

(if (>= (image-height cat) (image-width cat))
    "tall"
    "wide")


(if (> (image-height cat) (image-width cat))
    "tall"
    (if (> (image-width cat) (image-height cat))
        "wide"
        "square"))