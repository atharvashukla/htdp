;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 1ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 1.
;; -----------
;; Add the following definitions for x and y to DrRacket’s definitions area:

;;     (define x 3)
;;     (define y 4)

;; Now imagine that x and y are the coordinates of a Cartesian point. Write down
;; an expression that computes the distance of this point to the origin, that
;; is, a point with the coordinates (0,0).

;; The expected result for these values is 5, but your expression should produce
;; the correct result even after you change these definitions.

;; Just in case you have not taken geometry courses or in case you forgot the
;; formula that you encountered there, the point (x,y) has the distance

;;    (x^2 + y^2)^(1/2)

;; from the origin. After all, we are teaching you how to design programs, not
;; how to be a geometer.


;; To develop the desired expression, it is best to click RUN and to experiment
;; in the interactions area. The RUN action tells DrRacket what the current
;; values of x and y are so that you can experiment with expressions that
;; involve x and y:

;;    > x
;;    3
;;    > y
;;    4
;;    > (+ x 10)
;;    13
;;    > (* x y)
;;    12


;; Once you have the expression that produces the correct result, copy it from
;; the interactions area to the definitions area.

;; To confirm that the expression works properly, change x to 12 and y to 5,
;; then click RUN. The result should be 13.

;; Your mathematics teacher would say that you computed the distance formula. To
;; use the formula on alternative inputs, you need to open DrRacket, edit the
;; definitions of x and y so they represent the desired coordinates, and click
;; RUN. But this way of reusing the distance formula is cumbersome and naive. We
;; will soon show you a way to define functions, which makes reusing formulas
;; straightforward. For now, we use this kind of exercise to call attention to
;; the idea of functions and to prepare you for programming with them.

;; -----------------------------------------------------------------------------


;; (define x 3)
;; (define y 4)

;; (x^2 + y^2)^(1/2)

;; (sqrt (+ (sqr x) (sqr y)))
;; => 5

(define x 12)
(define y 5)

(sqrt (+ (sqr x) (sqr y))) ;; distance formula
;; => 13