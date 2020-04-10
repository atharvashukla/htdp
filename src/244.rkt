;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 244ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 244
;; ------------
;; Argue why the following sentences are now legal:
;;
;;    (define (f1 x) (x 10))
;;
;;    (define (f2 x) (x f2)) ; how is this lega??
;;
;;    (define (f3 x y) (x 'a y 'b))
;;
;; Explain your reasoning.
;; -----------------------------------------------------------------------------

; ---

(define (f1 x) (x 10))

(check-expect (f1 identity) 10)
(check-expect (f1 odd?) #false)

; ---

(define (f2 x) (x f2))
; x can just be a function that consumes a function (e.g. f2)

; ---

(define (f3 x y) (x 'a y 'b))
(check-expect (f3 list 'c) (list 'a 'c 'b))

; ---