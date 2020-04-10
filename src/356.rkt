;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 356ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 356.                                                               |
| -------------                                                               |
| Extend the data representation of Interpreting Variables to include the     |
| application of a programmer-defined function. Recall that a function        |
| application consists of two pieces: a name and an expression. The former    |
| is the name of the function that is applied; the latter is the argument.    |
|                                                                             |
| Represent these expressions: (k (+ 1 1)), (* 5 (k (+ 1 1))),                |
| (* (i 5) (k (+ 1 1))). We refer to this newly defined class of data as      |
| BSL-fun-expr.                                                               |
+-----------------------------------------------------------------------------+
|#

(define-struct add [left right])
; An Add is a Structure:
;  (make-add BSL-fun-expr BSL-fun-expr)
; interpretation. (make-add BSL-fun-expr BSL-fun-expr) shows
; the addition of two BSL-expr

(define-struct mul [left right])
; A Mul is a structure:
;  (make-mul BSL-fun-expr BSL-fun-expr)
; interpretation (make-mul BSL-fun-expr BSL-fun-expr) shows
; the multiplication of two BSL-expr

(define-struct fun [name expression])
; A Fun is a Structure:
;  (make-fun Symbol BSL-fun-expr)
; interpretation. (make-fun Symbol BSL-fun-expr) represents
; a function in BSL.

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expression BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expression)


(define ex-fun-1 (make-fun 'k (make-add 1 1)))
(define ex-fun-2-rep (make-mul 5 (make-fun 'k (make-add 1 1))))
(define ex-fun-3-rep (make-mul (make-fun 'i 5) (make-fun 'k (make-add 1 1))))