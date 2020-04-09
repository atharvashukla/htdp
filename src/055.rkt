#lang htdp/bsl

; Exercise 55.
; ------------
;
; (define (show x)
;   (cond
;     [(string? x)
;      (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
;     [(<= -3 x -1)
;      (place-image (text (number->string x) 20 "red")
;                   10 (* 3/4 WIDTH)
;                   (place-image ROCKET
;                                10 (- HEIGHT CENTER)
;                                BACKG))]
;     [(>= x 0)
;      (place-image ROCKET 10 (- x CENTER) BACKG)]))
;
; Take another look at `show`. It contains three instances of an expression with
; the approximate shape:
;
;     (place-image ROCKET 10 (- ... CENTER) BACKG)
;
; This expression appears three times in the function: twice to draw a resting
; rocket and once to draw a flying rocket. Define an auxiliary function that
; performs this work and thus shorten show. Why is this a good idea? You may
; wish to reread Prologue: How to Program. 
; ------------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

#;
(define ROCKET (bitmap "rocket.png"))

; dimensions of  the canvas
(define HEIGHT 300) ; distances in pixels 
(define WIDTH  100)

; how fast the  rocket moves (along y-axis)
(define YDELTA 3)

(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))

; "computed" center of the rocket (vertically)
(define CENTER (/ (image-height ROCKET) 2))

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)


; LRCD -> Image
; renders the state as a resting or flying rocket

(check-expect
 (show "resting")
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect
 (show -2)
 (place-image (text "-2" 20 "red")
              10 (* 3/4 WIDTH)
              (place-image ROCKET
                           10 (- HEIGHT CENTER)
                           BACKG)))

(check-expect
 (show 53)
 (place-image ROCKET 10 (- 53 CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))

(check-expect
 (show 0)
 (place-image ROCKET 10 (- 0 CENTER) BACKG))

#;; old definition
(define (show x)
  (cond
    [(equal? x "resting")
     (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (- HEIGHT CENTER)
                               BACKG))]
    [(>= x 0)
     (place-image ROCKET 10 (- x CENTER) BACKG)]))

; new
(define (show x)
  (cond
    [(equal? x "resting") (place-rocket-bottom HEIGHT)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket-bottom HEIGHT))]
    [(>= x 0) (place-rocket-bottom x)]))


; Number -> Image
; places the  bottom of the rocket at y in scn

(check-expect (place-rocket-bottom 20)
              (place-image ROCKET 10 (- 20 CENTER) BACKG))

(define (place-rocket-bottom y)
  (place-image ROCKET 10 (- y CENTER) BACKG))
