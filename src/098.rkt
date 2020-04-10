;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 98ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 98.
;; ------------
;; Design the function si-game-over? for use as the stop-when handler.
;; The game stops if the UFO lands or if the missile hits the UFO. For both
;; conditions, we recommend that you check for proximity of one object to
;; another.
;;
;; The stop-when clause allows for an optional second sub-expression, namely a
;; function that renders the final state of the game. Design si-render-final
;; and use it as the second part for your stop-when clause in the main function
;; of exercise 100. 
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

; (define UFO-BODY-RADIUS 5)
; (define UFO-BODY (circle UFO-BODY-RADIUS "solid" "green"))

(define UFO-WIDTH 20)
(define UFO-HEIGHT 5)
(define UFO (rectangle UFO-WIDTH UFO-HEIGHT "solid" "green"))

(define MISSILE-WIDTH 3)
(define MISSILE-HEIGHT 10)
(define MISSILE (rectangle MISSILE-WIDTH MISSILE-HEIGHT "solid" "black"))

(define TANK-Y (sub1 (- SCENE-HEIGHT (/ TANK-HEIGHT 2))))
(define UFO-GROUND-Y (sub1 (- SCENE-HEIGHT (/ UFO-HEIGHT 2))))

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

(define sigs1 (make-aim (make-posn 20 10) (make-tank 28 -3)))
(define sigs2 (make-fired (make-posn 20 10)
                          (make-tank 28 -3)
                          (make-posn 28 193)))
(define sigs3 (make-fired (make-posn 20 100)
                          (make-tank 100 3)
                          (make-posn 22 103)))

; SIGS -> Image
; renders the given game state on top of BACKGROUND 

(check-expect (si-render sigs1)
              (place-image TANK
                           28 TANK-Y 
                           (place-image UFO 20 10 BACKG)))


(check-expect (si-render sigs2)
              (place-image TANK
                           28 TANK-Y 
                           (place-image UFO
                                        20 10
                                        (place-image MISSILE
                                                     28 193
                                                     BACKG))))

(check-expect (si-render sigs3)
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


; Ex 98 start

; SIGS -> Boolean
; has the missile hit a UFO or has the UFO touched the ground?
(define (si-game-over? si)
  (or (missile-hit? si)
      (ufo-on-ground? si)))


; SIGS -> UFO
; extracts the UFO from si

(check-expect (get-ufo sigs1) (make-posn 20 10))
(check-expect (get-ufo sigs3) (make-posn 20 100))

(define (get-ufo si)
  (cond
    [(aim? si)   (aim-ufo si)]
    [(fired? si) (fired-ufo si)]))

; SIGS -> Boolean
; is the UFO touching the ground?
(define (ufo-on-ground? si)
  (>= (posn-y (get-ufo si)) UFO-GROUND-Y))

; SIGS -> Boolean
; has the missile hit a UFO?

(check-expect (missile-hit? sigs1) #false)
(check-expect (missile-hit? sigs2) #false)
(check-expect (missile-hit? sigs3) #true)

(define (missile-hit? si)
  (and (fired? si)
       (overlaps? (fired-ufo si) UFO-WIDTH UFO-HEIGHT
                  (fired-missile si)  MISSILE-WIDTH MISSILE-HEIGHT)))

; Posn Posn -> Number
; distance between p1 and p2

(check-within (distance (make-posn 0 1) (make-posn 1 0)) (sqrt 2) 0.0001)
(check-within (distance (make-posn 1 1) (make-posn 1 1)) 0 0.0001)

(define (distance p1 p2)
  (sqrt (+ (sqr (- (posn-x p1) (posn-x p2)))
           (sqr (- (posn-y p1) (posn-y p2))))))

; SIGS -> Image
; the game over image for SIG
(check-expect (si-render-final
               (place-image TANK
                            28 TANK-Y 
                            (place-image UFO 20 10 BACKG)))
              (overlay (text "Goodbye" 36 "indigo") BACKG))

(define (si-render-final s)
  (overlay (text "Goodbye" 36 "indigo") BACKG))