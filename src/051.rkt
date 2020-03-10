#lang htdp/bsl

; Exercise 51.
; ------------
; Design a big-bang program that simulates a traffic light for a given
; duration. The program renders the state of a traffic light as a solid circle
; of the appropriate color, and it changes state on every clock tick. What is
; the most appropriate initial state? Ask your engineering friends.
; ------------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

(define ws-red "red")
(define ws-green "green")
(define ws-yellow "yellow")

; Template

(define (traffic-light-template tl)
  (cond [(string=? tl "red")    ...]
        [(string=? tl "yellow") ...]
        [(string=? tl "green")  ...]))

; Constants/Examples

(define TL-RADIUS 30)
(define TL-SCENE-WIDTH (+ (* 2 TL-RADIUS) 2))
(define TL-SCENE-HEIGHT (+ (* 6 TL-RADIUS) 2))
(define TL-SCENE (empty-scene TL-SCENE-WIDTH TL-SCENE-HEIGHT))


(define TL-RED    (circle TL-RADIUS "solid" "red"))
(define TL-YELLOW (circle TL-RADIUS "solid" "yellow"))
(define TL-GREEN  (circle TL-RADIUS "solid" "green"))

(define TL-OFF (circle TL-RADIUS "outline" "black"))

(define TL-RED-ON    (overlay (above TL-RED TL-OFF TL-OFF) TL-SCENE))
(define TL-YELLOW-ON (overlay (above TL-OFF TL-YELLOW TL-OFF) TL-SCENE))
(define TL-GREEN-ON  (overlay (above TL-OFF TL-OFF TL-GREEN) TL-SCENE))


; WorldState (WS) is a TrafficLight

; WS -> Image
; image with the given tl switched on

(check-expect (render ws-red)    TL-RED-ON)
(check-expect (render ws-yellow) TL-YELLOW-ON)
(check-expect (render ws-green)  TL-GREEN-ON)

(define (render tl)
  (cond [(string=? tl ws-red)    TL-RED-ON]
        [(string=? tl ws-yellow) TL-YELLOW-ON]
        [(string=? tl ws-green)  TL-GREEN-ON]))

; WS -> WS
; changes ws to the next traffic light

(check-expect (tock ws-red)    ws-yellow)
(check-expect (tock ws-yellow) ws-green)
(check-expect (tock ws-green)  ws-red)

(define (tock ws)
  (cond [(string=? ws "red")    ws-yellow]
        [(string=? ws "yellow") "green"]
        [(string=? ws "green")  "red"]))


; WS -> WS
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick   tock 1]
    [to-draw   render]))

(main ws-red)
