;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 224ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 224
;; ------------
;; Use the lessons learned from the preceding two sections and design the game
;; extension slowly, adding one feature of the game after another. Always use
;; the design recipe and rely on the guidelines for auxiliary functions. If you
;; like the game, add other features: show a running text; equip the UFO with
;; charges that can eliminate the tank; create an entire fleet of attacking
;; UFOs; and above all, use your imagination. 
;; -----------------------------------------------------------------------------

(require 2htdp/universe)
(require 2htdp/image)
(require "collision-detection.rkt")

; ----------------------------- CONSTANTS -----------------------------

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

; -------------------------- DATA DEFINITIONS -------------------------

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

(define-struct sigs [ufo tank missile])
; A SIGS (actually SIGS version 2) is a structure:
;   (make-sigs UFO Tank List-of-missiles)
; interpretation represents the complete state of a
; space invader game
 
; List-of-missiles is one of
; - '()
; - (cons Missile List-of-missiles)
; interpretation the missiles in the air

; Examples

(define sigs1 (make-sigs (make-posn 20 10) (make-tank 28 -3) '()))
(define sigs2 (make-sigs (make-posn 20 10) (make-tank 28 -3) (list (make-posn 28 193))))
(define sigs3 (make-sigs (make-posn 20 100) (make-tank 100 3) (list (make-posn 22 103))))


; ------------------------------ BIG-BANG -----------------------------

; SIGS -> SIGS
; launches the program with an initial state
(define (main sigs)
  (big-bang sigs
    [on-tick   si-move]
    [stop-when si-game-over?]
    [to-draw   si-render]
    [on-key    si-control]))

; ------------------------------ TO-DRAW ------------------------------

; SIGS -> Image 
; renders the given game state on top of BACKG 
(define (si-render s)
  (tank-render
   (sigs-tank s)
   (ufo-render (sigs-ufo s)
               (all-missiles-render (sigs-missile s)
                               BACKG))))

; Tank Image -> Image 
; adds t to the given image im
(define (tank-render t im)
  (place-image TANK (tank-loc t) TANK-Y im))
 
; UFO Image -> Image 
; adds u to the given image im
(define (ufo-render u im)
  (place-image UFO (posn-x u) (posn-y u) im))

; List-of-missiles -> Image
; renders all the missiles in lom
(define (all-missiles-render lom s)
  (cond
    [(empty? lom) s]
    [else (missile-render (first lom)
                          (all-missiles-render (rest lom) s))]))

; Missile Image -> Image 
; renders the missile m onto the background s
(define (missile-render m s)
  (place-image MISSILE (posn-x m) (posn-y m) s))


(check-expect (tank-render (make-tank 23 -3) BACKG)
              (place-image TANK 23 TANK-Y BACKG))
(check-expect (ufo-render (make-posn 100 100) BACKG)
              (place-image UFO 100 100 BACKG))
(check-expect (all-missiles-render '() BACKG) BACKG)
(check-expect (all-missiles-render (list (make-posn 5 5)) BACKG) (place-image MISSILE 5 5 BACKG))
(check-expect (all-missiles-render (list (make-posn 5 5) (make-posn 10 10)) BACKG)
              (place-image MISSILE 5 5 (place-image MISSILE 10 10 BACKG)))
(check-expect (missile-render (make-posn 100 100) BACKG)
              (place-image MISSILE 100 100 BACKG))

(check-expect (si-render (make-sigs (make-posn 50 50) (make-tank 50 3) '()))
              (tank-render (make-tank 50 3)
                           (ufo-render (make-posn 50 50)
                                       BACKG)))

(check-expect (si-render (make-sigs (make-posn 50 50) (make-tank 50 3) (list (make-posn 32 33))))
              (tank-render (make-tank 50 3)
                           (ufo-render (make-posn 50 50)
                                       (place-image MISSILE 32 33 BACKG))))

; ------------------------------ ON-KEY -------------------------------

;; SIGS KeyEvent -> SSIG
;; key handler for the game

(define (si-control s ke)
  (cond
    [(string=? ke "left")  (si-left s)]
    [(string=? ke "right") (si-right s)]
    [(string=? ke " ") (shoot-missile s)]
    [else s]))

; SIGS -> SIGS
; turn tank to the left
(define (si-left s)
  (make-sigs (sigs-ufo s)
             ; make tank-dir negative
             (make-tank (tank-loc (sigs-tank s)) (* -1 (abs (tank-vel (sigs-tank s)))))
             (sigs-missile s)))

; SIGS -> SIGS
; turn tank to the right
(define (si-right s)
  (make-sigs (sigs-ufo s)
             ; make tank-dir positive
             (make-tank (tank-loc (sigs-tank s)) (abs (tank-vel (sigs-tank s))))
             (sigs-missile s)))


; SIGS -> SIGS
; shoot a missile
(define (shoot-missile s)
  (make-sigs (sigs-ufo s)
             (sigs-tank s)
             ; cons a new missile to the existing ones
             (cons (make-posn (tank-loc (sigs-tank s)) MISSILE-Y-POS) (sigs-missile s))))

(check-expect (si-control sigs1 "left")  (make-sigs (make-posn 20 10) (make-tank 28 -3) '()))
(check-expect (si-control sigs1 "right") (make-sigs (make-posn 20 10) (make-tank 28 3) '()))
(check-expect (si-control sigs1 " ") (make-sigs (make-posn 20 10) (make-tank 28 -3) (list (make-posn 28 MISSILE-Y-POS))))
(check-expect (si-control sigs1 "e") sigs1)

(check-expect (si-control sigs3 "left")  (make-sigs (make-posn 20 100) (make-tank 100 -3) (list (make-posn 22 103))))
(check-expect (si-control sigs3 "right") (make-sigs (make-posn 20 100) (make-tank 100 3) (list (make-posn 22 103))))
(check-expect (si-control sigs3 " ") (make-sigs (make-posn 20 100) (make-tank 100 3)
                                                (list (make-posn 100 188) (make-posn 22 103))))
(check-expect (si-control sigs3 "e") sigs3)

; ------------------------------ ON-TICK ------------------------------

;; SIGS -> SIGS
;; moves the space invader objects
; not testable

(define (si-move w)
  (si-move-proper w (sub1 (random 3))))

; SIGS Number -> SIGS 
; moves the space-invader objects
; and ufo predictably by d
(define (si-move-proper s d)
  (make-sigs (move-ufo (sigs-ufo s) d) (move-tank (sigs-tank s)) (move-all-missiles (sigs-missile s))))

;; Posn Number -> Posn
;; moves the UFO predictably by d
(define (move-ufo u d)
  (make-posn (+ (posn-x u) d) (+ (posn-y u) UFO-SPEED)))

;; Tank Number -> Tank
;; moves the tank sideways by the tank-vel
(define (move-tank t)
  (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t)))

;; Missile -> Missile
;; moves the missile upward to by MISSILE-SPEED
(define (move-missile u)
  (make-posn (posn-x u) (- (posn-y u) MISSILE-SPEED)))

;; List-of-missiles -> List-of-missile
;; moves all missiles in lom
(define (move-all-missiles lom)
  (cond
    [(empty? lom) '()]
    [else  (cons (move-missile (first lom))
                 (move-all-missiles (rest lom)))]))


(check-random (si-move sigs1) (si-move-proper sigs1 (sub1 (random 3))))
(check-random (si-move sigs2) (si-move-proper sigs2 (sub1 (random 3))))

(check-expect (si-move-proper (make-sigs (make-posn 50 50) (make-tank 120 -3) '()) -4)
              (make-sigs (make-posn 46 52) (make-tank 117 -3) '()))

(check-expect (si-move-proper (make-sigs (make-posn 50 50) (make-tank 120 -3) (list (make-posn 5 5))) -4)
              (make-sigs (make-posn 46 52) (make-tank 117 -3) (list (make-posn 5 3))))

(check-expect (move-ufo (make-posn 100 100) 4) (make-posn 104 102))
(check-expect (move-ufo (make-posn 100 100) -1) (make-posn 99 102))

(check-expect (move-tank (make-tank 100 -3)) (make-tank 97 -3))
(check-expect (move-tank (make-tank 100 3)) (make-tank 103 3))

(check-expect (move-missile (make-posn 100 100)) (make-posn 100 98))
(check-expect (move-missile (make-posn 100 98)) (make-posn 100 96))

; ------------------------------ STOP-WHEN ----------------------------

; SIGS -> Boolean
; has the missile hit a UFO or has the UFO touched the ground?
(define (si-game-over? si)
  (or (any-missile-hit? (sigs-ufo si) (sigs-missile si))
      (ufo-on-ground? si)))

; SIGS -> Boolean
; is the UFO touching the ground?
(define (ufo-on-ground? si)
  (>= (posn-y (sigs-ufo si)) UFO-GROUND-Y))

; UFO Missile -> Boolean
; has the missile hit a ufo?
(define (missile-hit? ufo missile)
  (overlaps? ufo UFO-WIDTH UFO-HEIGHT
             missile  MISSILE-WIDTH MISSILE-HEIGHT))

; List-of-missiles -> List-of-missiles
; has any of the missiles hit the ufo?
(define (any-missile-hit? ufo lom)
  (cond
    [(empty? lom) #false]
    [else (or (missile-hit? ufo (first lom))
              (any-missile-hit? ufo (rest lom)))]))

(check-expect (si-game-over? sigs1) #false)
(check-expect (si-game-over? sigs2) #false)
(check-expect (si-game-over? sigs3) #true)

; ------------------------------ FINAL-RENDER -------------------------

; SIGS -> Image
; the game over image for SIG
(check-expect (si-render-final
               (place-image TANK
                            28 TANK-Y 
                            (place-image UFO 20 10 BACKG)))
              (overlay (text "Goodbye" 36 "indigo") BACKG))

(define (si-render-final s)
  (overlay (text "Goodbye" 36 "indigo") BACKG))


; -------------------------------- MAIN -------------------------------

#;(main sigs1)
