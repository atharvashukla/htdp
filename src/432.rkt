;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 432ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 432
;; ------------
;; Exercise 219 introduces the function food-create, which consumes a Posn and
;; produces a randomly chosen Posn that is guaranteed to be distinct from the
;; given one. First reformulate the two functions as a single definition, using
;; local; then justify the design of food-create.
;; -----------------------------------------------------------------------------


(define MAX 500)

(check-satisfied (food-create (make-posn 1 1))
                 (λ (p) (not (and (= (posn-x p) 1) (= (posn-y p) 1)))))
(check-random (food-create (make-posn 1 1))
              (food-create (make-posn 1 1)))


; Posn -> Posn 
; creates a posn ([0, MAX), [0, MAX)) except at p
(define (food-create p)
  (local ((define random-choice (make-posn (random MAX) (random MAX))))
    (if (not (equal? p random-choice))
        random-choice
        (food-create p))))
 

; 1) creates a random posn: random-choice
; 2) - trivial case: the choice is not equal to p
;    - generative case: the choice is the same as p — generate again!