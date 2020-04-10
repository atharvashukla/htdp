;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 216ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 216
;; ------------
;; Modify your program from exercise 215 so that it stops if the worm has
;; reached the walls of the world. When the program stops because of this
;; condition, it should render the final scene with the text "worm hit border"
;; in the lower left of the world scene. Hint You can use the stop-when clauses
;; in big-bang to render the last world in a special way. 
;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

(define SCENE-HEIGHT 500)
(define SCENE-WIDTH 500)

(define SNAKE-RADIUS 50)
(define FOOD-RADIUS 50)

(define BACKG-COLOR "Dark Yellow")
(define SNAKE-COLOR "Light Brown")
(define FOOD-COLOR"Light Goldenrod")

(define BACKG (rectangle SCENE-WIDTH SCENE-HEIGHT "solid" FOOD-COLOR))
(define SNAKE (circle SNAKE-RADIUS "solid" SNAKE-COLOR))
(define FOOD (circle FOOD-RADIUS "solid" FOOD-COLOR))

(define SNAKE-STEP (* 2 SNAKE-RADIUS))


; WS -> Image
; produces the last image from the WS

(check-expect (worm-hit-border SNAKE-CENTER)
              (overlay (text "worm hit border" 20 "black")
                       (render SNAKE-CENTER)))

(define (worm-hit-border ws)
  (overlay (text "worm hit border" 20 "black")
           (render ws)))

; ----------

; Direction is one of:
; - "up"
; - "down"
; - "left"
; - "right"
; interpretation the current direction of the snake

(define UP "up")
(define DOWN "down")
(define LEFT "left")
(define RIGHT "right")

(define-struct snake [dir pos])
; A Snake is a structure:
;   (make-snake Direction Posn)
; interpretation the direction and current position of the snake

(define SNAKE-LEFT (make-snake RIGHT (make-posn 50 250)))
(define SNAKE-RIGHT (make-snake RIGHT (make-posn 450 250)))
(define SNAKE-TOP (make-snake DOWN (make-posn 250 50)))
(define SNAKE-DOWN (make-snake DOWN (make-posn 50 450)))

(define SNAKE-TOP-LEFT (make-snake LEFT (make-posn 50 50)))
(define SNAKE-TOP-RIGHT (make-snake LEFT (make-posn 450 50)))
(define SNAKE-BOTTOM-LEFT (make-snake UP (make-posn 50 450)))
(define SNAKE-BOTTOM-RIGHT (make-snake UP (make-posn 450 450)))

(define SNAKE-CENTER (make-snake RIGHT (make-posn 250 250)))

; ----------

; The WorldState is a Snake

; Snake -> Image
; renders the snake s onto BACKG

(check-expect (render SNAKE-TOP-LEFT)
              (place-image SNAKE 50 50 BACKG))

(check-expect (render SNAKE-CENTER)
              (place-image SNAKE 250 250 BACKG))

(check-expect (render SNAKE-TOP-RIGHT)
              (place-image SNAKE 450 50 BACKG))

(define (render s)
  (place-image SNAKE
               (posn-x (snake-pos s)) (posn-y (snake-pos s))
               BACKG))

; Snake -> Snake
; moves the snake in its direction

(check-expect (tock SNAKE-BOTTOM-LEFT) (make-snake UP (make-posn 50 (- 450 SNAKE-STEP))))
(check-expect (tock SNAKE-TOP) (make-snake DOWN (make-posn 250 (+ 50 SNAKE-STEP))))
(check-expect (tock SNAKE-LEFT) (make-snake RIGHT (make-posn (+ 50 SNAKE-STEP ) 250)))
(check-expect (tock SNAKE-TOP-RIGHT) (make-snake LEFT (make-posn (- 450 SNAKE-STEP) 50)))

(define (tock s)
  (cond
    [(equal? (snake-dir s) UP)
     (make-snake UP (make-posn (posn-x (snake-pos s)) (- (posn-y (snake-pos s)) SNAKE-STEP)))]
    [(equal? (snake-dir s) DOWN)
     (make-snake DOWN (make-posn (posn-x (snake-pos s)) (+ (posn-y (snake-pos s)) SNAKE-STEP)))]
    [(equal? (snake-dir s) LEFT)
     (make-snake LEFT (make-posn (- (posn-x (snake-pos s)) SNAKE-STEP) (posn-y (snake-pos s))))]
    [(equal? (snake-dir s) RIGHT)
     (make-snake RIGHT (make-posn (+ (posn-x (snake-pos s)) SNAKE-STEP ) (posn-y (snake-pos s))))]))

; Snake KeyEvent -> Snake
; changes the direction of the snake

(check-expect (key-h SNAKE-BOTTOM-LEFT "down") (make-snake DOWN (make-posn 50 450)))
(check-expect (key-h SNAKE-DOWN "up") (make-snake UP (make-posn 50 450)))
(check-expect (key-h SNAKE-RIGHT "left") (make-snake LEFT (make-posn 450 250)))
(check-expect (key-h SNAKE-LEFT "right") SNAKE-LEFT)
(check-expect (key-h SNAKE-LEFT "w") SNAKE-LEFT)

(define (key-h s k)
  (cond
    [(key=? k "up") (make-snake UP (snake-pos s))]
    [(key=? k "down") (make-snake DOWN (snake-pos s))]
    [(key=? k "left") (make-snake LEFT (snake-pos s))]
    [(key=? k "right") (make-snake RIGHT (snake-pos s))]
    [else s]))

; Snake -> Boolean
; has the snake hit the border?

(check-expect (end? (make-snake "left" (make-posn -50 250))) #true)
(check-expect (end? (make-snake "down" (make-posn 50 -1))) #true)
(check-expect (end? (make-snake "right" (make-posn 501 250))) #true)
(check-expect (end? (make-snake "right" (make-posn 400 550))) #true)
(check-expect (end? (make-snake "down" (make-posn 450 450))) #false)
(check-expect (end? (make-snake "up" (make-posn 250 250))) #false)
(check-expect (end? (make-snake "left" (make-posn 451 451))) #true)

(define (end? s)
  (or (< (posn-x (snake-pos s)) (+ 0 SNAKE-RADIUS))
      (< (posn-y (snake-pos s)) (+ 0 SNAKE-RADIUS))
      (> (posn-x (snake-pos s)) (- SCENE-WIDTH SNAKE-RADIUS))
      (> (posn-y (snake-pos s)) (- SCENE-HEIGHT SNAKE-RADIUS))))


; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick   tock 0.5]
    [on-key    key-h]
    [to-draw   render]
    [stop-when end? worm-hit-border]))


(main SNAKE-CENTER)