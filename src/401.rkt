;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 401ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 401
;; ------------
;; Design sexp=?, a function that determines whether two S-expressions are
;; equal. For convenience, here is the data definition in condensed form:
;; 
;;    ; An S-expr (S-expression) is one of: 
;;    ; – Atom
;;    ; – [List-of S-expr]
;;    ; 
;;    ; An Atom is one of: 
;;    ; – Number
;;    ; – String
;;    ; – Symbol
;;
;; Whenever you use check-expect, it uses a function like sexp=? to check
;; whether the two arbitrary values are equal. If not, the check fails and
;; check-expect reports it as such. 
;; -----------------------------------------------------------------------------

; An S-expr (S-expression) is one of: 
; – Atom
; – [List-of S-expr]
; 
; An Atom is one of: 
; – Number
; – String
; – Symbol


; S-expr S-expr -> Boolean
; are the two s-expressions the same?

(check-expect (sexp=? '(define f (λ (x) (+ x 1))) '(define f (λ (x) (+ x 1)))) #true)
(check-expect (sexp=? '(define f (λ (x) (+ x 1))) '(define (f x) (+ x 1))) #false)
(check-expect (sexp=? 'a 'a) #true)
(check-expect (sexp=? 'a 'b) #false)
(check-expect (sexp=? 1 1) #true)
(check-expect (sexp=? 1 2) #false)
(check-expect (sexp=? "1" "1") #true)
(check-expect (sexp=? "1" "2") #false)
(check-expect (sexp=? 1 '()) #false)
(check-expect (sexp=? '() 1) #false)
(check-expect (sexp=? '(1 d) 1) #false)
(check-expect (sexp=? '() '(1 d)) #false)
(check-expect (sexp=? '(1 2 3) '()) #false)
(check-expect (sexp=? '() '()) #true)

#;
(define (sexp=?)
  #f)

#;
(define (sexp=? s1 s2)
  (cond
    [(and (atom? s1) (atom? s2)) ...]
    [(and (atom? s1) (empty? s2)) ...]
    [(and (atom? s1) (cons? s2)) ...]
    [(and (empty? s1) (atom? s2)) ...]
    [(and (cons? s1) (atom? s2)) ...]
    [(and (empty? s1) (empty? s2)) ...]
    [(and (empty? s1) (cons? s2)) ...]
    [(and (cons? s1) (empty? s2)) ...]
    [(and (cons? s1) (cons? s2)) ...]))

(define (sexp=? s1 s2)
  (cond
    [(and (atom? s1) (atom? s2)) (equal? s1 s2)]
    [(and (atom? s1) (empty? s2)) #false]
    [(and (atom? s1) (cons? s2)) #false]
    [(and (empty? s1) (atom? s2)) #false]
    [(and (cons? s1) (atom? s2)) #false]
    [(and (empty? s1) (empty? s2)) #true]
    [(and (empty? s1) (cons? s2)) #false]
    [(and (cons? s1) (empty? s2)) #false]
    [(and (cons? s1) (cons? s2))
     (and (sexp=? (first s1) (first s2))
          (sexp=? (rest s1) (rest s2)))]))

; Simplification


(check-expect (sexp=?.v2 '(define f (λ (x) (+ x 1))) '(define f (λ (x) (+ x 1)))) #true)
(check-expect (sexp=?.v2 '(define f (λ (x) (+ x 1))) '(define (f x) (+ x 1))) #false)
(check-expect (sexp=?.v2 'a 'a) #true)
(check-expect (sexp=?.v2 'a 'b) #false)
(check-expect (sexp=?.v2 1 1) #true)
(check-expect (sexp=?.v2 1 2) #false)
(check-expect (sexp=?.v2 "1" "1") #true)
(check-expect (sexp=?.v2 "1" "2") #false)
(check-expect (sexp=?.v2 1 '()) #false)
(check-expect (sexp=?.v2 '() 1) #false)
(check-expect (sexp=?.v2 '(1 d) 1) #false)
(check-expect (sexp=?.v2 '() '(1 d)) #false)
(check-expect (sexp=?.v2 '(1 2 3) '()) #false)
(check-expect (sexp=?.v2 '() '()) #true)

(define (sexp=?.v2 s1 s2)
  (cond
    [(and (atom? s1) (atom? s2)) (equal? s1 s2)]
    [(and (empty? s1) (empty? s2)) #true]
    [(and (cons? s1) (cons? s2)) (andmap sexp=?.v2 s1 s2)]
    [else #false]))

;; -----------------------------------------------------------------------------

;; Any -> Boolean
;; is the x an atom?

(check-expect (atom? 'x) #t)
(check-expect (atom? "x") #t)
(check-expect (atom? 1) #t)
(check-expect (atom? (list 1 "x" 'x)) #f)

(define (atom? x)
  (not (list? x)))