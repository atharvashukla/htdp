#lang htdp/bsl

; Exercise 27.
; ------------
;
; Our solution to the sample problem contains several constants in the middle
; of functions. As One Program, Many Definitions already points out, it is best
; to give names to such constants so that future readers understand where these
; numbers come from. Collect all definitions in DrRacket’s definitions area and
; change them so that all magic numbers are refactored into constant
; definitions.
;
; -----------------------------------------------------------------------------


; Constant Definitions
(define PERCENT-CHANGE  0.1)
(define PEOPLE-CHANGE   15)
(define BASE-POPULATION 120)
(define BASE-PRICE      5)

(define FIXED-COST      180)
(define VARIABLE-COST   0.04)

; Functions
(define (attendees ticket-price)
  (- BASE-POPULATION
     (* (- ticket-price BASE-PRICE)
        (/ PEOPLE-CHANGE PERCENT-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))