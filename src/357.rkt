;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 357ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 357.                                                               |
| -------------                                                               |
|                                                                             |
| Design eval-definition1. The function consumes four arguments:              |
|                                                                             |
| 1. a BSL-fun-expr ex;                                                       |
| 2. a symbol f, which represents a function name;                            |
| 3. a symbol x, which represents the functions’s parameter; and              |
| 4. a BSL-fun-expr b, which represents the function’s body.                  |
|                                                                             |
| It determines the value of ex. When eval-definition1 encounters an          |
| application of f to some argument, it                                       |
|                                                                             |
| 1. evaluates the argument,                                                  |
| 2. substitutes the value of the argument for x in b; and                    |
| 3. finally evaluates the resulting expression with eval-definition1.        |
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

(define WRONG "WRONG")

; ---- SUBST from Ex 352 updated with fun? case -----


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


; ------

;; eval-definition1 : evaluates ex with func f with param x and body b
;; BSL-fun-expr Symbol Symbol BSL-fun-expr -> Number

(check-expect (eval-definition1 (make-fun 'f 3) 'f 'x (make-add 7 (make-mul 'x 'x))) 16)
(check-error (eval-definition1 (make-fun 'g 0) 'f 'x (make-add 'x 'x)))
(check-expect (eval-definition1 (make-fun 'g 0) 'g 'x (make-add 'x 'x)) 0)
(check-expect (eval-definition1 (make-fun 'g (make-add 2 3)) 'g 'x 0) 0)
(check-expect (eval-definition1 (make-fun 'g (make-add 2 3)) 'g 'x (make-mul 3 'x)) 15)

#;
(define (eval-definition1 ex f x b)
  ...)

#;; steps as code:
(local ((define value (eval-definition1 arg f x b))
        (define plugd (subst b x value)))
  (eval-definition1 plugd f x b))

(define  (eval-definition1 ex f x b)
  (cond
    [(number? ex) ex]
    [(add? ex) (+ (eval-definition1 (add-left ex) f x b) (eval-definition1 (add-right ex) f x b))]
    [(mul? ex) (* (eval-definition1 (mul-left ex) f x b) (eval-definition1 (mul-right ex) f x b))]
    [(fun? ex)
     (if (equal? (fun-name ex) f) ; does the encounter function name match?
         (local ((define arg (fun-expression ex))
                 (define value (eval-definition1 arg f x b)) ; evaluate the argument, then
                 (define plugd (subst b x value))) ; subst the body of the func with evalled arg, then
           (eval-definition1 plugd f x b)) ; evaluate beta-vd result
         (error WRONG))]))