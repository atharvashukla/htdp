#lang htdp/bsl

; Exercise 42.
; ------------
; Modify the interpretation of the sample data definition so that a state 
; denotes the x-coordinate of the right-most edge of the car.
; ------------------------------------------------------------------------------

; Exercise 41.
; ------------
; Finish the sample problem and get the program to run. That is, assuming
; that you have solved exercise 39, define the constants BACKGROUND and Y-CAR.
; Then assemble all the function definitions, including their tests. When your
; program runs to your satisfaction, add a tree to the scenery. We used
;
;    (define tree
;      (underlay/xy (circle 10 "solid" "green")
;                   9 15
;                   (rectangle 2 20 "solid" "brown")))
;
; to create a tree-like shape. Also add a clause to the big-bang expression
; that stops the animation when the car has disappeared on the right side. 
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

; WorldState : x location of the right edge of the car

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
   (place-image CAR (- ws (* 1/2 CAR-WIDTH)) Y-CAR BACKGROUND))


(check-expect (place-image CAR 22.5 Y-CAR BACKGROUND) (render 50))
(check-expect (place-image CAR 72.5 Y-CAR BACKGROUND) (render 100))
(check-expect (place-image CAR 122.5 Y-CAR BACKGROUND) (render 150))
(check-expect (place-image CAR 172.5 Y-CAR BACKGROUND) (render 200))


; ----- STOP-WHEN -----

; WorldState -> Boolean
; is the tail of the car at the right edge?
(define (stop? ws)
  (>= ws (+ WIDTH-OF-WORLD CAR-WIDTH)))

(check-expect (stop? 1000) #true)
(check-expect (stop? 255)  #true)
(check-expect (stop? 227)  #false)


; ----- BIG-BANG -----

(define (main ws)
   (big-bang ws
     [on-tick tock]
     [stop-when stop?]
     [to-draw render]))

(main 13)
