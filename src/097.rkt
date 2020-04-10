;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 97ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 97.
;; ------------
;; Design the functions tank-render, ufo-render, and missile-render. Compare
;; this expression:
;;
;;    (tank-render
;;      (fired-tank s)
;;      (ufo-render (fired-ufo s)
;;                  (missile-render (fired-missile s)
;;                                  BACKGROUND)))
;;
;; with this one
;;
;;    (ufo-render
;;      (fired-ufo s)
;;      (tank-render (fired-tank s)
;;                   (missile-render (fired-missile s)
;;                                   BACKGROUND)))
;;
;; When do the two expressions produce the same result? 
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

; SIGS -> Image
; renders the given game state on top of BACKGROUND 

(check-expect (si-render (make-aim (make-posn 20 10) (make-tank 28 -3)))
              (place-image TANK
                           28 TANK-Y 
                           (place-image UFO 20 10 BACKG)))


(check-expect (si-render (make-fired (make-posn 20 10)
                                     (make-tank 28 -3)
                                     (make-posn 28 193)))
              (place-image TANK
                           28 TANK-Y 
                           (place-image UFO
                                        20 10
                                        (place-image MISSILE
                                                     28 193
                                                     BACKG))))

(check-expect (si-render (make-fired (make-posn 20 100)
                                     (make-tank 100 3)
                                     (make-posn 22 103)))
              (place-image TANK
                           100 TANK-Y 
                           (place-image UFO
                                        20 100
                                        (place-image MISSILE
                                                     22 103
                                                     BACKG))))

(define (si-render s)
  (cond
    [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKG))]
    [(fired? s)
     (tank-render
      (fired-tank s)
      (ufo-render (fired-ufo s)
                  (missile-render (fired-missile s)
                                  BACKG)))]))


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

; Missile Image -> Image 
; adds m to the given image im

(check-expect (missile-render (make-posn 100 100) BACKG)
              (place-image MISSILE 100 100 BACKG))

(define (missile-render m im)
  (place-image MISSILE (posn-x m) (posn-y m) im))


;; ----------

; In the first expression, the TANK will be on top of the
; UFO, and vice versa for the second expression.

; Q. When do the two expressions produce the same result?
; A. When the UFO and TANK don't overlap

