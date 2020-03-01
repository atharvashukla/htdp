;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |009|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;  Exercise 9.
;  -----------
;  Add the following line to the definitions area of DrRacket:
; 
;     (define in ...)
; 
;  Then create an expression that converts the value of in to a positive number.
;  For a String, it determines how long the String is; for an Image, it uses the
;  area; for a Number, it decrements the number by 1, unless it is already 0 or
;  negative; for #true it uses 10 and for #false 20.
; 
;  See exercise 1 for how to create expressions in DrRacket.
; 
;  -----------------------------------------------------------------------------

(require 2htdp/image)

(define in "abc")
; (define in (square 40 "solid" "red"))
; (define in 99)
; (define in 0)
; (define in -1)
; (define in #true)
; (define in #false)


; string?
; image?
; number?, zero?, negative?
; boolean?, false?

; converts `in` to a number
(if (string? in) 
    (string-length in)
    (if (image? in)
        (* (image-height in) (image-width in))
        (if (number? in)
            (if (or (zero? in) (negative? in))
                in
                (- in 1))
            (if (and (boolean? in) (false? in))
                20
                10))))