;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 113ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 113.
;; -------------
;; Design predicates for the following data definitions from the preceding
;; section: SIGS, Coordinate (exercise 105), and VAnimal. 
;; -----------------------------------------------------------------------------

(require "provide.rkt")
(provide sigs?? vanimal?)

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
(define sigs2 (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 193)))
(define sigs3 (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))

(define not-sigs1 (make-aim (make-posn 20 10) (make-posn 28 -3)))
(define not-sigs2 (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn "28" 193)))
(define not-sigs3 (make-fired 1 (make-tank 100 3) (make-posn 22 103)))

(check-expect (sigs?? sigs1) #true)
(check-expect (sigs?? sigs2) #true)
(check-expect (sigs?? sigs3) #true)

(check-expect (sigs?? not-sigs1) #false)
(check-expect (sigs?? not-sigs2) #false)
(check-expect (sigs?? not-sigs3) #false)

; Any -> Boolean
; a recognizer for sigs
(define (sigs?? s)
  (or (aim?? s) (fired?? s)))

; Any -> Boolean
; recognizer for Aim
(define (aim?? a)
  (and (aim? a)
       (ufo?? (aim-ufo a))
       (tank?? (aim-tank a))))

; Any -> Boolean
; recognizer for Fired
(define (fired?? a)
  (and (fired? a)
       (ufo?? (fired-ufo a))
       (tank?? (fired-tank a))
       (missile?? (fired-missile a))))

; Any -> Boolean
; recognizer for a UFO
(define (ufo?? a)
  (posn?? a))

; Any -> Boolean
; recognizer for a Tank
(define (tank?? a)
  (and (tank? a)
       (number? (tank-loc a))
       (number? (tank-vel a))))

; Any -> Boolean
; recognizer for a Missile
(define (missile?? a)
  (posn?? a))

; Any -> Boolean
; recognizer for a Posn 
(define (posn?? p)
  (and (posn? p)
       (number? (posn-x p))
       (number? (posn-y p))))

;; -----------------------------------------------------------------------------

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

; Any -> Boolean
; a recognizer for coordinate

(check-expect (coordinate? (make-posn 1 2)) #true)
(check-expect (coordinate? -1) #true)
(check-expect (coordinate? 1) #true)
(check-expect (coordinate? #true) #false)
(check-expect (coordinate? "coordinate") #false)

(define (coordinate? c)
  (or (number? c) (posn? c)))

;; -----------------------------------------------------------------------------

; Dir is one of
; - "left"
; - "right"

(define-struct vcat [x happiness dir])
; VCat is a struct
;   (make-vcat Number [0, 100] Dir)
; interp. x is the x-coordinate
; happiness is the % happiness
; dir is the direction of the cat

; Color [String] is one of
; - "red"
; - "blue"
; - "green"

(define-struct vcham [x happiness dir color])
; vcham is a struct
;   (make-vcham Number [0, 100] Dir)
; interp. x is the x-coordinate
; happiness is the % happiness
; dir is the direction of the cham
; color is the color of the cham

; VAnimal is one of:
; - VCham
; - VCat

(define va1 (make-vcat 20 100 "left"))
(define va2 (make-vcham 40 55 "right" "red"))
(define va3 (make-vcham 40 55 "left" "blue"))

(define not-va1 (make-vcat 20 101 "left"))
(define not-va2 (make-vcham 40 55 "up" "red"))
(define not-va3 (make-vcham 40 55 "left" "orange"))

(check-expect (vanimal? va1) #true)
(check-expect (vanimal? va2) #true)
(check-expect (vanimal? va3) #true)
(check-expect (vanimal? not-va1) #false)
(check-expect (vanimal? not-va2) #false)
(check-expect (vanimal? not-va3) #false)

; Any -> Boolean
; recognizer for VAnimal
(define (vanimal? va)
  (or (vcat?? va)
      (vcham?? va)))

; Any -> Boolean
; recognizer for Color
(define (color?? c)
  (or (string=? c "red")
      (string=? c "blue")
      (string=? c "green")))

; Any -> Boolean
; recognizer for Dir
(define (dir? d)
  (or (string=? d "left")
      (string=? d "right")))

; Any -> Boolean
; recognizer for VCat
(define (vcat?? vc)
  (and (vcat? vc)
       (number? (vcat-x vc))
       (and (number? (vcat-happiness vc))
            (<= 0 (vcat-happiness vc) 100))
       (dir? (vcat-dir vc))))

; Any -> Boolean
; recognizer for VCham
(define (vcham?? vc)
  (and (vcham? vc)
       (number? (vcham-x vc))
       (and (number? (vcham-happiness vc))
            (<= 0 (vcham-happiness vc) 100))
       (dir? (vcham-dir vc))
       (color?? (vcham-color vc))))