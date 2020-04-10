;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 347ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-------------------------------------------------------------------------+
| Exercise 347.                                                           |
| -------------                                                           |
| Design eval-expression. The function consumes a representation of a BSL |
| expression and computes its value.                                      |
+-------------------------------------------------------------------------+
|#

(define-struct add [left right])
; An Add is a Structure:
;  (make-add BSL-expr BSL-expr)
; interpretation. (make-add BSL-expr BSL-expr) shows
; the addition of two BSL-expr

(define-struct mul [left right])
; A Mul is a structure:
;  (make-mul BSL-expr BSL-expr)
; interpretation (make-mul BSL-expr BSL-expr) shows
; the multiplication of two BSL-expr

;; BSL-expr is one of
;; - Number
;; - (make-add BSL-expr BSL-expr)
;; - (make-mul BSL-expr BSL-expr)
;; interpretation. represents an addition/multiplication
;; of two numbers in Beginning Student Language


(define a1 (+ 10 -10))
(define a1-sol (make-add 10 -10))

(define a2 (+ (* 20 3) 33))
(define a2-sol (make-add (make-mul 20 3) 33))

(define a3 (+ (* 3.14 (* 2 3)) (* 3.14 (* -1 -9))))
(define a3-sol (make-add (make-mul 3.14 (make-mul 2 3)) (make-mul 3.14 (make-mul -1 -9))))

(define b1 (make-add -1 2))
(define b1-sol (+ -1 2))

(define b2 (make-add (make-mul -2 -3) 33))
(define b2-sol (+ (* -2 -3) 33))

(define b3 (make-mul (make-add 1 (make-mul 2 3)) 3.14))
(define b3-sol (* (+ 1 (* 2 3)) 3.14))

;; BSL-expr -> Number
;; evaluates the BSL-expr
#;
(define (eval-expr bsl-expr)
  0)

(check-expect (eval-expression a1-sol) 0)
(check-expect (eval-expression a2-sol) 93)
(check-expect (eval-expression a3-sol) 47.1)
(check-expect (eval-expression b1) 1)
(check-expect (eval-expression b2) 39)
(check-expect (eval-expression b3) 21.98)

#;
(define (bsl-expr-temp bsl-expr)
  (cond
    [(number? bsl-expr) bsl-expr]
    [(add? bsl-expr) (... (bsl-expr-temp (add-left bsl-expr)) ... (bsl-expr-temp (add-right bsl-expr))...)]
    [(mul? bsl-expr) (... (bsl-expr-temp (mul-left bsl-expr)) ... (bsl-expr-temp (mul-right bsl-expr))...)]))

(define (eval-expression bsl-expr)
  (cond
    [(number? bsl-expr) bsl-expr]
    [(add? bsl-expr) (+ (eval-expression (add-left bsl-expr)) (eval-expression (add-right bsl-expr)))]
    [(mul? bsl-expr) (* (eval-expression (mul-left bsl-expr)) (eval-expression (mul-right bsl-expr)))]))