#lang htdp/bsl

; Exercise 21.
; ------------
; Use DrRacket’s stepper to evaluate (ff (ff 1)) step-by-step.
; Also try (+ (ff 1) (ff 1)). Does DrRacket’s stepper reuse the results of
; computations?
; -----------------------------------------------------------------------------

(define (ff x) (* 10 x))

(ff (ff 1))
; ==
(ff (* 10 1))
; ==
(ff 10)
; ==
(* 10 10)
; ==
100


(+ (ff 1) (ff 1))
; ==
(+ (* 10 1) (ff 1))
; ==
(+ 10 (ff 1))
; ==
(+ 10 (* 10 1))
; ==
(+ 10 10)
; ==
20