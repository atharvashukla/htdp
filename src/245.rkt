;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 245ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 245
;; ------------
;; Develop the function=at-1.2-3-and-5.775? function. Given two functions from
;; numbers to numbers, the function determines whether the two produce the same
;; results for 1.2, 3, and -5.775.
;;
;; Mathematicians say that two functions are equal if they compute the same
;; result when given the same input—for all possible inputs.
;;
;; Can we hope to define function=?, which determines whether two functions from
;; numbers to numbers are equal? If so, define the function. If not, explain why
;; and consider the implication that you have encountered the first easily
;; definable idea for which you cannot define a function.
;; -----------------------------------------------------------------------------

; Numbuer -> Number
; returns the number that was entered
(check-expect (my-id 3) 3)
(define (my-id x)
  x)

(check-expect (function=at-1.2-3-and-5.775 my-id identity) #true)
(check-expect (function=at-1.2-3-and-5.775 sqr identity) #false)

(define (function=at-1.2-3-and-5.775 f1 f2)
  (and  (equal? (f1 3) (f2 3))
        (equal? (f1 1.2) (f2 1.2))
        (equal? (f1 -5.775) (f2 -5.775))))


; we can use theorem provers to prove "function=?" for certain functions
; but for any function, function=? is not definable

; My guess is that the collatz conjecture would be trivially proven if
; such a function existed from numbers to numbers