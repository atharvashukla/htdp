#lang htdp/bsl

; Exercise 18.
; ------------
;
; Define the function string-join, which consumes two strings and appends them
; with "_" in between. See exercise 2 for ideas. 
;
; ----------------------------------------------------------------------------


(define (string-join pre-str post-str)
  (string-append pre-str "_" post-str))

(string-join "atharva" "shukla")
; => "atharva_shukla"

(string-join "charvie" "shukla")
; => "charvie_shukla"