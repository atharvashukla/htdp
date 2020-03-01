#lang htdp/bsl

; Exercise 19.
; ------------
;
; Define the function string-insert, which consumes a string str plus a number
; i and inserts "_" at the ith position of str. Assume i is a number between 0
; and the length of the given string (inclusive). See exercise 3 for ideas.
; Ponder how string-insert copes with "". 
;
; ----------------------------------------------------------------------------

(define (string-insert str i)
  (string-append
   (substring str 0 i)
   "_"
   (substring str i)))


(string-insert "abcde" 3)
; => "abc_de"
(string-insert "jaded" 1)
; => "j_aded"
(string-insert "iamtheone" 9)
;  => "iamtheone_"

(string-insert "" 0)
; => "_"

; `(string-insert "" 0)` would throw an error for substring ending index out of
; range