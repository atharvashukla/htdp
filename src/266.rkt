;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 266ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 266
;; ------------
;; Use DrRacket’s stepper to find out how ISL evaluates
;;
;;    ((local ((define (f x) (+ x 3))
;;             (define (g x) (* x 4)))
;;       (if (odd? (f (g 1)))
;;           f
;;           g))
;;     2)
;;
;; to 5.
;; -----------------------------------------------------------------------------


((local ((define (f x) (+ x 3))
         (define (g x) (* x 4)))
   (if (odd? (f (g 1)))
       f
       g))
 2)

;; > function call: expected a function after the open parenthesis,
;;   but found a part

; switching to ISL+


== [lifting and renaming]

(define (f_0 x) (+ x 3))
(define (g_0 x) (* x 4))
((if (odd? (f_0 (g_0 1)))
   f_0
   g_0)
 2)

==

((if (odd? (f_0 4))
   f_0
   g_0)
 2)

==

((if (odd? 7)
   f_0
   g_0)
 2)

==

((if #true
   f_0
   g_0)
 2)

==

(f_0
 2)

==

5