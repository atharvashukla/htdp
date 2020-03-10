#lang htdp/bsl

; Exercise 39.
; ------------
; Good programmers ensure that an image such as CAR can be enlarged or reduced
; via a single change to a constant definition.
; We started the development of our car image with a single plain definition:
;
;    (define WHEEL-RADIUS 5)
;
; The definition of WHEEL-DISTANCE is based on the wheel’s radius. Hence,
; changing WHEEL-RADIUS from 5 to 10 doubles the size of the car image. This
; kind of program organization is dubbed single point of control, and good
; design employs this idea as much as possible.
;
; Develop your favorite image of an automobile so that WHEEL-RADIUS remains the
; single point of control. 
; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)


; "single point of control"
;  changing one thing changes everything analogously

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

CAR
