;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 305ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 305.
;; ------------
;; Use loops to define convert-euro. See exercise 267.
;; -----------------------------------------------------------------------------

(require 2htdp/abstraction)

;; (List-of Number) -> (List-of Number)
;; Converts a list of USD to Euro at rate: 1.06
(check-expect (convert-euro '()) '())
(check-expect (convert-euro '(100 10)) '(106 10.6))
(check-expect (convert-euro '(100 10 0)) '(106 10.6 0))
(check-expect (convert-euro '(100 10 0 50)) '(106 10.6 0 53))

(define (convert-euro lo-usd)
  (local (;; Number -> Number
          ;; Converts a USD value to a EUR value
          ;; at the rate: 1.06
          (define (usd2eur usd)
            (* usd 1.06)))
    (for/list ((usd lo-usd))
      (usd2eur usd))))