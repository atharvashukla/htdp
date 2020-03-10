#lang htdp/bsl

; Exercise 35.
; ------------
; Design the function string-last, which extracts the last character from a
; non-empty string. 
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

; NEString is a String expect ""

; NEString -> 1String
; last character of ne-str 
(define (string-last-stub ne-str)
  "s")

; last character of "kleene" is "e"
; last character of "hilbert" is "t"

(define (string-last-template ne-str)
  (... ne-str ...))

(define (string-last ne-str)
  (substring ne-str (sub1 (string-length ne-str))))

(check-expect (string-last "kleene") "e")
(check-expect (string-last "hilbert") "t")
