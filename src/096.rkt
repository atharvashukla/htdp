;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 96ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 96.
;; ------------
;; Sketch how each of the three game states could be rendered assuming a 200 x
;; 200 canvas.
;; -----------------------------------------------------------------------------

(require 2htdp/universe)
(require 2htdp/image)

(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 200)
(define BACKG (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define TANK-WIDTH 20)
(define TANK-HEIGHT 7)
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "blue"))

(define UFO-BODY-RADIUS 5)
(define UFO-BODY (circle UFO-BODY-RADIUS "solid" "green"))

(define UFO-WING-WIDTH 20)
(define UFO-WING-HEIGHT 5)
(define UFO-WING (rectangle UFO-WING-WIDTH UFO-WING-HEIGHT "solid" "green"))

(define UFO (overlay UFO-WING UFO-BODY))
(define UFO-HEIGHT (image-height UFO))
(define UFO-WIDTH (image-width UFO))

(define MISSILE (rectangle 3 10 "solid" "black"))

(define TANK-Y (sub1 (- SCENE-HEIGHT (/ TANK-HEIGHT 2))))

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

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game


(make-aim (make-posn 20 10) (make-tank 28 -3))
(place-image UFO 20 50
             (place-image TANK 28 TANK-Y
                          BACKG))

(make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- SCENE-HEIGHT TANK-HEIGHT)))

(place-image MISSILE 28 (- SCENE-HEIGHT TANK-HEIGHT)
             (place-image UFO 20 10
                          (place-image TANK 28 TANK-Y
                                       BACKG)))


(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103))

(place-image MISSILE 22 103
             (place-image UFO 20 100
                          (place-image TANK 100 TANK-Y
                                       BACKG)))


#;
(place-image BULLET 50 75
             (place-image UFO 50 50
                          (place-image TANK 50 TANK-Y
                                       BACKG)))