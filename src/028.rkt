#lang htdp/bsl

; Exercise 28.
; ------------
; Determine the potential profit for these ticket prices: $1, $2, $3, $4, and
; $5. Which price maximizes the profit of the movie theater? Determine the best
; ticket price to a dime.
; ------------------------------------------------------------------------------

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


(profit 1)
; => 511.2
(profit 2)
; => 937.2
(profit 3)
; => 1063.2
(profit 4)
; => 889.2
(profit 5)
; => 415.2

(profit 2.8)
; => 1062
(profit 2.9)
; => 1064.1 ; <- the best price is 2.9
(profit 3.0)
; => 1063.2
(profit 3.1)
; => 1059.3
(profit 3.2)
; => 1052.4