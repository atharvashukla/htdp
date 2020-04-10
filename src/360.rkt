;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 360ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 360
;; ------------
;; Formulate a data definition for the representation of DrRacket’s definitions
;; area. Concretely, the data representation should work for a sequence that
;; freely mixes constant definitions and one-argument function definitions. Make
;; sure you can represent the definitions area consisting of three definitions
;; at the beginning of this section. We name this class of data BSL-da-all.
;;
;; Design the function lookup-con-def. It consumes a BSL-da-all da and a symbol
;; x. It produces the representation of a constant definition whose name is x,
;; if such a piece of data exists in da; otherwise the function signals an error
;; saying that no such constant definition can be found.
;;
;; Design the function lookup-fun-def. It consumes a BSL-da-all da and a symbol
;; f. It produces the representation of a function definition whose name is f,
;; if such a piece of data exists in da; otherwise the function signals an error
;; saying that no such function definition can be found.
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
; – (make-add BSL-da-all BSL-da-all)
; – (make-mul BSL-da-all BSL-da-all)
; - (make-fun Symbol BSL-da-all)
; interpretation. representation of a bsl expressions

(define WRONG "WRONG")

;; -----------------------------------------------------------------------------

; (define (f x) (+ 3 x))
(define f (make-fundef 'f 'x (make-add 3 'x)))

; (define (g y) (f (* 2 y)))
(define g (make-fundef 'g 'y (make-fun 'f (make-mul 2 'y))))

; (define (h v) (+ (f v) (g v)))
(define h (make-fundef 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

; (define I (* 3 4)
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

; BSL-defined is one of
; - BSL-fun-def
; - BSL-con-def
; interpretation. possible definitions

; BSL-da-all Symbol -> BSL-defined
; look for contant or function definition named x
(define (lookup-abs da x)
  (local ((define con-list (da-cdefs da))
          (define fun-list (da-fdefs da))
          (define lookd-con (filter (λ (c) (equal? (condef-name c) x)) con-list))
          (define lookd-fun (filter (λ (fun) (equal? f (fundef-name fun))) fun-list)))
    (cond
      [(cons? lookd-con) (first lookd-con)]
      [(cons? lookd-fun) (first lookd-fun)]
      [else (error WRONG)])))
