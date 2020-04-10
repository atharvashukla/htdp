;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 243ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 243
;; ------------
;; Assume the definitions area in DrRacket contains
;;
;;    (define (f x)
;;      x)
;;
;; Identify the values among the following expressions:
;;
;;    (cons f '())
;;
;;    (f f)
;;
;;    (cons f (cons 10 (cons (f 10) '())))
;;
;; Explain why they're not values.
;;
;--------------------------------------------------------


(define (f x)
  x)

(cons f '())
; => (list function:f)

(f f)
; => function:f

(cons f (cons 10 (cons (f 10) '())))
; => (list function:f 10 10)

; They are all values because in ISL, functions are values.