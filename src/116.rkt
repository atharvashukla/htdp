;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 116ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 116.
;; -------------
;; Take a look at the following sentences:
;; 
;; 1. x
;; 
;; 2. (= y z)
;; 
;; 3. (= (= y z) 0)
;; 
;; Explain why they are syntactically legal expressions 
;; -----------------------------------------------------------------------------

; 1.
; def-expr ...
; ==
; expr
; ==
; variable
; ==
; x


; 2.
; def-expr ...
; ==
; expr
; ==
; (primitive expr expr ...)
; ==
; (= y z) {using 1. for to show y and z are variable}


; 3.
; 
; using 2 for the outermost expression, and using 2 again
; for the left subexpression. 0 is a value which is an expr.
; 
; (= (= y z) 0)



