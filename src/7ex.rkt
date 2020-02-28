;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 8ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 7.
;; -----------

;; Boolean expressions can express some everyday problems. Suppose you want to
;; decide whether today is an appropriate day to go to the mall. You go to the
;; mall either if it is not sunny or if today is Friday (because that is when
;; stores post new sales items).

;; Here is how you could go about it using your new knowledge about Booleans.
;; First add these two lines to the definitions area of DrRacket:

;;    (define sunny #true)
;;    (define friday #false)

;; Now create an expression that computes whether sunny is false or friday is
;; true. So in this particular case, the answer is #false. (Why?)

;; See exercise 1 for how to create expressions in DrRacket. How many
;; combinations of Booleans can you associate with sunny and friday? 

;; -----------------------------------------------------------------------------



(define sunny #true)
(define friday #false)



(or (not sunny) friday)
;; => #false
;; because it IS sunny and it isn't Friday


;; Number of combinations that can be associated with `sunny` and `friday` are:
;; 2 (#t anf #f) for each (2) variable. 2 * 2 = 4 combinations.