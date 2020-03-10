#lang htdp/bsl

; Exercise 56.
; ------------
; Define main2 so that you can launch the rocket and watch it lift off. Read up
; on the on-tick clause to determine the length of one tick and how to change
; it.
;
; If you watch the entire launch, you will notice that once the rocket reaches
; the top something curious happens. Explain. Add a stop-when clause to main2
; so that the simulation of the liftoff stops gracefully when the rocket is out
; of sight. 
; ------------------------------------------------------------------------------


; interpretation of "height"

; 1)
; the word “height” could refer to the distance between the ground and the
; rocket’s point of reference, say, its center;

; 2)
; it could mean the distance between the top of the canvas and the reference
; point.


; Exercise 55 considered the 2nd interpretation. Now we explore the 1st.

(require 2htdp/image)
(require 2htdp/universe)

#;
(define ROCKET (bitmap "rocket.png"))

; dimensions of  the canvas
(define HEIGHT 300) ; distances between the ground and the rocket center
(define WIDTH  100)

; how fast the  rocket moves (along y-axis)
(define YDELTA 3)

(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))

; "computed" center of the rocket (vertically)
(define CENTER (/ (image-height ROCKET) 2))

; Data Definition

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)

; Wish List

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
 (place-image ROCKET 10 (- (- HEIGHT 53) CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- 0 CENTER) BACKG))

(check-expect
 (show HEIGHT)
 (place-image ROCKET 10 (- 0 CENTER) BACKG))

(check-expect
 (show 0)
 (place-image ROCKET 10 (- HEIGHT CENTER) BACKG))


(define (show x)
  (cond
    [(equal? x "resting") (place-rocket-bottom #|HEIGHT|# 0)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-rocket-bottom 0))]
    [(>= x 0) (place-rocket-bottom x)]))


; Number -> Image
; places the  bottom of the rocket at y in scn

(check-expect (place-rocket-bottom 20)
              (place-image ROCKET 10 (- (- HEIGHT 20) CENTER) BACKG))

(define (place-rocket-bottom y)
  (place-image ROCKET 10 (- (- HEIGHT y) CENTER) BACKG))
 
; LRCD KeyEvent -> LRCD
; starts the countdown when space bar is pressed, 
; if the rocket is still resting

(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))


; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) #|HEIGHT|# 0)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) #|HEIGHT|# 0 (+ x 1))]
    [(>= x 0) (+ x YDELTA)]))

; After the rocket reaches the height 0 (from the top)
; it moves on to -1. This state places the  rocket into
; "count-down" mode. So the launch loops again.

(check-expect (stop-rocket -1) #false)
(check-expect (stop-rocket -2) #false)
(check-expect (stop-rocket "resting") #false)
(check-expect (stop-rocket HEIGHT) #true)
(check-expect (stop-rocket 50) #false)

(define (stop-rocket ws)
  (equal? ws HEIGHT))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
    [to-draw show]
    [on-tick fly]
    [stop-when stop-rocket]
    [on-key launch]))

#;
(main2 "resting")


; Comparison with the previous interpretation:

; The height now increases every tick, for placing an image
; at a certain height, it has to be subtracted from the height
; of the canvas. Functionality remains the same.
