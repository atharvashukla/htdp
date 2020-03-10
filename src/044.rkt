#lang htdp/bsl

; Sample Problem
; --------------
; Sample Problem Design a program that moves a car across the world canvas,
; from left to right, at the rate of three pixels per clock tick. If the mouse
; is clicked anywhere on the canvas, the car is placed at the x-coordinate of
; that click.
; ------------------------------------------------------------------------------

; Exercise 44.
; ------------
; Formulate the examples as BSL tests. Click RUN and watch them fail.
; ------------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; ----- CONSTANTS -----

(define WIDTH-OF-WORLD 200)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 4))

(define BODY-WIDTH     (* WHEEL-RADIUS 11))
(define BODY-HEIGHT    (* WHEEL-RADIUS 3))
(define TOP-WIDTH      (* WHEEL-RADIUS 7))
(define TOP-HEIGHT     (* WHEEL-RADIUS 1))

(define BODY-COLOR "red")


(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define SPACE
  (rectangle WHEEL-DISTANCE WHEEL-RADIUS  "solid" "white"))

(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))

 
(define BODY
  (rectangle BODY-WIDTH BODY-HEIGHT "solid" BODY-COLOR))

(define TOP
  (rectangle TOP-WIDTH TOP-HEIGHT "solid" BODY-COLOR))

(define CAR
  (above TOP BODY BOTH-WHEELS))


(define tree
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND (overlay/align
                    "center" "bottom"
                    tree
                    (empty-scene WIDTH-OF-WORLD WIDTH-OF-WORLD)))

; added from making the render function
(define CAR-HEIGHT (* 6 WHEEL-RADIUS))
(define CAR-WIDTH  (* 11 WHEEL-RADIUS))
(define Y-CAR (- WIDTH-OF-WORLD (* 1/2 CAR-HEIGHT)))

; WorldState : x location of the center of the car

; ----- ON-TICK ------

; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
(define (tock ws)
  (+ ws 3))


(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

; ----- TO-DRAW ------

; WorldState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
 (define (render ws)
   (place-image CAR ws Y-CAR BACKGROUND))


(check-expect (place-image CAR 50 Y-CAR BACKGROUND) (render 50))
(check-expect (place-image CAR 100 Y-CAR BACKGROUND) (render 100))
(check-expect (place-image CAR 150 Y-CAR BACKGROUND) (render 150))
(check-expect (place-image CAR 200 Y-CAR BACKGROUND) (render 200))


; ----- STOP-WHEN -----

; WorldState -> Boolean
; is the tail of the car at the right edge?
(define (stop? ws)
  (>= ws (+ WIDTH-OF-WORLD (* 1/2 CAR-WIDTH))))

(check-expect (stop? 1000) #true)
(check-expect (stop? 227.5) #true)
(check-expect (stop? 228) #true)
(check-expect (stop? 227) #false)


; ----- BIG-BANG -----
#;
(define (main ws)
   (big-bang ws
     [on-tick tock]
     [stop-when stop?]
     [to-draw render]))

; (main 13)



#|

The expansion:

If the mouse is clicked anywhere on the canvas,
the car is placed at the x-coordinate of that click.
|#

; 1. No  new properties ... no new constants

; 2. The program is still concerned with one property that
;    changes over time. Data representation suffices.

; 3. mouse-event handler

; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"
#;
(define (hyper x-position-of-car x-mouse y-mouse me)
  x-position-of-car)

#| Exercise 44:

These fail

(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)

|#

; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down" 
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
; given: 42 10 20 "move"
; wanted: 42

(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))


(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)


; 4. modify main
(define (main ws)
  (big-bang ws
    [on-tick tock]
    [on-mouse hyper]
    [to-draw render]))

(main 13)
