;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 120ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 120.
;; -------------
;; 
;; Discriminate the legal from the illegal sentences:
;;
;; 1. (x)
;;
;; 2. (+ 1 (not x))
;; 
;; 3. (+ 1 2 3)
;;
;; Explain why the sentences are legal or illegal. Determine whether the legal
;; ones belong to the category expr or def. 
;; -----------------------------------------------------------------------------

; 1. (x)
; illegal as seen in Ex. 117 (3).

; 2. (+ 1 (not x))
; legal "expression"

; Proof:
; def-expr ...
; ==
; expr
; ==
; (primitive expr expr ...)
; ==
; (primitive value expr)
; ==
; (primitive value (primitive expr expr ...))
; ==
; (primitive value (primitive expr))
; ==
; (primitive value (primitive variable))
; ==
; (+ 1 (not x))


; 3. (+ 1 2 3)
; legal "expression"

; Proof:
; def-expr ...
; ==
; expr
; ==
; (primitive expr expr ...)
; ==
; (primitive value value value)
; ==
; (+ 1 2 3)