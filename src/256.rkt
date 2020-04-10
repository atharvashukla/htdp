;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 256ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 256.                                                               |
| +-----------+                                                               |
| Explain the following abstract function:                                    |
|                                                                             |
| ; [X] [X +> Number] [NEList-of X] -> X                                      |
| ; finds the (first) item in lx that maximizes f                             |
| ; if (argmax f (list x-1 ... x-n)) == x-i,                                  |
| ; then (>= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...                      |
| (define (argmax f lx) ...)                                                  |
|                                                                             |
| Use it on concrete examples in ISL. Can you articulate an analogous purpose |
| statement for argmin?                                                       |
+-----------------------------------------------------------------------------+
|#

; argmax would return the element whose value is the highest when the function
; (supplied as an argument) is applied to it, compared to all other elements.

; similarly

; argmin would return the element whose value is the lowest when the function
; (supplied as an argument) is applied to it, compared to all other elements.

(define lst1 '(1 2 3 4 5))

(check-expect (argmax sqr lst1) 5)
(check-expect (argmin sqr lst1) 1)

(check-expect (argmax identity lst1) 5)
(check-expect (argmin identity lst1) 1)