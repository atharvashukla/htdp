;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 444ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 444
;; ------------
;; Exercise 443 means that the design for gcd-structural calls for some planning
;; and a design-by-composition approach.
;;
;; The very explanation of “greatest common denominator” suggests a two-stage
;; approach. First design a function that can compute the list of divisors of a
;; natural number. Second, design a function that picks the largest common
;; number in the list of divisors of n and the list of divisors of m. The
;; overall function would look like this:
;;
;; Why do you think divisors consumes two numbers? Why does it consume S as the
;; first argument in both uses?
;; 
;;    (define (gcd-structural S L)
;;      (largest-common (divisors S S) (divisors S L)))
;;     
;;    ; N[>= 1] N[>= 1] -> [List-of N]
;;    ; computes the divisors of l smaller or equal to k
;;    (define (divisors k l)
;;      '())
;;     
;;    ; [List-of N] [List-of N] -> N
;;    ; finds the largest number common to both k and l
;;    (define (largest-common k l)
;;      1)
;;
;; -----------------------------------------------------------------------------

; Number Number -> Number
; the gcd of S and L

(check-expect (gcd-structural 18 24) 6)
(check-expect (gcd-structural 24 18) 6)
(check-expect (gcd-structural 6 25) 1)
(check-expect (gcd-structural 1 25) 1)
(check-expect (gcd-structural 6 1) 1)
(check-expect (gcd-structural 1 1) 1)

(define (gcd-structural S L)
  (largest-common (divisors S S) (divisors S L)))
 
; N[>= 1] N[>= 1] -> [List-of N]
; computes the divisors of l smaller or equal to k

(check-expect (divisors 24 24) '(1 2 3 4 6 8 12 24))
(check-expect (divisors 12 1) '(1))

(define (divisors k l)
  (filter (λ (x) (= 0 (remainder l x)))
          (build-list (add1 k) add1)))
 
; [List-of N] [List-of N] -> N
; finds the largest number common to both k and l
; ASSUMPTION: at least one common element exists

(check-expect (largest-common '(1 4 2 9 5 3 8 8) '(23 3 9 5 3 8 8)) 9)
(check-expect (largest-common '(99 1) '(23 3 9 5 3 2 1)) 1)

(define (largest-common k l)
  (first (sort (filter (λ (x) (member? x k)) l) >)))


