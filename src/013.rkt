#lang htdp/bsl

; Exercise 13.
; ------------
;
; Define the function string-first, which extracts the first 1String from a
; non-empty string. 
;
; ----------------------------------------------------------------------------

; version 1:

(define (string-first str)
  (string-ith str 0))

; version 2:

(define (string-first.v2 str)
  (substring str 0 1))