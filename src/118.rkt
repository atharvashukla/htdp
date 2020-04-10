;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 118ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 118.
;; -------------
;; 
;; Take a look at the following sentences:
;;
;; 1. (define (f x) x)
;;
;; 2. (define (f x) y)
;; 
;; 3. (define (f x y) 3)
;;
;; Explain why they are syntactically legal definitions
;;
;; -----------------------------------------------------------------------------


; 1. (define (f x) x)
; (define (variable variable variable ...) expr)
; where
; the first variable is f
; the second variable is x
; and 0 of the `variable ...` are used.
; the expr is x

; 2. (define (f x) y)
; same as 1. except the body `expr` is `y`

; 3. (define (f x y) 3)
; same as 2. and 3. except
; `y` is used for the `variable ...` part and
; the value, `3`, is used for the body expr