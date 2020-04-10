;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 355ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))



#|
+-----------------------------------------------------------------------------+
| Exercise 355.                                                               |
| -------------                                                               |
| Design eval-var-lookup. This function has the same signature as             |
| eval-variable*:                                                             |
|                                                                             |
| ; BSL-var-expr AL -> Number                                                 |
| (define (eval-var-lookup e da) ...)                                         |
|                                                                             |
| Instead of using substitution, the function traverses the expression in the |
| manner that the design recipe for BSL-var-expr suggests. As it descends the |
| expression, it “carries along” da. When it encounters a symbol x, it uses   |
| assq to look up the value of x in the association list. If there is no      |
| value, eval-var-lookup signals an error.                                    |
+-----------------------------------------------------------------------------+
|#


; =============================================================================
; FROM EX 354

#|
+-----------------------------------------------------------------------------+
| Exercise 354.                                                               |
| -------------                                                               |
| Design eval-variable. The checked function consumes a BSL-var-expr and      |
| determines its value if numeric? yields true for the input. Otherwise it    |
| signals an error.                                                           |
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

(define WRONG "WRONG")

; ------------------------------------------------------------------------------
; EVAL EXRESSION FROM EX 347

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
(define (eval-expression bsl-expr)
  (cond
    [(number? bsl-expr) bsl-expr]
    [(add? bsl-expr) (+ (eval-expression (add-left bsl-expr)) (eval-expression (add-right bsl-expr)))]
    [(mul? bsl-expr) (* (eval-expression (mul-left bsl-expr)) (eval-expression (mul-right bsl-expr)))]))

; ------------------------------------------------------------------------------
; NUMERIC? FROM EX 347

;; BSL-var-expr -> BSL-var-expr
;; replaces all occurrences of x with v

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
    [(add? bsl-expr) (and (numeric? (add-left bsl-expr))
                          (numeric? (add-right bsl-expr)))]
    [(mul? bsl-expr) (and (numeric? (mul-left bsl-expr))
                          (numeric? (mul-right bsl-expr)))]))


; ------------------------------------------------------------------------------

(check-expect (eval-variable a1-sol) 0)
(check-expect (eval-variable a2-sol) 93)
(check-expect (eval-variable a3-sol) 47.1)
(check-expect (eval-variable b1) 1)
(check-expect (eval-variable b2) 39)
(check-expect (eval-variable b3) 21.98)
(check-error (eval-variable (make-add (make-mul 'c 23) (make-mul 1 23)))
             "WRONG")

;; BSL-var-expr -> Number
;; evaluates a numeric expression, throws error otherwise
(define (eval-variable ex)
  (if (numeric? ex)
      (eval-expression ex)
      (error WRONG)))


; -------------------------eval-variable*---------------------------------------

#|
+-----------------------------------------------------------------------------+
| Design eval-variable*. The function consumes a BSL-var-expr ex and an       |
| association list da. Starting from ex, it iteratively applies subst to all  |
| associations in da. If numeric? holds for the result, it determines its     |
| value; otherwise it signals the same error as eval-variable. Hint: Think of |
| the given BSL-var-expr as an atomic value and traverse the given            |
| association list instead. We provide this hint because the creation of this |
| function requires a little design knowledge from Simultaneous Processing.   |
+-----------------------------------------------------------------------------+
|#


; An AL (short for association list) is [List-of Association].
; An Association is a list of two items:
;   (cons Symbol (cons Number '())).

; ------------------------------------------------------------------------------
; SUBST FROM EX 352

;; BSL-var-expr -> BSL-var-expr
;; replaces all occurrences of x with v

(check-expect (subst (make-add 2 'x) 'x 3) (make-add 2 3))
(check-expect (subst (make-mul 2 'x) 'x 3) (make-mul 2 3))
(check-expect (subst (make-mul (make-add 'c 'c) (make-mul 'c 'c)) 'c 2)
              (make-mul (make-add 2 2) (make-mul 2 2)))
(check-expect (subst 2 'd 3) 2)

(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(and (symbol? ex) (symbol=? x ex)) v]
    [(and (symbol? ex) (not (symbol=? x ex))) ex]
    [(add? ex) (make-add (subst (add-left ex) x v)
                         (subst (add-right ex) x v))]
    [(mul? ex) (make-mul (subst (mul-left ex) x v)
                         (subst (mul-right ex) x v))]))

; ------------------------------------------------------------------------------

;; BSL-var-expr AL -> {Number | error}
;; evaluates if BSL-expr (numeric), error otherwise
(check-expect (eval-variable* (make-add 2 2) '((c 2))) 4)
(check-expect (eval-variable* (make-add 2 2) '()) 4)
(check-expect (eval-variable* (make-mul (make-add 'c 'c) (make-mul 'c 'c)) '((c 2))) 16)
(check-expect (eval-variable* (make-mul (make-add 'd 'c) (make-mul 'e 'c)) '((c 2) (d 2) (e 2))) 16)
(check-expect (eval-variable* (make-mul (make-mul (make-mul 'a  'b) 'c) 'a) '((a 3) (b 4) (c 7))) 252)
(check-error (eval-variable* (make-mul (make-mul (make-mul 'a  'b) 'c) 'a) '((a 3) (c 7))) "WRONG")
(check-error (eval-variable* (make-mul (make-mul (make-mul 'f  'b) 'c) 'a) '((a 3) (c 7))) "WRONG")


(define (eval-variable* ex da)
  (local ((define (get-numeric ex da)
            (cond
              [(empty? da) ex]
              [else (get-numeric (subst ex (first (first da)) (second (first da)))
                                 (rest da))])))
    (eval-variable (get-numeric ex da))))

; =============================================================================

; Same as the environment model from Exercise 354.

; BSL-var-expr AL -> Number
; evaluates the BSL-var-expr, replaces all vars by looking up da

(check-expect (eval-var-lookup (make-add 2 2) '((c 2)))
              (make-add 2 2))
(check-expect (eval-var-lookup (make-add 2 2) '())
              (make-add 2 2))
(check-expect (eval-var-lookup (make-mul (make-add 'c 'c) (make-mul 'c 'c)) '((c 2)))
              (make-mul (make-add 2 2) (make-mul 2 2)))
(check-expect (eval-var-lookup (make-mul (make-add 'd 'c) (make-mul 'e 'c)) '((c 2) (d 2) (e 2)))
              (make-mul (make-add 2 2) (make-mul 2 2)))
(check-expect (eval-var-lookup (make-mul (make-mul (make-mul 'a  'b) 'c) 'a) '((a 3) (b 4) (c 7)))
              (make-mul (make-mul (make-mul 3 4) 7) 3))
(check-error (eval-var-lookup (make-mul (make-mul (make-mul 'a  'b) 'c) 'a) '((a 3) (c 7)))
             "WRONG")
(check-error (eval-var-lookup (make-mul (make-mul (make-mul 'f  'b) 'c) 'a) '((a 3) (c 7)))
             "WRONG")

(define (eval-var-lookup ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (cons? (assq ex da)) (second (assq ex da)) (error WRONG))]
    [(add? ex) (make-add (eval-var-lookup (add-left ex) da) (eval-var-lookup (add-right ex) da))]
    [(mul? ex) (make-mul (eval-var-lookup (mul-left ex) da) (eval-var-lookup (mul-right ex) da))]))