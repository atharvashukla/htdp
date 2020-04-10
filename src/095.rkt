;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 95ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 95.
;; ------------
;; Explain why the three instances are generated according to the first or
;; second clause of the data definition. 
;; -----------------------------------------------------------------------------

(require 2htdp/universe)
(require 2htdp/image)

(define SCENE-HEIGHT 200)
(define TANK-HEIGHT 7)

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


;; getting into position
(make-aim (make-posn 20 10) (make-tank 28 -3))

;; -> since the millise hasn't been fired, it does not
;;    need to feature in the representation of the world

;; missile just fired
(make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- SCENE-HEIGHT TANK-HEIGHT)))

;; missile close to being hit
(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103))

;; -> since the missile has been fired, its position needs
;;    to be kept track of.