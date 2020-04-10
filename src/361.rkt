;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 361ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 361
;; ------------
;; Design eval-all. Like eval-function* from exercise 359, this function
;; consumes the representation of an expression and a definitions area. It
;; produces the same value that DrRacket shows if the expression is entered at
;; the prompt in the interactions area and the definitions area contains the
;; appropriate definitions. Hint Your eval-all function should process variables
;; in the given expression like eval-var-lookup in exercise 355.
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

(define-struct condef [name body])
; BSL-con-def is a struct:
;   (make-condef Symbol BSL-expr)
; intepretation. representation of a BSL constant definition. 

(define-struct da [cdefs fdefs])
; A BSL-da-all is a structure
;   (make-da [List-of BSL-con-def)]
;            [List-of BSL-fun-def]
; interpretation. stores all the constant and function
; definitions (mimicking the definitions area of drracket)

; A BSL-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-expr BSL-expr)
; – (make-mul BSL-expr BSL-expr)
; - (make-fun Symbol BSL-expr)
; interpretation. representation of a bsl expressions

; BSL-value is a Number
; interpretation. possible values that a bsl interpreter can produce.

(define WRONG "WRONG")

;; -----------------------------------------------------------------------------

; (define (f x) (+ 3 x))
(define f (make-fundef 'f 'x (make-add 3 'x)))

; (define (g y) (f (* 2 y)))
(define g (make-fundef 'g 'y (make-fun 'f (make-mul 2 'y))))

; (define (h v) (+ (f v) (g v)))
(define h (make-fundef 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

; (define I (* 3 4))
(define I (make-condef 'I (make-mul 3 4)))

; (define J (f 4))
(define J (make-condef 'J (make-fun 'f 4)))

(define da-ex (make-da (list I J) (list f g h)))

;; -----------------------------------------------------------------------------

; BSL-da-all Symbol BSL-con-def
; checks da for a constant definition with name x

(check-expect (lookup-con-def da-ex 'I) I)
(check-expect (lookup-con-def da-ex 'J) J)
(check-error (lookup-con-def da-ex 'K))

(define (lookup-con-def da x)
  (local ((define con-list (da-cdefs da))
          (define lookd (filter (λ (c) (equal? (condef-name c) x)) con-list)))
    (if (empty? lookd)
        (error WRONG)
        (first lookd))))

; BSL-da-all Symbol -> BSL-fun-def
; checks da for a function definition with name f

(check-expect (lookup-fun-def da-ex 'f) f)
(check-expect (lookup-fun-def da-ex 'g) g)
(check-error (lookup-fun-def da-ex 'e))

(define (lookup-fun-def da f)
  (local ((define fun-list (da-fdefs da))
          (define lookd (filter (λ (fun) (equal? f (fundef-name fun))) fun-list)))
    (if (empty? lookd)
        (error WRONG)
        (first lookd))))

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

; BSL-expr BSL-da-all -> BSL-value
; evalueates BSL-fun-expr ex with da in the definitions area

(define bsl-exp1 (make-mul 4 (make-add 3 (make-fun 'f (make-mul (make-add 1 2) (make-add 3 4))))))
; (* 4 (+ 3 (f (* (+ 1 2) (+ 3 4))))) => 108
(define bsl-exp2 (make-mul 4 (make-add 3 (make-fun 'g (make-mul (make-add 1 2) (make-add 3 4))))))
; (* 4 (+ 3 (g (* (+ 1 2) (+ 3 4))))) => 192
(define bsl-exp3 (make-mul 'I (make-add 3 (make-fun 'h (make-mul (make-add 1 2) (make-add 3 4))))))
; (* 12 (+ 3 (h (* (+ 1 2) (+ 3 4))))) => 864

(check-expect (eval-all bsl-exp1 da-ex) 108)
(check-expect (eval-all bsl-exp2 da-ex) 192)
(check-expect (eval-all bsl-exp3 da-ex) 864)

(define (eval-all ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (eval-all (condef-body (lookup-con-def da ex)) da)]
    [(add? ex) (+ (eval-all (add-left ex) da) (eval-all (add-right ex) da))]
    [(mul? ex) (* (eval-all (mul-left ex) da) (eval-all (mul-right ex) da))]
    [(fun? ex)
     (local ((define arg (fun-expression ex))
             (define value (eval-all arg da))
             (define lookd-def (lookup-fun-def da (fun-name ex)))
             (define plugd (subst (fundef-body lookd-def) (fundef-param lookd-def) value)))
       (eval-all plugd da))]))

;; -----------------------------------------------------------------------------

