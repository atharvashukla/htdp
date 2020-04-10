;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 117ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 117.
;; -------------
;; 
;; Consider the following sentences:
;; 
;; 1. (3 + 4)
;; 
;; 2. number?
;; 
;; 3. (x)
;;
;; Explain why they are syntactically illegal.
;; 
;; -----------------------------------------------------------------------------


; 1. (3 + 4)
; only {cond, define, primitive, variable} can follow a paren. 3 isn't any.

; 2. number?
; number? is neither a definition nor a variable or a value. it's a prim. func.

; 3. (x)
; for all expressions that are enclosed within a paren, there are at least
; 2 or more subexpressions. Here we only have 1. 