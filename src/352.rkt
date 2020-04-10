;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 352ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 352.                                                               |
| -------------                                                               |
| Design subst. The function consumes a BSL-var-expr ex, a Symbol x, and a    |
| Number v. It produces a BSL-var-expr like ex with all occurrences of x      |
| replaced by v.                                                              |
+-----------------------------------------------------------------------------+
|#


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
(define (subst ex x v)
  0)

#;
(define (bsl-expr-temp bsl-expr)
  (cond
    [(number? bsl-expr) ...]
    [(symbol? bsl-expr) ...]
    [(add? bsl-expr) (... (bsl-expr-temp (add-left bsl-expr)) ... (bsl-expr-temp (add-right bsl-expr))...)]
    [(mul? bsl-expr) (... (bsl-expr-temp (mul-left bsl-expr)) ... (bsl-expr-temp (mul-right bsl-expr))...)]))

(check-expect (subst (make-add 2 'x) 'x 3) (make-add 2 3))
(check-expect (subst (make-mul 2 'x) 'x 3) (make-mul 2 3))
(check-expect (subst (make-mul (make-add 'c 'c) (make-mul 'c 'c)) 'c 2)
              (make-mul (make-add 2 2) (make-mul 2 2)))
(check-expect (subst 2 'd 3) 2)
(check-expect (subst 'd 'f 3) 'd)

(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? x ex) v ex)]
    [(add? ex) (make-add (subst (add-left ex) x v) (subst (add-right ex) x v))]
    [(mul? ex) (make-mul (subst (mul-left ex) x v) (subst (mul-right ex) x v))]))