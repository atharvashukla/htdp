;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 436ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 436
;; ------------
;; Formulate a termination argument for food-create from exercise 432. 
;; -----------------------------------------------------------------------------


(define MAX 500)

(check-satisfied (food-create (make-posn 1 1))
                 (λ (p) (not (and (= (posn-x p) 1) (= (posn-y p) 1)))))
(check-random (food-create (make-posn 1 1))
              (food-create (make-posn 1 1)))


; Posn -> Posn 
; creates a posn ([0, MAX), [0, MAX)) except at p
; termination: the probability of hitting the generative case is
; only (/ 1 (sqr MAX)), every recursive call. For infinite recursive calls
; the probability tends to 0. So food-create teminates. The conditions for
; non termination are: (define MAX 1) (food-create (make-posn 0 0))
(define (food-create p)
  (local ((define random-choice (make-posn (random MAX) (random MAX))))
    (if (not (equal? p random-choice))
        random-choice
        (food-create p))))
 

