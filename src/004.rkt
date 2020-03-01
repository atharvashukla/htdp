#lang htdp/bsl

; Exercise 4.
; -----------
; Use the same setup as in exercise 3 to create an expression that deletes the
; ith position from str. Clearly this expression creates a shorter string than
; the given one. Which values for i are legitimate?
; ------------------------------------------------------------------------------

(define str "helloworld")
(define ind "0123456789")
(define i 5)

(string-append (substring ind 0 (- i 1))
               (substring ind i (string-length ind)))

; legitimate range for i : [0, (length str))