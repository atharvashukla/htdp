#lang htdp/bsl

; Exercise 3.
; -----------
; Add the following two lines to the definitions area:
;
;    (define str "helloworld")
;    (define i 5)
;
; Then create an expression using string primitives that adds "_" at position
; i. In general this means the resulting string is longer than the original
; one; here the expected result is "hello_world".

; Position means i characters from the left of the string, but programmers
; start counting at 0. Thus, the 5th letter in this example is "w", because
; the 0th letter is "h". Hint When you encounter such “counting problems” you
; may wish to add a string of digits below str to help with counting:
; 
;    (define str "helloworld")
;    (define ind "0123456789")
;    (define i 5)
; 
; See exercise 1 for how to create expressions in DrRacket.
;
; -----------------------------------------------------------------------------


(define str "helloworld")
(define i 5)

(string-append (substring str 0 i)
               "_"
               (substring str i (string-length str)))

