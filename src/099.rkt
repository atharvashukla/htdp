;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 99ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 99.
;; ------------
;; Design si-move. This function is called for every clock tick to determine to
;; which position the objects move now. Accordingly, it consumes an element of
;; SIGS and produces another one.
;;
;; Moving the tank and the missile (if any) is relatively straightforward. They
;; move in straight lines at a constant speed. Moving the UFO calls for small
;; random jumps to the left or the right. Since you have never dealt with
;; functions that create random numbers, the rest of this exercise is a longish
;; hint on how to deal with this issue.
;;
;; BSL comes with a function that creates random numbers. Introducing this
;; function illustrates why the signatures and purpose statements play such an
;; important role during the design. Here is the relevant material for the
;; function you need:
;;
;;    ; Number -> Number
;;    ; produces a number in the interval [0,n),
;;    ; possibly a different one each time it is called 
;;    (define (random n) ...)
;;
;; Since the signature and purpose statement precisely describe what a function
;; computes, you can now experiment with random in DrRacket’s interactions area.
;; Stop! Do so!
;;
;; If random produces different numbers (almost) every time it is called,
;; testing functions that use random is difficult. To start with, separate
;; si-move and its proper functionality into two parts:
;;
;;    (define (si-move w)
;;      (si-move-proper w (random ...)))
;;
;;    ; SIGS Number -> SIGS 
;;    ; moves the space-invader objects predictably by delta
;;    (define (si-move-proper w delta)
;;      w)
;;
;; With this definition you separate the creation of a random number from the
;; act of moving the game objects. While random may produce different results
;; every time it is called, si-move-proper can be tested on specific numeric
;; inputs and is thus guaranteed to return the same result when given the same
;; inputs. In short, most of the code remains testable.
;;
;; Instead of calling random directly, you may wish to design a function that
;; creates a random x-coordinate for the UFO. Consider using check-random from
;; BSL’s testing framework to test such a function. 
;; -----------------------------------------------------------------------------

(require 2htdp/universe)
(require 2htdp/image)

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

(define UFO-SPEED 2)
(define MISSILE-SPEED 2)

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
#;
(define (si-move si)
  (cond
    [(aim? si)   (... (aim-ufo si) ... (aim-tank si) ...)]
    [(fired? si) (... (fired-ufo si) ... (fired-tank si) ... (fired-missile si))]))

(define (si-move-proper s d)
  (cond
    [(aim? s)   (make-aim (move-ufo (aim-ufo s) d) (move-tank (aim-tank s)))]
    [(fired? s) (make-fired (move-ufo (fired-ufo s) d) (move-tank (fired-tank s)) (move-missile (fired-missile s)))]))


;; Posn Number -> Posn
;; moves the UFO predictably by d
#;
(define (move-ufo u d)
  (... (...(posn-x u)) (...(posn-y u))))

(check-expect (move-ufo (make-posn 100 100) 4) (make-posn 104 102))
(check-expect (move-ufo (make-posn 100 100) -1) (make-posn 99 102))

(define (move-ufo u d)
  (make-posn (+ (posn-x u) d) (+ (posn-y u) UFO-SPEED)))

;; Tank Number -> Tank
;; moves the tank sideways by the tank-vel
#;
(define (move-tank t)
  (... (...(tank-loc t)) (...(tank-vel t))))

(check-expect (move-tank (make-tank 100 -3)) (make-tank 97 -3))
(check-expect (move-tank (make-tank 100 3)) (make-tank 103 3))

(define (move-tank t)
  (make-tank (+ (tank-loc t) (tank-vel t)) (tank-vel t)))

;; Missile Number -> Missile
;; moves the missile upward to by MISSILE-SPEED
#;
(define (move-missile u)
  (... (...(posn-x u)) (...(posn-y u))))

(check-expect (move-missile (make-posn 100 100)) (make-posn 100 98))
(check-expect (move-missile (make-posn 100 98)) (make-posn 100 96))

(define (move-missile u)
  (make-posn (posn-x u) (- (posn-y u) MISSILE-SPEED)))