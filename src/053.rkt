#lang htdp/bsl

; Exercise 53.
; ------------
;
; An LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight
;
; the word “height” could refer to the distance between the ground and the
; rocket’s point of reference, say, its center
;
; The design recipe for world programs demands that you translate information
; into data and vice versa to ensure a complete understanding of the data
; definition. It’s best to draw some world scenarios and to represent them with
; data and, conversely, to pick some data examples and to draw pictures that
; match them. Do so for the LR definition, including at least HEIGHT and 0 as
; examples.
; ------------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; An LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight


(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)
(define YDELTA 3)
 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
 
(define CENTER (/ (image-height ROCKET) 2))

(define SCN-MID-WIDTH (/ WIDTH 2))

; ------------

(define RESTING-STATE "resting")
(place-image ROCKET SCN-MID-WIDTH (- HEIGHT CENTER) BACKG)

(define FLYING-1 30)
; =>
(place-image ROCKET SCN-MID-WIDTH 30 BACKG)

(define FLYING-2 50)
; =>
(place-image ROCKET SCN-MID-WIDTH 50 BACKG)

(define COUNT-DOWN-1 -1)
; =>
(place-image
 (text "-1" 20 "red")
 20 20
 (place-image
  ROCKET SCN-MID-WIDTH
  (- HEIGHT CENTER) BACKG))

(define COUNT-DOWN-2 -2)
; =>
(place-image
 (text "-2" 20 "red")
 20 20
 (place-image
  ROCKET SCN-MID-WIDTH
  (- HEIGHT CENTER) BACKG))

(define COUNT-DOWN-3 -3)
; =>
(place-image
 (text "-3" 20 "red")
 20 20
 (place-image
  ROCKET SCN-MID-WIDTH
  (- HEIGHT CENTER) BACKG))

(define START 0)
; =>
(place-image ROCKET SCN-MID-WIDTH (- 0 CENTER) BACKG)
;; ^ note the revealing offset

(define END HEIGHT)
; =>
(place-image ROCKET SCN-MID-WIDTH (- HEIGHT CENTER) BACKG)
;; ^ to not sink the rocket
