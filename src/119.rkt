;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 119ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 119.
;; -------------
;; 
;; Consider the following sentences:
;; 
;; 1. (define (f "x") x)
;;
;; 2. (define (f x y z) (x))
;; 
;; Explain why they are syntactically illegal.
;;
;; -----------------------------------------------------------------------------

; 1. (define (f "x") x)
; the parameter position requires a variable, "x" is a value not a variable

; 2. (define (f x y z) (x))
; the body of the definition requires an expr, as seen in ex. 117(3) (x) isn't.


