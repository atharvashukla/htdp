;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 358ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 358
;; ------------
;; Provide a structure type and a data definition for function definitions.
;; Recall that such a definition has three essential attributes:
;;
;; 1. the function’s name, which is represented with a symbol;
;; 2. the function’s parameter, which is also a name; and
;; 3. the function’s body, which is a variable expression.
;;
;; We use BSL-fun-def to refer to this class of data.
;;
;; Use your data definition to represent these BSL function definitions:
;;
;; 1. (define (f x) (+ 3 x))
;; 2. (define (g y) (f (* 2 y)))
;; 3. (define (h v) (+ (f v) (g v)))
;;
;; Next, define the class BSL-fun-def* to represent a definitions area that
;; consists of a number of one-argument function definitions. Translate the
;; definitions area that defines f, g, and h into your data representation and
;; name it da-fgh.
;;
;; Finally, work on the following wish:
;;
;;    ; BSL-fun-def* Symbol -> BSL-fun-def
;;    ; retrieves the definition of f in da
;;    ; signals an error if there is none
;;    (check-expect (lookup-def da-fgh 'g) g)
;;    (define (lookup-def da f) ...)
;;
;; Looking up a definition is needed for the evaluation of applications. 
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

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-fun-expression BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)
; - (make-fun Symbol BSL-fun-expression)

; ---

(define-struct fundef [name param body])
; BSL-fun-def is a struct:
;   (make-fundef Symbol Symbol BSL-expr)
; interpretation. representation of a BSL function definition


; (define (f x) (+ 3 x))
(define f (make-fundef 'f 'x (make-add 3 'x)))

; (define (g y) (f (* 2 y)))
(define g (make-fundef 'g 'y (make-fun 'f (make-mul 2 'y))))

; (define (h v) (+ (f v) (g v)))
(define h (make-fundef 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

; BSL-fun-def* is a [List-of BSL-fun-def]
; interpretation. represents a definition area with multiple
; one argument function definitions

(define da-fgh (list f g h))

(define WRONG "WRONG")

; ----------


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
