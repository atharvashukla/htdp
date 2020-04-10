;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 362ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 362
;; ------------
;; It is cumbersome to enter the structure-based data representation of BSL
;; expressions and a definitions area. As the end of Interpreting Expressions
;; demonstrates, it is much easier to quote expressions and (lists of)
;; definitions.

;; Design a function interpreter. It consumes an S-expr and an Sl. The former
;; is supposed to represent an expression and the latter a list of definitions.
;; The function parses both with the appropriate parsing functions and then uses
;; eval-all from exercise 361 to evaluate the expression. Hint You must adapt
;; the ideas of exercise 350 to create a parser for definitions and lists of
;; definitions.

;; You should know that eval-all-sexpr makes it straightforward to check whether
;; it really mimics DrRacket’s evaluator.
;; -----------------------------------------------------------------------------

; A BSL-expr is one of: 
; – Number
; – Symbol 
; – (list '+ BSL-expr BSL-expr)
; – (list '* BSL-expr BSL-expr)
; - (list Symbol BSL-expr)
; interpretation. representation of a bsl expressions

; BSL-value is a Number
; interpretation. possible values that a bsl interpreter can produce.

; BSL-def is one of:
; - BSL-con-def is (list 'define Symbol BSL-expr)
; - BSL-fun-def is (list 'define (list Symbol Symbol) BSL-expr)
; interpretation. BSL definitions 

; BSL-da-all is [List-of BSL-def]
; interpretation. all definitions in the definitions area.

; interpreter : BSL-expr BSL-da-all -> BSL-value
; parser : S-expr -> BSL-expr

(define WRONG "WRONG")

;; -----------------------------------------------------------------------------

(require 2htdp/abstraction)

; BSL-expr Symbol BSL-value -> BSL-expr
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? x ex) v ex)]
    [(symbol=? (first ex) '+) (list '+ (subst (second ex) x v) (subst (third ex) x v))]
    [(symbol=? (first ex) '*) (list '* (subst (second ex) x v) (subst (third ex) x v))]
    [else (list (first ex) (subst (second ex) x v))]))

; BSL-expr BSL-da-all -> BSL-value
(define (interpreter ex da)
  (match ex
    [(? number?) ex]
    [(? symbol?) (interpreter (third (lookup da ex)) da)]
    [(list '+ l r) (+ (interpreter l da) (interpreter r da))]
    [(list '* l r) (* (interpreter l da) (interpreter r da))]
    [(list fname arg)
     (local ((define value (interpreter arg da))
             (define lookd-def (lookup da fname))
             (define plugd (subst (third lookd-def) (second (second lookd-def)) value)))
       (interpreter plugd da))]))

; BSL-da-all Symbol -> BSL-def
(define (lookup da s)
  (cond
    [(empty? da) (error WRONG)]
    [else
     (match (first da)
       [(list 'define (list name param) body)
        (if (equal? s name) (first da) (lookup (rest da) s))]
       [(list 'define name body)
        (if (equal? s name) (first da) (lookup (rest da) s))])]))


;; -----------------------------------------------------------------------------

; tests

(define da-ex
  '((define (f x) (+ 3 x))
    (define (g y) (f (* 2 y)))
    (define (h v) (+ (f v) (g v)))
    (define I (* 3 4))
    (define J (f 4))))

(check-expect (interpreter '(* (+ 3 4) 5) '()) 35)
(check-expect (interpreter '(* (+ x y) z) '((define x 3) (define z 5) (define y 4))) 35)
(check-error (interpreter '(* 4 (+ 3 (f (* (+ 1 2) (+ 3 4))))) '()))
(check-expect (interpreter '(* 4 (+ 3 (g (* (+ 1 2) (+ 3 4))))) da-ex) 192)
(check-expect (interpreter '(* 12 (+ 3 (h (* (+ 1 2) (+ 3 4))))) da-ex) 864)