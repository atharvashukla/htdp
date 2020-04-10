;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 185ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 185
;; ------------
;;
;; You know about first and rest from BSL, but BSL+ comes with even more
;; selectors than that. Determine the values of the following expressions:
;;
;;    1. (first (list 1 2 3))
;;    
;;    2. (rest (list 1 2 3))
;;    
;;    3. (second (list 1 2 3))
;;
;; Find out from the documentation whether third and fourth exist.
;;
;; -----------------------------------------------------------------------------


; Expressions
(define one-exp (first (list 1 2 3)))

(define two-exp (rest (list 1 2 3)))

(define three-exp (second (list 1 2 3)))

; Eval
(define one-eval 1)

(define two-eval (list 2 3))

(define three-eval 2)

; Tests
(check-expect one-exp one-eval)

(check-expect two-exp two-eval)

(check-expect three-exp three-eval)