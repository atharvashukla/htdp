;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 306ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 306
;; ------------
;; Use loops to define a function that
;; 
;; 1. creates the list (list 0 ... (- n 1)) for any natural number n;
;;
;; 2. creates the list (list 1 ... n) for any natural number n;
;;
;; 3. creates the list (list 1 1/2 ... 1/n) for any natural number n;
;; 
;; 4. creates the list of the first n even numbers; and
;;
;; 5. creates a diagonal square of 0s and 1s; see exercise 262.
;;
;; Finally, use loops to define tabulate from exercise 250.
;; -----------------------------------------------------------------------------

(require 2htdp/abstraction)

; Nat -> [List-of Nat]
; creates a list from 0 to n-1

(check-expect (zero-to-n 0) '())
(check-expect (zero-to-n 1) '(0))
(check-expect (zero-to-n 7) '(0 1 2 3 4 5 6))

(define (zero-to-n n)
  (for/list ((i n))
    (identity i)))

; Nat -> [List-of Nat]
; creates a list from 1 to n-1

(check-expect (one-to-n 0) '())
(check-expect (one-to-n 1) '(1))
(check-expect (one-to-n 5) '(1 2 3 4 5))

(define (one-to-n n)
  (for/list ((i n))
    (add1 i)))


; Nat -> [List-of Rational]
; reciprocates a list from 1 to n-1

(check-expect (enum-recip 0) '())
(check-expect (enum-recip 1) '(1))
(check-expect (enum-recip 4) '(1 1/2 1/3 1/4))

(define (enum-recip n)
  (for/list ((i n))
    (/ 1 (+ i 1))))

; Nat -> [List-of Nat]
; table of 2 starting 0

(check-expect (enum-even 1) '(0))
(check-expect (enum-even 2) '(0 2))
(check-expect (enum-even 4) '(0 2 4 6))

(define (enum-even n)
  (for/list ((i n))
    (* 2 i)))

; Nat -> [List-of [List-of Nat]]
; creates an identity matrix of dimension n

(check-expect (id-mat 0) '())
(check-expect (id-mat 1) (list (list 1)))
(check-expect (id-mat 2) (list (list 1 0) (list 0 1)))
(check-expect (id-mat 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))

(define (id-mat n)
  (for/list ((i n))
    (for/list ((j n))
      (if (= i j) 1 0))))


; Number [Number -> Number] -> [List-of Number]
; tabulates f between n and 0 (incl.) in a list

(check-within (tabulate 2 sin) (list (sin 2) (sin 1) (sin 0)) 0.0001)
(check-within (tabulate 2 sqrt) (list (sqrt 2) (sqrt 1) (sqrt 0)) 0.0001)

(define (tabulate n f)
  (for/list ((i (+ n 1)))
    (f (- n i))))

