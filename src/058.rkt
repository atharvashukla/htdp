#lang htdp/bsl

; Exercise 58.
; ------------
; Introduce constant definitions that separate the intervals for low prices and
; luxury prices from the others so that the legislators in Tax Land can easily
; raise the taxes even more.
; ------------------------------------------------------------------------------

#|
+-------------------------------------------+
| The Design Recipe Card                    |
|-------------------------------------------|
| From Problem Analysis to Data Definitions |
| Signature, Purpose Statement, Header      |
| Functional Examples                       | + One example per clause + bounds
| Function Template                         | + One cond clause per clause
| Function Definition                       |
| Testing                                   |
+-------------------------------------------+
|#


; A Price falls into one of three intervals: 
; — 0 through 1000
; — 1000 through 10000
; — 10000 and above.
; interpretation the price of an item

; Price -> Number
; computes the amount of tax charged for p
#;
(define (sales-tax p) 0)


#|
| 0 | 537 | 1000 | 1282 | 10000 | 12017 |
|---+-----+------+------+-------+-------|
| 0 |   0 |   50 |   64 |   800 |   961 |
|#

(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 12017) (* 0.08 12017))

(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 1282) (* 0.05 1282))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))

(define (sales-tax-temp p)
  (cond
    [(and (<= 0 p) (< p 1000)) ...]
    [(and (<= 1000 p) (< p 10000)) ...]
    [(>= p 10000) ...]))

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p 1000)) 0]
    [(and (<= 1000 p) (< p 10000)) (* 0.05 p)]
    [(>= p 10000) (* 0.08 p)]))
