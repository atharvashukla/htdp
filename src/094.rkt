;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 94ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 94.
;; ------------
;; Draw some sketches of what the game scenery looks like at various stages. Use
;; the sketches to determine the constant and the variable pieces of the game.
;; For the former, develop physical and graphical constants that describe the
;; dimensions of the world (canvas) and its objects. Also develop some
;; background scenery. Finally, create your initial scene from the constants for
;; the tank, the UFO, and the background.
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

(define BULLET (rectangle 3 10 "solid" "black"))

; TANK
; BULLET
; UFO

(define TANK-Y (sub1 (- SCENE-HEIGHT (/ TANK-HEIGHT 2))))


(place-image BULLET 50 75
             (place-image UFO 50 50
                          (place-image TANK 50 TANK-Y
                                       BACKG)))

