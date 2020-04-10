;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 415ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 415
;; ------------
;; ISL+ uses +inf.0 to deal with overflow. Determine the integer n such that
;;
;;    (expt #i10.0 n)
;; 
;; is an inexact number while (expt #i10. (+ n 1)) is approximated with +inf.0.
;; *Hint* Design a function to compute n.
;; -----------------------------------------------------------------------------



(define (get-max-num n)
  (if (and (inexact? (expt #i10.0 n)) (= (expt #i10.0 (+ n 1)) +inf.0))
      n
      (get-max-num (add1 n))))



(get-max-num 0)
; => 308