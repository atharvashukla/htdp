#lang htdp/bsl

; Exercise 29.
; ------------
; After studying the costs of a show, the owner discovered several ways of
; lowering the cost. As a result of these improvements, there is no longer a
; fixed cost; a variable cost of $1.50 per attendee remains.
; 
; Modify both programs to reflect this change. When the programs are modified,
; test them again with ticket prices of $3, $4, and $5 and compare the results.
; -----------------------------------------------------------------------------

; Constant Definitions
(define PRICE-CHANGE    0.1)
(define PEOPLE-CHANGE   15)
(define BASE-POPULATION 120)
(define BASE-PRICE      5)

(define FIXED-COST      0) ; <= changed to 0
(define VARIABLE-COST   1.50)

; Functions
(define (attendees ticket-price)
  (- BASE-POPULATION
     (* (- ticket-price BASE-PRICE)
        (/ PEOPLE-CHANGE PRICE-CHANGE))))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (+ FIXED-COST (* VARIABLE-COST (attendees ticket-price))))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

(profit 3)
; => 630
(profit 4)
; => 675
(profit 5)
; => 420

(define (profit-ugly-version price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (+ 0
        (* 1.50
           (+ 120
              (* (/ 15 0.1)
                 (- 5.0 price)))))))


(profit-ugly-version 3)
; => 630
(profit-ugly-version 4)
; => 675
(profit-ugly-version 5)
; => 420