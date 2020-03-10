#lang htdp/bsl

; Exercise 38.
; ------------
; Design the function string-remove-last, which produces a string like the
; given one with the last character removed. 
; ------------------------------------------------------------------------------

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


; NEString is a String except ""


; NEString -> String
; removes the last character of ne-str
(define (string-remove-last-stub ne-str)
  "")

; string-remove-last of "abc" is "ab"
; string-remove-last of "a" is ""

(define (string-remove-last-template ne-str)
  (... ne-str ...))

(define (string-remove-last ne-str)
  (substring ne-str 0 (sub1 (string-length ne-str))))

(check-expect (string-remove-last "abc") "ab")
(check-expect (string-remove-last "a") "")

