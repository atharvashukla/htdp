;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 102ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 102.
;; -------------
;; Design all other functions that are needed to complete the game for this
;; second data definition.
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
#;
(define (missile-render.v2 m s)
  s)


#;
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) ...]
    [(posn? m) ...]))

#;
(define (missile-render.v2 m s)
  (cond
    [(boolean? m) ...]
    [(posn? m) (... (posn-x m) ... (posn-y m) ...)]))

(define (missile-render.v2 m s)
  (cond
    [(boolean? m) s]
    [(posn? m)
     (place-image MISSILE (posn-x m) (posn-y m) s)]))


; ----------
; Adding all the other functions:
; ----------

; SIGS -> Boolean
; has the missile hit a UFO or has the UFO touched the ground?
(define (si-game-over? si)
  (or (missile-hit? si)
      (ufo-on-ground? si)))


; SIGS -> Boolean
; is the UFO touching the ground?
(define (ufo-on-ground? si)
  (>= (posn-y (sigs-ufo si)) UFO-GROUND-Y))

; SIGS -> Boolean
; has the missile hit a UFO?

(check-expect (missile-hit? sigs1) #false)
(check-expect (missile-hit? sigs2) #false)
(check-expect (missile-hit? sigs3) #true)

(define (missile-hit? si)
  (and (posn? (sigs-missile si))
       (overlaps? (sigs-ufo si) UFO-WIDTH UFO-HEIGHT
                  (sigs-missile si)  MISSILE-WIDTH MISSILE-HEIGHT)))

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

(check-expect (si-move-proper (make-sigs (make-posn 50 50) (make-tank 120 -3) #f) -4)
              (make-sigs (make-posn 46 52) (make-tank 117 -3) #f))
(check-expect (si-move-proper (make-sigs (make-posn 50 50) (make-tank 120 -3) (make-posn 5 5)) -4)
              (make-sigs (make-posn 46 52) (make-tank 117 -3) (make-posn 5 3)))

; SIGS -> SIGS
; moves the ufo, tank, and missile.

(define (si-move-proper s d)
  (make-sigs (move-ufo (sigs-ufo s) d) (move-tank (sigs-tank s)) (move-missile (sigs-missile s))))


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

;; MissileOrNot Number -> Missile
;; moves the missile upward to by MISSILE-SPEED

(check-expect (move-missile (make-posn 100 100)) (make-posn 100 98))
(check-expect (move-missile (make-posn 100 98)) (make-posn 100 96))

(define (move-missile u)
  (cond
    [(boolean? u) u]
    [(posn? u) (make-posn (posn-x u) (- (posn-y u) MISSILE-SPEED))]))

(define sigs1 (make-sigs (make-posn 20 10) (make-tank 28 -3) #f))
(define sigs2 (make-sigs (make-posn 20 10) (make-tank 28 -3) (make-posn 28 193)))
(define sigs3 (make-sigs (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))

;; --- Exercise 100 starts here ---

;; SIGS KeyEvent -> SSIG
;; key handler for the game

(check-expect (si-control sigs1 "left")  (make-sigs (make-posn 20 10) (make-tank 28 -3) #f))
(check-expect (si-control sigs1 "right") (make-sigs (make-posn 20 10) (make-tank 28 3) #f))
(check-expect (si-control sigs1 " ") (make-sigs (make-posn 20 10) (make-tank 28 -3) (make-posn 28 MISSILE-Y-POS)))
(check-expect (si-control sigs1 "e") sigs1)

(check-expect (si-control sigs3 "left")  (make-sigs (make-posn 20 100) (make-tank 100 -3) (make-posn 22 103)))
(check-expect (si-control sigs3 "right") (make-sigs (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))
(check-expect (si-control sigs3 " ") sigs3)
(check-expect (si-control sigs3 "e") sigs3)

(define (si-control s ke)
  (cond
    [(string=? ke "right") (make-sigs (sigs-ufo s)
                                      (make-tank (tank-loc (sigs-tank s)) (abs (tank-vel (sigs-tank s))))
                                      (sigs-missile s))]
    [(string=? ke "left") (make-sigs (sigs-ufo s)
                                     (make-tank (tank-loc (sigs-tank s)) (* -1 (abs (tank-vel (sigs-tank s)))))
                                     (sigs-missile s))]
    [(string=? ke " ") (if (boolean? (sigs-missile s))
                           (make-sigs (sigs-ufo s)
                                      (sigs-tank s)
                                      (make-posn (tank-loc (sigs-tank s)) MISSILE-Y-POS))
                           s)]
    [else s]))


; SIGS -> AIGS
; launches the program with an initial state
(define (main sigs)
  (big-bang sigs
    [on-tick   si-move]
    [stop-when si-game-over?]
    [to-draw   si-render.v2]
    [on-key    si-control]))

#;
(main sigs1)