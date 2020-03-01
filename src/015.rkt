#lang htdp/bsl

;  Exercise 15.
;  ------------
; 
;  Define ==>. The function consumes two Boolean values, call them sunny and
;  friday. Its answer is #true if sunny is false or friday is true. Note
;  Logicians call this Boolean operation implication, and they use the notation
;  sunny => friday for this purpose. 
; 
;  ----------------------------------------------------------------------------

(define (==> sunny friday)
  (or (not sunny) friday))

(==> #true   #true)
;  => true
(==> #true  #false)
;  => false
(==> #false #false)
;  => true
(==> #false  #true)
;  => true