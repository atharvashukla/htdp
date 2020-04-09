#lang htdp/bsl

; Exercise 45.
; ------------
; Design a “virtual cat” world program that continuously moves the cat from
; left to right. Let’s call it cat-prog and let’s assume it consumes the
; starting position of the cat. Furthermore, make the cat move three pixels per
; clock tick. Whenever the cat disappears on the right, it reappears on the
; left. You may wish to read up on the modulo function.
; ------------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; physical constants
(define SCENE-WIDTH 300)
(define SCENE-HEIGHT 200)
(define BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define CAT1 (bitmap "cat1.png"))

(define CAT-HEIGHT (image-height CAT1))
(define CAT-WIDTH (image-width CAT1))
(define CAT-MID-HEIGHT (/ CAT-HEIGHT 2))
(define CAT-MID-WIDTH (/ CAT-WIDTH 2))

; y-coordinate of the proper place of the cat on the scene
; sub1 to not cover the empty-scene edge line by the image
(define Y-POS (sub1 (- SCENE-HEIGHT CAT-MID-HEIGHT)))

; placing the cat image on the scene:
; (place-image CAT1 50 Y-POS BACKGROUND)

; ------------------------------------------------------------------------------

; WorldState ws is a Number
; interpretation represents the distance from the starting position

; WorldState -> Image
; renders the image of the cat according to ws

(check-expect (render 7) (place-image CAT1 7 Y-POS BACKGROUND))
(check-expect (render 40) (place-image CAT1 40 Y-POS BACKGROUND))

(define (render ws)
  (place-image CAT1 ws Y-POS BACKGROUND))

; WorldState -> WorldState
; adds 3 to the ws

(check-expect (tock 10) 13)
(check-expect (tock 0) 3)
(check-expect (tock 300) 303)
(check-expect (tock (+ 300 CAT-MID-WIDTH)) (* -1 CAT-MID-WIDTH))

(define (tock ws)
  (if (>= ws (+ SCENE-WIDTH CAT-MID-WIDTH))
      (- 0 CAT-MID-WIDTH)
      (+ 3 ws)))

; WorldState -> WorldState
; launches the program at starting position of the cat
(define (cat-prog starting-position)
  (big-bang starting-position
    [on-tick tock]
    [to-draw render]))

(cat-prog 0)
