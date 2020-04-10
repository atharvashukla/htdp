;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 353ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 353.                                                               |
| -------------                                                               |
| Design the numeric? function. It determines whether a BSL-var-expr is also  |
| a BSL-expr. Here we assume that your solution to exercise 345 is the        |
| definition for BSL-var-expr without Symbols.                                |
+-----------------------------------------------------------------------------+
|#

;; BSL-var-exp -> Boolean
;; is ex a BSL-exp?
#;
(define (numeric? ex)
  #false)

(define-struct add [left right])
; An Add is a Structure:
;  (make-add BSL-var-expr BSL-var-expr)
; interpretation. (make-add BSL-var-expr BSL-var-expr) shows
; the addition of two BSL-expr

(define-struct mul [left right])
; A Mul is a structure:
;  (make-mul BSL-var-expr BSL-var-expr)
; interpretation (make-mul BSL-var-expr BSL-var-expr) shows
; the multiplication of two BSL-expr


; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)


;; BSL-var-expr -> BSL-var-expr
;; replaces all occurrences of x with v
#;
(define (bsl-expr-temp bsl-expr)
  (cond
    [(number? bsl-expr) ...]
    [(symbol? bsl-expr) ...]
    [(add? bsl-expr) (... (bsl-expr-temp (add-left bsl-expr)) ... (bsl-expr-temp (add-right bsl-expr))...)]
    [(mul? bsl-expr) (... (bsl-expr-temp (mul-left bsl-expr)) ... (bsl-expr-temp (mul-right bsl-expr))...)]))


(check-expect (numeric? 1) #true)
(check-expect (numeric? 'v) #false)
(check-expect (numeric? (make-add 1 23)) #true)
(check-expect (numeric? (make-mul 1 23)) #true)
(check-expect (numeric? (make-mul 1 'c)) #false)
(check-expect (numeric? (make-add (make-mul 1 23) (make-mul 1 23))) #true)
(check-expect (numeric? (make-add (make-mul 'c 23) (make-mul 1 23))) #false)

(define (numeric? bsl-expr)
  (cond
    [(number? bsl-expr) #true]
    [(symbol? bsl-expr) #false]
    [(add? bsl-expr) (and (numeric? (add-left bsl-expr)) (numeric? (add-right bsl-expr)))]
    [(mul? bsl-expr) (and (numeric? (mul-left bsl-expr)) (numeric? (mul-right bsl-expr)))]))