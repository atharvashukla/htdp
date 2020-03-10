#lang htdp/bsl

; Exercise 50.
; ------------
; If you copy and paste the above function definition into the definitions area
; of DrRacket and click RUN, DrRacket highlights two of the three cond lines.
; This coloring tells you that your test cases do not cover the full
; conditional. Add enough tests to make DrRacket happy.
; ------------------------------------------------------------------------------


; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 

; TrafficLight -> TrafficLight
; yields the next state given current state s

(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))
