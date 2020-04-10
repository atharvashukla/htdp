;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 101ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 101.
;; -------------
;; Turn the examples in figure 35 into test cases.
;; -----------------------------------------------------------------------------

(require 2htdp/universe)
(require 2htdp/image)
(require "collision-detection.rkt")

(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 200)
(define BACKG (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define TANK-WIDTH 20)
(define TANK-HEIGHT 7)
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "blue"))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 5)
(define UFO (rectangle UFO-WIDTH UFO-HEIGHT "solid" "green"))

(define MISSILE-WIDTH 3)
(define MISSILE-HEIGHT 10)
(define MISSILE (rectangle MISSILE-WIDTH MISSILE-HEIGHT "solid" "black"))

(define TANK-Y (sub1 (- SCENE-HEIGHT (/ TANK-HEIGHT 2))))
(define UFO-GROUND-Y (sub1 (- SCENE-HEIGHT (/ UFO-HEIGHT 2))))

(define UFO-SPEED 2)
(define MISSILE-SPEED 2)

(define MISSILE-Y-POS (- SCENE-HEIGHT (+ TANK-HEIGHT (/ MISSILE-HEIGHT 2))))

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

;; ---

(define-struct sigs [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location


; From Figure 34 (given)

; SIGS.v2 -> Image 
; renders the given game state on top of BACKG 
(define (si-render.v2 s)
  (tank-render
   (sigs-tank s)
   (ufo-render (sigs-ufo s)
               (missile-render.v2 (sigs-missile s)
                                  BACKG))))


; Helpers from Exercise 97:

; Tank Image -> Image 
; adds t to the given image im

(check-expect (tank-render (make-tank 23 -3) BACKG)
              (place-image TANK 23 TANK-Y BACKG))

(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))
 
; UFO Image -> Image 
; adds u to the given image im

(check-expect (ufo-render (make-posn 100 100) BACKG)
              (place-image UFO 100 100 BACKG))

(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

; MissileOrNot Image -> Image 
; adds an image of missile m to the given image s

(check-expect (missile-render.v2 (make-posn 100 100) BACKG)
              (place-image MISSILE 100 100 BACKG))

(check-expect (missile-render.v2 #false (tank-render (make-tank 50 3) (ufo-render (make-posn 50 50) BACKG)))
              (tank-render (make-tank 50 3) (ufo-render (make-posn 50 50) BACKG)))

(check-expect (missile-render.v2 (make-posn 32 (- SCENE-HEIGHT TANK-HEIGHT 10))
                                 (tank-render (make-tank 50 3) (ufo-render (make-posn 50 50) BACKG)))
              (tank-render (make-tank 50 3)
                           (ufo-render (make-posn 50 50)
                                       (place-image MISSILE 32 (- SCENE-HEIGHT TANK-HEIGHT 10)
                                                    BACKG))))
#;; just a stub
(define (missile-render.v2 m s)
  s)