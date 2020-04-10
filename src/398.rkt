;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 398ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 398
;; ------------
;; A linear combination is the sum of many linear terms, that is, products of
;; variables and numbers. The latter are called coefficients in this context.
;; Here are some examples:
;;
;;        5 * x          5 * x + 17 * y        5 * x + 17 * y + 3 * z
;;
;; In all examples, the coefficient of x is 5, that of y is 17, and the one for
;; z is 3.
;;
;; If we are given values for variables, we can determine the value of a
;; polynomial. For example, if x = 10, the value of 5 * x is 50; if x = 10 and
;; y = 1, the value of 5 * x + 17 * y is 67; and if x = 10, y = 1, and z = 2,
;; the value of 5 * x + 17 * y + 3 * z is 73.
;;
;; There are many different representations of linear combinations. We could,
;; for example, represent them with functions. An alternative representation
;; is a list of its coefficients. The above combinations would be represented
;; as:
;;
;;    (list 5)
;;    (list 5 17)
;;    (list 5 17 3)
;;
;; This choice of representation assumes a fixed order of variables.
;;
;; Design value. The function consumes two equally long lists: a linear
;; combination and a list of variable values. It produces the value of the
;; combination for these values. 
;; -----------------------------------------------------------------------------

; [List-of Number] [List-of Number] -> Number
; value of the linear-comb for var-vals variables

(check-expect (value (list 1 2 3) (list 2 5 3)) 21)

#;
(define (value linear-comb var-vals)
  0)

#;
(define (value linear-comb var-vals)
  (cond
    [(empty? linear-comb) ...]
    [else (... (first linear-comb) ... (rest linear-comb))]))

#;
(define (value linear-comb var-vals)
  (cond 
    [(empty? linear-comb) 0]
    [else (+ (* (first linear-comb) (first var-vals))
             (value (rest linear-comb) (rest var-vals)))]))


(define (value linear-comb var-vals)
  (foldr (λ (l v r) (+ (* l v) r)) 0 linear-comb  var-vals))