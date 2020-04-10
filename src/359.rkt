;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 359ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 359
;; ------------
;; Design eval-function*. The function consumes ex, a BSL-fun-expr, and da, a
;; BSL-fun-def* representation of a definitions area. It produces the result
;; that DrRacket shows if you evaluate ex in the interactions area, assuming the
;; definitions area contains da.
;;
;; The function works like eval-definition1 from exercise 357. For an
;; application of some function f, it
;;
;; 1. evaluates the argument;
;; 2. looks up the definition of f in the BSL-fun-def representation of da,
;;    which comes with a parameter and a body;
;; 3. substitutes the value of the argument for the function parameter in the
;;    function’s body; and
;; 4. evaluates the new expression via recursion.
;;
;; Like DrRacket, eval-function* signals an error when it encounters a variable
;; or function name without definition in the definitions area. 
;; -----------------------------------------------------------------------------

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

(define-struct fundef [name param body])
; BSL-fun-def is a struct:
;   (make-fundef Symbol Symbol BSL-expr)
; interpretation. representation of a BSL function definition


; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expression BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expression)
; - (make-fundef Symbol Symbol BSL-fun-expr)
; interpretation. representation of a bsl expression

; (define (f x) (+ 3 x))
(define f (make-fundef 'f 'x (make-add 3 'x)))

; (define (g y) (f (* 2 y)))
(define g (make-fundef 'g 'y (make-fun 'f (make-mul 2 'y))))

; (define (h v) (+ (f v) (g v)))
(define h (make-fundef 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

; BSL-fun-def* is a [List-of BSL-fun-def]
; interpretation. represents a definition area with multiple
; one argument function definitions

; BSL-value is a Number
; interpretation. possible values that a bsl interpreter can produce.

(define da-fgh (list f g h))

(define WRONG "WRONG")

;; -----------------------------------------------------------------------------


; BSL-fun-expr BSL-fun-def* -> BSL-value
; evalueates BSL-fun-expr ex with da in the definitions area

(define bsl-exp1 (make-mul 4 (make-add 3 (make-fun 'f (make-mul (make-add 1 2) (make-add 3 4))))))
; (* 4 (+ 3 (f (* (+ 1 2) (+ 3 4))))) => 108
(define bsl-exp2 (make-mul 4 (make-add 3 (make-fun 'g (make-mul (make-add 1 2) (make-add 3 4))))))
; (* 4 (+ 3 (g (* (+ 1 2) (+ 3 4))))) => 192
(define bsl-exp3 (make-mul 4 (make-add 3 (make-fun 'h (make-mul (make-add 1 2) (make-add 3 4))))))
; (* 4 (+ 3 (h (* (+ 1 2) (+ 3 4))))) => 288

(check-expect (eval-function* bsl-exp1 da-fgh) 108)
(check-expect (eval-function* bsl-exp2 da-fgh) 192)
(check-expect (eval-function* bsl-exp3 da-fgh) 288)

(define (eval-function* ex da)
  (cond
    [(number? ex) ex]
    [(add? ex) (+ (eval-function* (add-left ex) da) (eval-function* (add-right ex) da))]
    [(mul? ex) (* (eval-function* (mul-left ex) da) (eval-function* (mul-right ex) da))]
    [(fun? ex)
     (local ((define arg (fun-expression ex))
             (define value (eval-function* arg da))
             (define lookd-def (lookup-def da (fun-name ex)))
             (define plugd (subst (fundef-body lookd-def) (fundef-param lookd-def) value)))
       (eval-function* plugd da))]))


;; -----------------------------------------------------------------------------

;; BSL-var-expr -> BSL-var-expr
;; replaces all occurrences of x with v

(check-expect (subst (make-add 2 'x) 'x 3) (make-add 2 3))
(check-expect (subst (make-mul 2 'x) 'x 3) (make-mul 2 3))
(check-expect (subst (make-mul (make-add 'c 'c) (make-mul 'c 'c)) 'c 2)
              (make-mul (make-add 2 2) (make-mul 2 2)))
(check-expect (subst 2 'd 3) 2)
(check-expect (subst 'e 'd 3) 'e)
(check-expect (subst (make-fun 'f (make-mul 2 'x)) 'x 4) (make-fun 'f (make-mul 2 4)))

(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? x ex) v ex)]
    [(add? ex) (make-add (subst (add-left ex) x v) (subst (add-right ex) x v))]
    [(mul? ex) (make-mul (subst (mul-left ex) x v) (subst (mul-right ex) x v))]
    [(fun? ex) (make-fun (fun-name ex) (subst (fun-expression ex) x v))]))


;; -----------------------------------------------------------------------------

; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da
; signals an error if there is none

(check-expect (lookup-def da-fgh 'g) g) 
(check-error (lookup-def da-fgh 'k))

(define (lookup-def da f)
  (local ((define lookd (filter (λ (fun) (equal? (fundef-name fun) f)) da)))
    (if (empty? lookd)
        (error WRONG)
        (first lookd))))