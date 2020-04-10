;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 150ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 150.
;; -------------
;; Design the function add-to-pi. It consumes a natural number n and adds it to
;; pi without using the primitive + operation. Here is a start:
;; 
;;    ; N -> Number
;;    ; computes (+ n pi) without using +
;;     
;;    (check-within (add-to-pi 3) (+ 3 pi) 0.001)
;;     
;;    (define (add-to-pi n)
;;      pi)
;;
;; Once you have a complete definition, generalize the function to add, which
;; adds a natural number n to some arbitrary number x without using +. Why does
;; the skeleton use check-within? 
;; -----------------------------------------------------------------------------


; N -> Number
; computes (+ n pi) without using +
 
(check-within (add-to-pi 3) (+ 3 pi) 0.001)

#;
(define (add-to-pi n)
  pi)

(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [(positive? n) (add1 (add-to-pi (sub1 n)))]))

; Once you have a complete definition, generalize the function to add,
; which adds a natural number n to some arbitrary number x without
; using +.

; N Number -> Number 
; computes (+ n x) without using +

(check-within (add-to-x 3 pi) (+ 3 pi) 0.001)
(check-expect (add-to-x 3 2.5) (+ 3 2.5))
(check-expect (add-to-x 0 0) 0)

#;
(define (add-to-x n x)
  (cond
    [(zero? n) ...]
    [(positive? n) (... (add-to-x (sub1 n) x) ...)]))

(define (add-to-x n x)
  (cond
    [(zero? n) x]
    [else (add1 (add-to-x (sub1 n) x))]))

; Why does the skeleton use check-within?

; The skeleton uses check-within because pi is not a rational number