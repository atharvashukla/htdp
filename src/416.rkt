;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 416ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 416
;; ------------
;; ISL+ uses #i0.0 to approximate underflow. Determine the smallest integer n
;; such that (expt #i10.0 n) is still an inexact ISL+ number and (expt #i10.
;; (- n 1)) is approximated with 0. Hint Use a function to compute n. Consider
;; abstracting over this function and the solution of exercise 415.
;; -----------------------------------------------------------------------------

; Number -> Number
; starts with n and finds the last number that
; produces a non infinity value for (expt 10 n)
(define (get-min-num n)
  (if (and (inexact? (expt #i10.0 n)) (= (expt #i10.0 (- n 1)) 0))
      n
      (get-min-num (sub1 n))))

(get-min-num 0)
; => -323


;; -----------------------------------------------------------------------------
;; Abstracting:

; Number -> Number
; searches for number last inexact number
; such that (= (expt #i10.0 n) val), applies
; op to find the next number in the sequence
(define (get-num n val op)
  (if (and (inexact? (expt #i10.0 n))
           (= (expt #i10.0 (op n 1)) val))
      n
      (get-num (op n 1) val op)))



(check-expect (get-max-num.v2 0) 308)

; Number -> Number
; max no-overflow numebr
(define (get-max-num.v2 n)
  (get-num n +inf.0 +))


(check-expect (get-min-num.v2 0) -323)

; Number -> Number
; max no-underflow numebr
(define (get-min-num.v2 n)
  (get-num n 0 -))

