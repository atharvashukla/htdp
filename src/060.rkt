#lang htdp/bsl

; Exercise 60.
; ------------
; An alternative data representation for a traffic light program may use
; numbers instead of strings:
;
;    ; An N-TrafficLight is one of:
;    ; – 0 interpretation the traffic light shows red
;    ; – 1 interpretation the traffic light shows green
;    ; – 2 interpretation the traffic light shows yellow
;
; It greatly simplifies the definition of tl-next:
;
;    ; N-TrafficLight -> N-TrafficLight
;    ; yields the next state, given current state cs
;    (define (tl-next-numeric cs) (modulo (+ cs 1) 3))
;
; Reformulate tl-next’s tests for tl-next-numeric.
;
; Does the tl-next function convey its intention more clearly than
; the tl-next-numeric function? If so, why? If not, why not? 
; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows green
; – 2 interpretation the traffic light shows yellow


(define RED 0)
(define YELLOW 1)
(define GREEN 2)

(define (tl-temp tl)
  (cond
    [(= RED tl) ...]
    [(= YELLOW tl) ...]
    [(= GREEN tl) ...]))


(define empty-tl
  (overlay (rectangle 50 20 "outline" "black")
           (rectangle 56 26 "solid" "transparent")))

(define TL-RADIUS 6)

; N-TrafficLight String -> Image
; makes a bulb for the given tl of radius TL-RADIUS
; with the given mode
(define (make-bulb mode tl)
  (circle TL-RADIUS
          mode
          (cond [(= RED tl) "red"]
                [(= YELLOW tl) "yellow"]
                [(= GREEN tl) "green"])))

(define RED-LIGHT-ON (make-bulb "solid" 0))
(define YELLOW-LIGHT-ON (make-bulb "solid" 2))
(define GREEN-LIGHT-ON (make-bulb "solid" 1))

(define TL-SPACE (square 3 "solid" "transparent"))

(define red-light-off (make-bulb "outline" 0))
(define yellow-light-off (make-bulb "outline" 1))
(define green-light-off (make-bulb "outline" 2))


(define RED-ON
  (overlay (beside RED-LIGHT-ON TL-SPACE yellow-light-off TL-SPACE green-light-off) empty-tl))

(define YELLOW-ON
  (overlay (beside red-light-off TL-SPACE YELLOW-LIGHT-ON TL-SPACE green-light-off) empty-tl))

(define GREEN-ON
  (overlay (beside red-light-off TL-SPACE yellow-light-off TL-SPACE GREEN-LIGHT-ON) empty-tl))



; N-TrafficLight -> TrafficLight
; yields the next state given current state s
(check-expect (tl-next-numeric 0) 1)
(check-expect (tl-next-numeric 1) 2)
(check-expect (tl-next-numeric 2) 0)

; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs
(define (tl-next-numeric cs)
  (modulo (+ cs 1) 3))
 
; N-TrafficLight -> Image
; renders the current state cs as an image

(check-expect (tl-render RED) RED-ON)
(check-expect (tl-render YELLOW) YELLOW-ON)
(check-expect (tl-render GREEN) GREEN-ON)

(define (tl-render current-state)
  (cond
    [(= RED current-state) RED-ON]
    [(= YELLOW current-state) YELLOW-ON]
    [(= GREEN current-state) GREEN-ON]))


; N-TrafficLight -> N-TrafficLight
; simulates a clock-based American traffic light
(define (traffic-light-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next-numeric 1]))


#;
(traffic-light-simulation RED)


; Does the tl-next function convey its intention more clearly than
; the tl-next-numeric function? If so, why? If not, why not?

; No. Because there is an "encoding" involved, which 
; adds a layer of complexity
