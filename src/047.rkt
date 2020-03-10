#lang htdp/bsl

; Exercise 47.
; ------------
; Design a world program that maintains and displays a “happiness gauge.” Let’s
; call it gauge-prog, and let’s agree that the program consumes the maximum
; level of happiness. The gauge display starts with the maximum score, and with
; each clock tick, happiness decreases by -0.1; it never falls below 0, the
; minimum happiness score. Every time the down arrow key is pressed, happiness
; increases by 1/5; every time the up arrow is pressed, happiness jumps by 1/3.

; To show the level of happiness, we use a scene with a solid, red rectangle
; with a black frame. For a happiness level of 0, the red bar should be gone;
; for the maximum happiness level of 100, the bar should go all the way across
; the scene.

; Note When you know enough, we will explain how to combine the gauge program
; with the solution of exercise 45. Then we will be able to help the cat
; because as long as you ignore it, it becomes less happy. If you pet the cat,
; it becomes happier. If you feed the cat, it becomes much, much happier. So
; you can see why you want to know a lot more about designing world programs
; than these first three chapters can tell you. 
; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

(define BAR-HEIGHT 5)
(define BAR-WIDTH 100) ;; max has to be 100 (the bar width)
(define BAR (empty-scene BAR-WIDTH BAR-HEIGHT))

(define on-tenth (* 1/10 BAR-WIDTH))
(define one-fifth (* 1/5 BAR-WIDTH))
(define one-third (* 1/3 BAR-WIDTH))

; WorldState -> WorldState
; decreases happiness by 1/10 per clock tick
(check-expect (tock 101) 100)
(check-expect (tock 90) 89.9)
(check-expect (tock -0.1) 0)

(define (tock happiness)
  (cond [(negative? happiness) 0]
        [(> happiness BAR-WIDTH) BAR-WIDTH]
        [else (- happiness 0.1)]))

; WorldState -> Image
; renders the bar according to current level of happiness

(check-expect (render 30) (overlay/align "left" "middle" (rectangle 30 BAR-HEIGHT "solid" "red") BAR))
(check-expect (render 300) (overlay/align "left" "middle" (rectangle 300 BAR-HEIGHT "solid" "red") BAR))

(define (render happiness)
  (overlay/align "left" "middle" (rectangle happiness BAR-HEIGHT "solid" "red") BAR))

; WorldState String -> WorldState 
; increases happiness by 1/5 for "down" and 1/3 for "up"

(check-expect (keystroke-handler 100 "down") 120)
(check-expect (keystroke-handler 14 "up") (+ 14 (/ 100 3)))
(check-expect (keystroke-handler 10 "q") 10)

(define (keystroke-handler happiness ke)
  (cond
    [(key=? ke "down") (+ happiness one-fifth)]
    [(key=? ke "up") (+ happiness one-third)]
    [else happiness]))

(define (gauge-prog start-happiness)
  (big-bang start-happiness
    [on-tick tock]
    [to-draw render]
    [on-key keystroke-handler]))

#;
(gauge-prog 10)
