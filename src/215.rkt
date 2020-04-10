;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 215ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 215
;; ------------
;; Design a world program that continually moves a one-segment worm and enables
;; a player to control the movement of the worm with the four cardinal arrow
;; keys. Your program should use a red disk to render the one-and-only segment
;; of the worm. For each clock tick, the worm should move a diameter.
;;
;; Hints (1) Reread Designing World Programs to recall how to design world
;; programs. When you define the worm-main function, use the rate at which the
;; clock ticks as its argument. See the documentation for on-tick on how to
;; describe the rate. (2) When you develop a data representation for the worm,
;; contemplate the use of two different kinds of representations: a physical
;; representation and a logical one. The physical representation keeps track
;; of the actual physical position of the worm on the canvas; the logical one
;; counts how many (widths of) segments the worm is from the left and the top.
;; For which of the two is it easier to change the physical appearances (size
;; of worm segment, size of game box) of the “game”? 
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


; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick   tock 0.5]
    [on-key    key-h]
    [to-draw   render]))

#;
(main SNAKE-CENTER)