#lang htdp/bsl

; Exercise 14.
; ------------
;
; Define the function string-last, which extracts the last 1String from a
; non-empty string. 
;
; ------------------------------------------------------------------------------

; version 1:

(define (string-last str)
  (string-ith str (sub1 (string-length str))))

; version 2:

(define (string-last.v2 str)
  (substring str 0 (- (string-length str) 1)))
