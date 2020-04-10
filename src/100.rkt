;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 100ex-space-invaders) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 100.
;; -------------
;; Design the function si-control, which plays the role of the key-event
;; handler. As such, it consumes a game state and a KeyEvent and produces a new
;; game state. It reacts to three different keys:
;;
;; - pressing the left arrow ensures that the tank moves left;
;; - pressing the right arrow ensures that the tank moves right; and
;; - pressing the space bar fires the missile if it hasn’t been launched yet.
;;
;; Once you have this function, you can define the si-main function, which uses
;; big-bang to spawn the game-playing window. Enjoy! 
;; -----------------------------------------------------------------------------

(require 2htdp/universe)
(require 2htdp/image)
(require "collision-detection.rkt")

(require "provide.rkt")
(provide si-move si-game-over? si-render si-control)

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

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game


; ---

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

; SIGS -> Image
; the game over image for SIG
(check-expect (si-render-final
               (place-image TANK
                            28 TANK-Y 
                            (place-image UFO 20 10 BACKG)))
              (overlay (text "Goodbye" 36 "indigo") BACKG))

(define (si-render-final s)
  (overlay (text "Goodbye" 36 "indigo") BACKG))

;; SIGS -> SIGS
;; moves the space invader objects
; not testable

(define (si-move w)
  (si-move-proper w (sub1 (random 3))))

; SIGS Number -> SIGS 
; moves the space-invader objects
; and ufo predictably by d

(check-expect (si-move-proper (make-aim (make-posn 50 50) (make-tank 120 -3)) -4)
              (make-aim (make-posn 46 52) (make-tank 117 -3)))
(check-expect (si-move-proper (make-fired (make-posn 50 50) (make-tank 120 -3) (make-posn 5 5)) -4)
              (make-fired (make-posn 46 52) (make-tank 117 -3) (make-posn 5 3)))

; SIGS -> SIGS
; moves the ufo, tank, and missile.

(define (si-move-proper s d)
  (cond
    [(aim? s)   (make-aim (move-ufo (aim-ufo s) d) (move-tank (aim-tank s)))]
    [(fired? s) (make-fired (move-ufo (fired-ufo s) d) (move-tank (fired-tank s)) (move-missile (fired-missile s)))]))


;; Posn Number -> Posn
;; moves the UFO predictably by d

(check-expect (move-ufo (make-posn 100 100) 4) (make-posn 104 102))
(check-expect (move-ufo (make-posn 100 100) -1) (make-posn 99 102))

(define (move-ufo u d)
  (make-posn (+ (posn-x u) d) (+ (posn-y u) UFO-SPEED)))

;; Tank Number -> Tank
;; moves the tank sideways by the tank-vel

(check-expect (move-tank (make-tank 100 -3)) (make-tank 97 -3))
(check-expect (move-tank (make-tank 100 3)) (make-tank 103 3))

(define (move-tank t)
  (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t)))

;; Missile Number -> Missile
;; moves the missile upward to by MISSILE-SPEED

(check-expect (move-missile (make-posn 100 100)) (make-posn 100 98))
(check-expect (move-missile (make-posn 100 98)) (make-posn 100 96))

(define (move-missile u)
  (make-posn (posn-x u) (- (posn-y u) MISSILE-SPEED)))

(define sigs1 (make-aim (make-posn 20 10) (make-tank 28 -3)))
(define sigs2 (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 193)))
(define sigs3 (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))

;; --- Exercise 100 starts here ---

;; SIGS KeyEvent -> SSIG
;; key handler for the game

(check-expect (si-control sigs1 "left")  (make-aim (make-posn 20 10) (make-tank 28 -3)))
(check-expect (si-control sigs1 "right") (make-aim (make-posn 20 10) (make-tank 28 3)))
(check-expect (si-control sigs1 " ") (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 MISSILE-Y-POS)))
(check-expect (si-control sigs1 "e") sigs1)

(check-expect (si-control sigs3 "left")  (make-fired (make-posn 20 100) (make-tank 100 -3) (make-posn 22 103)))
(check-expect (si-control sigs3 "right") (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))
(check-expect (si-control sigs3 " ") sigs3)
(check-expect (si-control sigs3 "e") sigs3)

(define (si-control s ke)
  (cond
    [(aim? s) (si-control-aim s ke)]
    [(fired? s) (si-control-fired s ke)]))

;; SIGS KeyEvent-> SSIG
;; key handler for aim ssig
(define (si-control-aim s ke)
  (cond
    [(string=? ke "right") (make-aim (aim-ufo s)
                                     (make-tank (tank-loc (aim-tank s)) (abs (tank-vel (aim-tank s)))))]
    [(string=? ke "left") (make-aim (aim-ufo s)
                                    (make-tank (tank-loc (aim-tank s)) (* -1 (abs (tank-vel (aim-tank s))))))]
    [(string=? ke " ") (make-fired (aim-ufo s)
                                   (aim-tank s)
                                   (make-posn (tank-loc (aim-tank s)) MISSILE-Y-POS))]
    [else s]))

;; SIGS KeyEvent-> SSIG
;; key handler for fired ssig
(define (si-control-fired s ke)
  (cond
    [(string=? ke "right") (make-fired (fired-ufo s)
                                       (make-tank (tank-loc (fired-tank s)) (abs (tank-vel (fired-tank s))))
                                       (fired-missile s))]
    [(string=? ke "left") (make-fired (fired-ufo s)
                                      (make-tank (tank-loc (fired-tank s)) (* -1 (abs (tank-vel (fired-tank s)))))
                                      (fired-missile s))]
    [(string=? ke " ") s]
    [else s]))


; SIGS -> AIGS
; launches the program with an initial state
(define (main sigs)
  (big-bang sigs
    [on-tick   si-move]
    [stop-when si-game-over?]
    [to-draw   si-render]
    [on-key    si-control]))

#;
(main sigs1)