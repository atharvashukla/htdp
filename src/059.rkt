#lang htdp/bsl

; Exercise 59.
; ------------
; Finish the design of a world program that simulates the traffic light FSA.
; Here is the main function:
;
;    ; TrafficLight -> TrafficLight
;    ; simulates a clock-based American traffic light
;    (define (traffic-light-simulation initial-state)
;      (big-bang initial-state
;        [to-draw tl-render]
;        [on-tick tl-next 1]))
;
; The function’s argument is the initial state for the big-bang expression,
; which tells DrRacket to redraw the state of the world with tl-render and to
; handle clock ticks with tl-next. Also note that it informs the computer that
; the clock should tick once per second.
;
; Complete the design of tl-render and tl-next. Start with copying
; TrafficLight, tl-next, and tl-render into DrRacket’s definitions area.
;
; Here are some test cases for the design of the latter:
;
;    (check-expect (tl-render "red") <image red on>)
;    (check-expect (tl-render "yellow") <image yellow on>)
;
; Your function may use these images directly. If you decide to create images
; with the functions from the 2htdp/image library, design an auxiliary function
; for creating the image of a one-color bulb. Then read up on the place-image
; function, which can place bulbs into a background scene.
; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

(define RED "red")
(define YELLOW "yellow")
(define GREEN "green")

(define (tl-temp tl)
  (cond
    [(string=? RED tl) ...]
    [(string=? YELLOW tl) ...]
    [(string=? GREEN tl) ...]))


(define empty-tl
  (overlay (rectangle 50 20 "outline" "black")
           (rectangle 56 26 "solid" "transparent")))

(define TL-RADIUS 6)

; TrafficLight String -> Image
; makes a bulb for the given tl of radius TL-RADIUS
; with the given mode
(define (make-bulb mode tl)
  (circle TL-RADIUS mode tl))

(define RED-LIGHT-ON (make-bulb "solid" "red"))
(define YELLOW-LIGHT-ON (make-bulb "solid" "yellow"))
(define GREEN-LIGHT-ON (make-bulb "solid" "green"))

(define TL-SPACE (square 3 "solid" "transparent"))

(define red-light-off (make-bulb "outline" "red"))
(define yellow-light-off (make-bulb "outline" "yellow"))
(define green-light-off (make-bulb "outline" "green"))


(define RED-ON
  (overlay (beside RED-LIGHT-ON TL-SPACE yellow-light-off TL-SPACE green-light-off) empty-tl))

(define YELLOW-ON
  (overlay (beside red-light-off TL-SPACE YELLOW-LIGHT-ON TL-SPACE green-light-off) empty-tl))

(define GREEN-ON
  (overlay (beside red-light-off TL-SPACE yellow-light-off TL-SPACE GREEN-LIGHT-ON) empty-tl))



; TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (traffic-light-next "red") "green")
(check-expect (traffic-light-next "green") "yellow")
(check-expect (traffic-light-next "yellow") "red")
(define (traffic-light-next s)
  (cond
    [(string=? RED s) "green"]
    [(string=? GREEN s) "yellow"]
    [(string=? YELLOW s) "red"]))


; TrafficLight -> TrafficLight
; yields the next state, given current state cs
#;
(define (tl-next cs) cs)
 
; TrafficLight -> Image
; renders the current state cs as an image

(check-expect (tl-render RED) RED-ON)
(check-expect (tl-render YELLOW) YELLOW-ON)
(check-expect (tl-render GREEN) GREEN-ON)

(define (tl-render current-state)
  (cond
    [(string=? RED current-state) RED-ON]
    [(string=? YELLOW current-state) YELLOW-ON]
    [(string=? GREEN current-state) GREEN-ON]))


; TrafficLight -> TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick traffic-light-next 1]))


#;
(traffic-light-simulation RED)
