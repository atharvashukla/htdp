#lang htdp/bsl

; Exercise 61.
; ------------
; As From Functions to Programs says, programs must define constants and us
; names instead of actual constants. In this spirit, a data definition for
; traffic lights must use constants, too:
;
;    (define RED 0)
;    (define GREEN 1)
;    (define YELLOW 2)
;     
;    ; An S-TrafficLight is one of:
;    ; – RED
;    ; – GREEN
;    ; – YELLOW
;
; If the names are chosen properly, the data definition does not need an
; interpretation statement.
;
;    ; S-TrafficLight -> S-TrafficLight
;    ; yields the next state, given current state cs
;    
;    (check-expect (tl-next- ... RED) YELLOW)
;    (check-expect (tl-next- ... YELLOW) GREEN)
;    
;    (define (tl-next-numeric cs)
;      (modulo (+ cs 1) 3))
;      
;    (define (tl-next-symbolic cs)
;      (cond
;        [(equal? cs RED) GREEN]
;        [(equal? cs GREEN) YELLOW]
;        [(equal? cs YELLOW) RED]))
;    
;    ;; Figure 27: A symbolic traffic light
;
; Figure 27 displays two different functions that switch the state of a traffic
; light in a simulation program. Which of the two is properly designed using
; the recipe for itemization? Which of the two continues to work if you change
; the constants to the following
;
;    (define RED "red")
;    (define GREEN "green")
;    (define YELLOW "yellow")
;
; Does this help you answer the questions?
;
; *Aside* The equal? function in figure 27 compares two arbitrary values,
; regardless of what these values are. Equality is a complicated topic in the
; world of programming. *End*
; ------------------------------------------------------------------------------


; tl-next-symbolic is designed using the designed recipe for itemization
; it continues to work.
