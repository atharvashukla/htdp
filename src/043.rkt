#lang htdp/bsl

; Exercise 43.
; ------------
; Let’s work through the same problem statement with a time-based data
; definition:
;
;    ; An AnimationState is a Number.
;    ; interpretation the number of clock ticks 
;    ; since the animation started
;
; Like the original data definition, this one also equates the states of the
; world with the class of numbers. Its interpretation, however, explains that
; the number means something entirely different.
;
; Design the functions tock and render. Then develop a big-bang expression so
; that once again you get an animation of a car traveling from left to right
; across the world’s canvas.
;
; How do you think this program relates to animate from Prologue: How to
; Program
;
; Use the data definition to design a program that moves the car according to
; a sine wave. (Don’t try to drive like that.) 
;
; -----------------------------------------------------------------------------


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

;    ; An AnimationState is a Number.
;    ; interpretation the number of clock ticks 
;    ; since the animation started

; ----- ON-TICK ------

; AnimationState -> AnimationState 
; increases the # of clock tick by 1 per clock tick
(define (tock ws)
  (+ ws 1))


(check-expect (tock 20) 21)
(check-expect (tock 78) 79)

; ----- TO-DRAW ------

; Velocity
(define V 3)

; Number -> number
; distance is velocity times time
(define (distance t)
  (* V t))

; AnimationState -> Image
; places the car into the BACKGROUND scene,
; according to the given world state 
 (define (render ws)
   (place-image CAR (distance ws) Y-CAR BACKGROUND))


(check-expect (place-image CAR 150 Y-CAR BACKGROUND) (render 50))
(check-expect (place-image CAR 300 Y-CAR BACKGROUND) (render 100))
(check-expect (place-image CAR 450 Y-CAR BACKGROUND) (render 150))
(check-expect (place-image CAR 600 Y-CAR BACKGROUND) (render 200))


; ----- STOP-WHEN -----

; AnimationState -> Boolean
; is the tail of the car at the right edge?
(define (stop? ws)
  (>= (distance ws) (+ WIDTH-OF-WORLD (* 1/2 CAR-WIDTH))))

(check-expect (stop? (distance 1000)) #true)
(check-expect (stop? (distance 1)) #false)
(check-expect (stop? 66) #false)



; ----- BIG-BANG -----

(define (main ws)
   (big-bang ws
     [on-tick tock]
     [stop-when stop?]
     [to-draw render]))

(main 13)


; How do you think this program relates to
; animate from Prologue: How to Program?

; This program has a car that moves horizontally
; instead of a rocket that moves vertically. More
; importantly, this program is "designed" not "hacked"


; Use the data definition to design a program that
; moves the car according to a sine wave. (Don’t try
; to drive like that.)

; see 43ex-sin.rkt
