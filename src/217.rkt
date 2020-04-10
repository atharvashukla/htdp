;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 217ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 217
;; ------------
;; Develop a data representation for worms with tails. A worm’s tail is a
;; possibly empty sequence of “connected” segments. Here “connected” means
;; that the coordinates of a segment differ from those of its predecessor
;; in at most one direction. To keep things simple, treat all segments—head
;; and tail segments—the same.
;;
;; Now modify your program from exercise 215 to accommodate a multi-segment
;; worm. Keep things simple: (1) your program may render all worm segments as
;; red disks and (2) ignore that the worm may run into the wall or itself.
;; *Hint* One way to realize the worm’s movement is to add a segment in the
;; direction in which it is moving and to delete the last one. 
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

(define-struct snake-part [dir pos])
; SnakePart is a structure:
;   (make-snake-part Direction Posn)
; interpretation the direction and current position of the snake part

(define SNAKE-PART-LEFT (make-snake-part RIGHT (make-posn 50 250)))
(define SNAKE-PART-RIGHT (make-snake-part RIGHT (make-posn 450 250)))
(define SNAKE-PART-TOP (make-snake-part DOWN (make-posn 250 50)))
(define SNAKE-PART-DOWN (make-snake-part DOWN (make-posn 50 450)))

(define SNAKE-PART-TOP-LEFT (make-snake-part LEFT (make-posn 50 50)))
(define SNAKE-PART-TOP-RIGHT (make-snake-part LEFT (make-posn 450 50)))
(define SNAKE-PART-BOTTOM-LEFT (make-snake-part UP (make-posn 50 450)))
(define SNAKE-PART-BOTTOM-RIGHT (make-snake-part UP (make-posn 450 450)))

(define SNAKE-PART-CENTER (make-snake-part RIGHT (make-posn 250 250)))

; A Snake is one of:
; - '()
; - (cons SnakePart Snake)

(define SNAKE-MID-LEFT
  (list SNAKE-PART-CENTER
        (make-snake-part "right" (make-posn 150 250))
        (make-snake-part "right" (make-posn 50 250))))

; ----------

; The WorldState is a Snake


; Snake -> Image
; renders the full snake by rendering each part

(check-expect (render SNAKE-MID-LEFT)
              (place-image SNAKE 250 250
                           (place-image SNAKE 150 250
                                        (place-image SNAKE 50 250 BACKG))))

(define (render s)
  (cond
    [(empty? s) BACKG]
    [else (render-snake-part (first s) (render (rest s)))]))


; SnakePart -> Image
; renders the snake s onto BACKG

(check-expect (render-snake-part SNAKE-PART-TOP-LEFT BACKG)
              (place-image SNAKE 50 50 BACKG))

(check-expect (render-snake-part SNAKE-PART-CENTER BACKG)
              (place-image SNAKE 250 250 BACKG))

(check-expect (render-snake-part SNAKE-PART-TOP-RIGHT BACKG)
              (place-image SNAKE 450 50 BACKG))

(define (render-snake-part s bg)
  (place-image SNAKE
               (posn-x (snake-part-pos s)) (posn-y (snake-part-pos s))
               bg))

; SnakePart -> SnakePart
; moves the snake in its direction

(check-expect (move-snake-part SNAKE-PART-BOTTOM-LEFT) (make-snake-part UP (make-posn 50 (- 450 SNAKE-STEP))))
(check-expect (move-snake-part SNAKE-PART-TOP) (make-snake-part DOWN (make-posn 250 (+ 50 SNAKE-STEP))))
(check-expect (move-snake-part SNAKE-PART-LEFT) (make-snake-part RIGHT (make-posn (+ 50 SNAKE-STEP ) 250)))
(check-expect (move-snake-part SNAKE-PART-TOP-RIGHT) (make-snake-part LEFT (make-posn (- 450 SNAKE-STEP) 50)))

(define (move-snake-part s)
  (cond
    [(equal? (snake-part-dir s) UP)
     (make-snake-part UP (make-posn (posn-x (snake-part-pos s)) (- (posn-y (snake-part-pos s)) SNAKE-STEP)))]
    [(equal? (snake-part-dir s) DOWN)
     (make-snake-part DOWN (make-posn (posn-x (snake-part-pos s)) (+ (posn-y (snake-part-pos s)) SNAKE-STEP)))]
    [(equal? (snake-part-dir s) LEFT)
     (make-snake-part LEFT (make-posn (- (posn-x (snake-part-pos s)) SNAKE-STEP) (posn-y (snake-part-pos s))))]
    [(equal? (snake-part-dir s) RIGHT)
     (make-snake-part RIGHT (make-posn (+ (posn-x (snake-part-pos s)) SNAKE-STEP ) (posn-y (snake-part-pos s))))]))

; Snake -> Snake
; moves the whole snake by adding a moved part and removing the last part

(check-expect (tock SNAKE-MID-LEFT)
              (list (make-snake-part "right" (make-posn 350 250))
                    (make-snake-part "right" (make-posn 250 250))
                    (make-snake-part "right" (make-posn 150 250))))

(define (tock s)
  (cons (move-snake-part (first s)) (remove-last-part s)))

; NE-List -> NE-List
; removes the last element of the ne-list s
(define (remove-last-part s)
  (cond
    [(empty? (rest s)) '()]
    [else (cons (first s) (remove-last-part (rest s)))]))

; SnakePart KeyEvent -> SnakePart
; changes the direction of the snake

(check-expect (key-h-snake-part SNAKE-PART-BOTTOM-LEFT "down") (make-snake-part DOWN (make-posn 50 450)))
(check-expect (key-h-snake-part SNAKE-PART-DOWN "up") (make-snake-part UP (make-posn 50 450)))
(check-expect (key-h-snake-part SNAKE-PART-RIGHT "left") (make-snake-part LEFT (make-posn 450 250)))
(check-expect (key-h-snake-part SNAKE-PART-LEFT "right") SNAKE-PART-LEFT)
(check-expect (key-h-snake-part SNAKE-PART-LEFT "w") SNAKE-PART-LEFT)

(define (key-h-snake-part s k)
  (cond
    [(key=? k "up") (make-snake-part UP (snake-part-pos s))]
    [(key=? k "down") (make-snake-part DOWN (snake-part-pos s))]
    [(key=? k "left") (make-snake-part LEFT (snake-part-pos s))]
    [(key=? k "right") (make-snake-part RIGHT (snake-part-pos s))]
    [else s]))

; Snake KeyEvent -> Snake
; changes the snake's direction according to the key pressed

(check-expect (key-h SNAKE-MID-LEFT "left")
              (list (make-snake-part "left" (make-posn 250 250))
                    (make-snake-part "right" (make-posn 150 250))
                    (make-snake-part "right" (make-posn 50 250))))

(define (key-h s k)
  (cons (key-h-snake-part (first s) k) (rest s)))

; SnakePart -> Boolean
; has the snake part hit the border?

(check-expect (end?-snake-part (make-snake-part "left" (make-posn -50 250))) #true)
(check-expect (end?-snake-part (make-snake-part "down" (make-posn 50 -1))) #true)
(check-expect (end?-snake-part (make-snake-part "right" (make-posn 501 250))) #true)
(check-expect (end?-snake-part (make-snake-part "right" (make-posn 400 550))) #true)
(check-expect (end?-snake-part (make-snake-part "down" (make-posn 450 450))) #false)
(check-expect (end?-snake-part (make-snake-part "up" (make-posn 250 250))) #false)
(check-expect (end?-snake-part (make-snake-part "left" (make-posn 451 451))) #true)

(define (end?-snake-part s)
  (or (< (posn-x (snake-part-pos s)) (+ 0 SNAKE-RADIUS))
      (< (posn-y (snake-part-pos s)) (+ 0 SNAKE-RADIUS))
      (> (posn-x (snake-part-pos s)) (- SCENE-WIDTH SNAKE-RADIUS))
      (> (posn-y (snake-part-pos s)) (- SCENE-HEIGHT SNAKE-RADIUS))))

; Snake -> Boolean
; has the snake part hit the border?

(check-expect (end? SNAKE-MID-LEFT) #false)
(check-expect (end? (list (make-snake-part "right" (make-posn 451 250))
                          (make-snake-part "right" (make-posn 150 250))
                          (make-snake-part "right" (make-posn 50 250))))
              #true)

(define (end? s)
  (end?-snake-part (first s)))


; WS -> Image
; produces the last image from the WS

(check-expect (worm-hit-border SNAKE-MID-LEFT)
              (overlay (text "worm hit border" 20 "black")
                       (render SNAKE-MID-LEFT)))

(define (worm-hit-border ws)
  (overlay (text "worm hit border" 20 "black")
           (render ws)))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
    [on-tick   tock 0.5]
    [on-key    key-h]
    [to-draw   render]
    [stop-when end? worm-hit-border]))

#;
(main SNAKE-MID-LEFT)