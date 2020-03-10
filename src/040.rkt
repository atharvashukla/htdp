#lang htdp/bsl

; Exercise 40.
; ------------
; Formulate the examples as BSL tests, that is, using the check-expect form.
; Introduce a mistake. Re-run the tests.
; -----------------------------------------------------------------------------


; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 
;   given: 20, expect 23
;   given: 78, expect 81
(define (tock ws)
  #;(+ ws 1) ;; <- introducing a mistake
  (+ ws 3))


(check-expect (tock 20) 23)
(check-expect (tock 78) 81)


; breaks
