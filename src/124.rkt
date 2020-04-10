;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |124|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 124.
;; -------------
;;
;; Evaluate the following program, step-by-step:
;;
;;    (define PRICE 5)
;;    (define SALES-TAX (* 0.08 PRICE))
;;    (define TOTAL (+ PRICE SALES-TAX))
;;
;; Does the evaluation of the following program signal an error?
;;
;;    (define COLD-F 32)
;;    (define COLD-C (fahrenheit->celsius COLD-F))
;;    (define (fahrenheit->celsius f)
;;     (* 5/9 (- f 32)))
;;
;; How about the next one?
;;
;;    (define LEFT -100)
;;    (define RIGHT 100)
;;    (define (f x) (+ (* 5 (expt x 2)) 10))
;;    (define f@LEFT (f LEFT))
;;    (define f@RIGHT (f RIGHT))
;;
;; Check your computations with DrRacket’s stepper.
;; 
;; -----------------------------------------------------------------------------



(define PRICE 5) ; == 5
(define SALES-TAX (* 0.08 PRICE)) ; == 0.4
(define TOTAL (+ PRICE SALES-TAX)) ; == 5.4

(define COLD-F 32) ; == 32
#;
(define COLD-C (fahrenheit->celsius COLD-F)) ; error `fahrenheit->celsius` not defined
(define (fahrenheit->celsius f)
 (* 5/9 (- f 32)))

(define LEFT -100) ; == -100
(define RIGHT 100) ; == 100
(define (f x) (+ (* 5 (expt x 2)) 10))
(define f@LEFT (f LEFT))   ; == (+ (* 5 (expt -100 2)) 10) = 50010
(define f@RIGHT (f RIGHT)) ; == (+ (* 5 (expt -100 2)) 10) = 50010 