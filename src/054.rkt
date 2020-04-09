#lang htdp/bsl

; Exercise 54.
; ------------
; Why is (string=? "resting" x) incorrect as the first condition in show?
; Conversely, formulate a completely accurate condition, that is, a Boolean
; expression that evaluates to #true precisely when x belongs to the first
; sub-class of LRCD.
; ------------------------------------------------------------------------------


; (string? x) would evaluate to #true for any string, not just "resting"
; (string=? "resting" x) would error if x is not a string

#;; Version 1
(equal? x "resting")

#;; Version 2
(and (string? x) (string=? x "resting"))

; Version 2 is better.
