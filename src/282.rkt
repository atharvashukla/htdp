;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 282ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 282
;; ------------
;; 
;; Experiment with the above definitions in DrRacket.
;; 
;; Also add
;;
;;    ; Number -> Boolean
;;    (define (compare x)
;;      (= (f-plain x) (f-lambda x)))
;;
;; to the definitions area after renaming the left-hand f to f-plain and the
;; right-hand one to f-lambda. Then run
;;
;; (compare (random 100000))
;;
;; a few times to make sure the two functions agree on all kinds of inputs.
;; -----------------------------------------------------------------------------


(define (f-plain x)
  (* 10 x))

	
(define f-lambda
  (lambda (x)
     (* 10 x)))

; Number -> Boolean
(define (compare x)
  (= (f-plain x) (f-lambda x)))


(check-expect (compare (random 100000)) #true)
(check-expect (compare (random 100000)) #true)
(check-expect (compare (random 100000)) #true)
(check-expect (compare (random 100000)) #true)
(check-expect (compare (random 100000)) #true)

