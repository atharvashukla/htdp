;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 297ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 297
;; ------------
;; Design the function distance-between. It consumes two numbers and a Posn: x,
;; y, and p. The function computes the distance between the points (x, y) and p.
;; -----------------------------------------------------------------------------


; Number Number Posn -> Number
; distance between p1 and p2

(check-within (distance-between 0 0 (make-posn 1 1)) (sqrt 2) 0.0001)

(define (distance-between x y p)
  (sqrt (+ (sqr (- x (posn-x p)))
           (sqr (- y (posn-y p))))))