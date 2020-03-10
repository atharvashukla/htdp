#lang htdp/bsl

; Exercise 46.
; ------------
; Improve the cat animation with a slightly different image:
; 
;    (define cat2 <image of a slightly different cat>)
; 
; Adjust the rendering function from exercise 45 so that it uses one cat image
; or the other based on whether the x-coordinate is odd. Read up on odd? in the
; HelpDesk, and use a cond expression to select cat images. 
; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; physical constants
(define SCENE-WIDTH 300)
(define SCENE-HEIGHT 200)
(define BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define CAT1 (bitmap "cat1.png"))
(define CAT2 (bitmap "cat2.png"))

(define CAT-HEIGHT (image-height CAT1))
(define CAT-WIDTH (image-width CAT1))
(define CAT-CENTER-Y-POS (/ CAT-HEIGHT 2))

; y-coordinate of the proper place of the cat on the scene
; sub1 to not cover the empty-scene edge line by the image
(define Y-POS (sub1 (- SCENE-HEIGHT CAT-CENTER-Y-POS)))

; placing the cat image on the scene:
; (place-image CAT1 50 Y-POS BACKGROUND)

; ------------------------------------------------------------------------------

; WorldState ws is a Number
; interpretation represents the distance from the starting position

; WorldState -> Image
; renders the image of the cat according to ws

(check-expect (render 7) (place-image CAT2 7 Y-POS BACKGROUND))
(check-expect (render 40) (place-image CAT1 40 Y-POS BACKGROUND))

(define (render ws)
  (if (odd? ws)
      (place-image CAT2 ws Y-POS BACKGROUND)
      (place-image CAT1 ws Y-POS BACKGROUND)))

; WorldState -> WorldState
; adds 3 to the ws

(check-expect (tock 10) 13)
(check-expect (tock 0) 3)
(check-expect (tock 300) 0)

(define (tock ws)
  (if (>= ws SCENE-WIDTH)
      (modulo ws SCENE-WIDTH)
      (+ 3 ws)))


; WorldState -> WorldState
; launches the program at starting position of the cat
(define (cat-prog starting-position)
  (big-bang starting-position
    [on-tick tock]
    [to-draw render]))

(cat-prog 0)
