#lang htdp/bsl

; Exercise 30.
; ------------
;
; Define constants for the price optimization program at the movie theater
; so that the price sensitivity of attendance (15 people for every 10
; cents) becomes a computed constant.
;
; -----------------------------------------------------------------------------

; Constant Definitions
(define PERCENT-CHANGE  0.1)
(define PEOPLE-CHANGE   15)
(define BASE-POPULATION 120)
(define BASE-PRICE      5)

(define FIXED-COST      180)
(define VARIABLE-COST   0.04)

; The new constant:
(define PRICE-SENSITIVITY-OF-ATTENDANCE (/ PEOPLE-CHANGE PERCENT-CHANGE))

; Functions
(define (attendees ticket-price)
  (- BASE-POPULATION
     (* (- ticket-price BASE-PRICE)
        PRICE-SENSITIVITY-OF-ATTENDANCE)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))