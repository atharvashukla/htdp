#lang htdp/bsl

; Exercise 34.
; ------------
; Design the function string-first, which extracts the first character from a
; non-empty string. Don’t worry about empty strings. 
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

; NEString is a String but not ""

; NEString -> 1String
; first character of ne-str
(define (string-first-stub ne-str)
  "s")

; first character of "kleene" is "k"
; first character of "hoare" is "h"

(define (string-first-template ne-str)
  (... ne-str ...))

(define (string-first ne-str)
  (substring ne-str 0 1))

(check-expect (string-first "kleene") "k")
(check-expect (string-first "hoare") "h")
