#lang htdp/bsl

; Exercise 37.
; ------------
; Design the function string-rest, which produces a string like the given one
; with the first character removed. 
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

; NEString is a String except ""

; NEString -> String
; removes the first character of ne-str
(define (string-rest-stub ne-str)
  "")

(define (string-rest-template ne-str)
  (... ne-str ...))

; string-rest of "abc" is "bc"
; string-rest of "a" is ""

(define (string-rest ne-str)
  (substring ne-str 1))

(check-expect (string-rest "abc") "bc")
(check-expect (string-rest "a") "")
