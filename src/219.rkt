;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 219ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 219
;; ------------
;; Equip your program from exercise 218 with food. At any point in time, the box
;; should contain one piece of food. To keep things simple, a piece of food is
;; of the same size as a worm segment. When the worm’s head is located at the
;; same position as the food, the worm eats the food, meaning the worm’s tail is
;; extended by one segment. As the piece of food is eaten, another one shows up
;; at a different location.
;;
;; Adding food to the game requires changes to the data representation of world
;; states. In addition to the worm, the states now also include a representation
;; of the food, especially its current location. A change to the game
;; representation suggests new functions for dealing with events, though these
;; functions can reuse the functions for the worm (from exercise 218) and their
;; test cases. It also means that the tick handler must not only move the worm;
;; in addition it must manage the eating process and the creation of new food.
;;
;; Your program should place the food randomly within the box. To do so
;; properly, you need a design technique that you haven’t seen before—so-called
;; generative recursion, which is introduced in Generative Recursion—so we
;; provide these functions in figure 80. Before you use them, however, explain
;; how these functions work—assuming MAX is greater than 1—and then formulate
;; purpose statements.
;;
;; *Hints* (1) One way to interpret “eating” is to say that the head moves where
;; the food used to be located and the tail grows by one segment, inserted where
;; the head used to be. Why is this interpretation easy to design as a function?
;; (2) We found it useful to add a second parameter to the worm-main function
;; for this last step, a Boolean that determines whether big-bang displays the
;; current state of the world in a separate window; see the documentation for
;; state on how to ask for this information.
;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

(define SCENE-HEIGHT 500)
(define SCENE-WIDTH 500)

(define SNAKE-RADIUS 5)
(define FOOD-RADIUS 5)

(define BACKG-COLOR "Dark Yellow")
(define SNAKE-COLOR "Light Brown")
(define FOOD-COLOR"Light Goldenrod")

(define BACKG (rectangle SCENE-WIDTH SCENE-HEIGHT "solid" BACKG-COLOR))
(define SNAKE (circle SNAKE-RADIUS "solid" SNAKE-COLOR))
(define FOOD (circle FOOD-RADIUS "solid" FOOD-COLOR))
(define SNAKE-MOUTH (circle SNAKE-RADIUS "solid" "Dark Brown"))

(define SNAKE-DIAMETER (* 2 SNAKE-RADIUS))
(define SNAKE-STEP SNAKE-DIAMETER)

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

; for making it eat itself
(define BIG-SNAKE
  (list
   (make-snake-part DOWN (make-posn 50 50))
   (make-snake-part LEFT (make-posn 150 50))
   (make-snake-part LEFT (make-posn 250 50))
   (make-snake-part LEFT (make-posn 350 50))
   (make-snake-part UP (make-posn 350 150))
   (make-snake-part UP (make-posn 350 250))
   (make-snake-part RIGHT (make-posn 250 250))
   (make-snake-part RIGHT (make-posn 150 250))
   (make-snake-part RIGHT (make-posn 50 250))))

(define-struct worm-game [snake food])
; A WormGame is a structure
;   (make-worm-game Snake Posn)
; interpretation the Snake representation
; and the position of the food

(define WORM-GAME-MID-LEFT
  (make-worm-game SNAKE-MID-LEFT (make-posn 150 350)))


; The WorldState is a WormGame


; ------------------------------ TO-DRAW ------------------------------


; WormGame -> Image
; places the food and the snake on the canvas
(define (render wg)
  (place-image FOOD
               (posn-x (worm-game-food wg)) (posn-y (worm-game-food wg))
               (render-snake (worm-game-snake wg))))


; Snake -> Image
; places the snake mouth on the snake body
(define (render-snake s)
  (place-image SNAKE-MOUTH
               (posn-x (snake-part-pos (first s))) (posn-y (snake-part-pos (first s)))
               (render-snake-body (rest s))))

; Snake -> Image
; renders the full snake by rendering each part
(define (render-snake-body s)
  (cond
    [(empty? s) BACKG]
    [else (render-snake-part (first s) (render-snake-body (rest s)))]))

; SnakePart -> Image
; renders the snake part s onto BACKG
(define (render-snake-part s bg)
  (place-image SNAKE
               (posn-x (snake-part-pos s)) (posn-y (snake-part-pos s))
               bg))

; ------------------------------ ON-TICK ------------------------------


; --------------- RANDOM PLACEMENT (given) --------

(define MAX 500)

; Posn -> Posn 
; creates food in the canvas except at posn p
(define (food-create p)
  (food-check-create p (make-posn (random MAX) (random MAX))))
 
; Posn Posn -> Posn 
; generative recursion 
; if the food is (inadvertantly created at p, create food again.
(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))
 
; Posn -> Boolean
; is the food at posn (1, 1)?
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

; ------------------------------------------------

; WormGame -> WormGame
; updates the snake every tick, grows if it eats food
(define (tock wg)
  (if (eating-food? wg)
      (grow-snake+place-food wg)
      (make-worm-game (tock-snake (worm-game-snake wg)) (worm-game-food wg))))

; WormGame -> WormGame
; is the snake's mouth touching the food
(define (eating-food? wg)
  (< (distance (snake-part-pos (first (worm-game-snake wg)))
               (worm-game-food wg))
     SNAKE-DIAMETER))

; WormGame -> WormGame
; increases the size of the snake after eating food, creates a new food
(define (grow-snake+place-food wg)
  (make-worm-game (grow-snake (worm-game-snake wg))
                  (food-create (worm-game-food wg))))

; Snake -> Snake
; grows the snake by adding a part in the direction of the snake's mouth
(define (grow-snake s)
  (cons (move-snake-part (first s)) s))

; Snake 
; moves the whole snake by adding a moved part and removing the last part
(define (tock-snake s)
  (cons (move-snake-part (first s)) (remove-last-part s)))

; NE-List -> NE-List
; removes the last element of the ne-list s
(define (remove-last-part s)
  (cond
    [(empty? (rest s)) '()]
    [else (cons (first s) (remove-last-part (rest s)))]))

; SnakePart Part
; moves the snake in its direction
(define (move-snake-part sp)
  (cond
    [(equal? (snake-part-dir sp) UP)    (sp-add-to-y sp (* SNAKE-STEP -1))]
    [(equal? (snake-part-dir sp) DOWN)  (sp-add-to-y sp SNAKE-STEP)]
    [(equal? (snake-part-dir sp) LEFT)  (sp-add-to-x sp (* SNAKE-STEP -1))]
    [(equal? (snake-part-dir sp) RIGHT) (sp-add-to-x sp SNAKE-STEP)]))

; adds step to the y posn of the snake part
(define (sp-add-to-y sp step)
  (make-snake-part (snake-part-dir sp)
                   (make-posn (posn-x (snake-part-pos sp)) (+ (posn-y (snake-part-pos sp)) step))))

; adds step to the x posn of the snake part
(define (sp-add-to-x sp step)
  (make-snake-part (snake-part-dir sp)
                   (make-posn (+ (posn-x (snake-part-pos sp)) step) (posn-y (snake-part-pos sp)))))

; ------------------------------ ON-KEY ------------------------------


; SnakePart KeyEvent Part
; changes the direction of the snake
(define (key-h-snake-part sp k)
  (cond
    [(key=? k "up") (if (equal? (snake-part-dir sp) DOWN) sp (sp-set-dir sp UP))]
    [(key=? k "down") (if (equal? (snake-part-dir sp) UP) sp (sp-set-dir sp DOWN))]
    [(key=? k "left") (if (equal? (snake-part-dir sp) RIGHT) sp (sp-set-dir sp LEFT))]
    [(key=? k "right") (if (equal? (snake-part-dir sp) LEFT) sp (sp-set-dir sp RIGHT))]
    [else sp]))


; SnakePart -> SnakePart
; change snake part's direction to dir
(define (sp-set-dir sp dir)
  (make-snake-part dir (snake-part-pos sp)))

; Snake KeyEvent -> Snake
; changes the snake's direction according to the key pressed
(define (key-h-snake s k)
  (cons (key-h-snake-part (first s) k) (rest s)))

; WormGame KeyEnvent -> WormGame
; changes the snake part of the worm game according to key k
(define (key-h wg k)
  (make-worm-game (key-h-snake (worm-game-snake wg) k) (worm-game-food wg)))

; ------------------------------ STOP-WHEN ------------------------------

; WormGame -> Boolean
; has the game reached its end? (snake hit border or body)
(define (end? wg)
  (snake-end? (worm-game-snake wg)))

; Snake -> Boolean
; has the snake part hit the border?
(define (snake-end? s)
  (or (face-hit-border? (first s))
      (face-hit-body? (first s) (rest s))))

; SnakePart -> Boolean
; has the snake part hit the border?
(define (face-hit-border? s)
  (or (< (posn-x (snake-part-pos s)) (+ 0 SNAKE-RADIUS))
      (< (posn-y (snake-part-pos s)) (+ 0 SNAKE-RADIUS))
      (> (posn-x (snake-part-pos s)) (- SCENE-WIDTH SNAKE-RADIUS))
      (> (posn-y (snake-part-pos s)) (- SCENE-HEIGHT SNAKE-RADIUS))))

; Snake -> Boolean
; has the face of the snake collided with any of its body parts?
(define (face-hit-body? f s)
  (cond
    [(empty? s) #false]
    [else (or (sp-too-close? f (first s))
              (face-hit-body? f (rest s)))]))

; SnakePart SnakePart -> Boolean
; are the two snake parts (assuming same size) overlapping?
(define (sp-too-close? s1 s2)
  (< (distance (snake-part-pos s1) (snake-part-pos s2)) SNAKE-DIAMETER))

; Posn Posn -> Number
; distance between p1 and p2
(define (distance p1 p2)
  (sqrt (+ (sqr (- (posn-x p1) (posn-x p2)))
           (sqr (- (posn-y p1) (posn-y p2))))))

; WS -> Image
; produces the last image from the WS
(define (game-over ws)
  (overlay (text "game over" 20 "black")
           (render ws)))

; ------------------------------ BIG-BANG ------------------------------

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (get-snake-length
   (big-bang ws
     [on-tick   tock 0.075]
     [on-key    key-h]
     [to-draw   render]
     [stop-when end? game-over])))

; WormGame -> Nat
; the length of the snake
(define (get-snake-length wg)
  (length (worm-game-snake wg)))

#;
(main (make-worm-game SNAKE-MID-LEFT (make-posn 450 450)))

;; ---------------------------------------------------------------------


; to-draw tests

(check-expect (render WORM-GAME-MID-LEFT)
              (place-image FOOD 150 350
                           (place-image SNAKE-MOUTH 250 250
                                        (render-snake-body (rest SNAKE-MID-LEFT)))))

(check-expect (render (make-worm-game BIG-SNAKE (make-posn 450 450)))
              (place-image FOOD 450 450
                           (place-image SNAKE-MOUTH 50 50
                                        (render-snake-body (rest BIG-SNAKE)))))

(check-expect (render-snake-part SNAKE-PART-TOP-LEFT BACKG)
              (place-image SNAKE 50 50 BACKG))

(check-expect (render-snake-part SNAKE-PART-CENTER BACKG)
              (place-image SNAKE 250 250 BACKG))

(check-expect (render-snake-part SNAKE-PART-TOP-RIGHT BACKG)
              (place-image SNAKE 450 50 BACKG))

(check-expect (render-snake-body SNAKE-MID-LEFT)
              (place-image SNAKE 250 250
                           (place-image SNAKE 150 250
                                        (place-image SNAKE 50 250 BACKG))))

; on-tick tests

(check-expect (move-snake-part SNAKE-PART-BOTTOM-LEFT) (make-snake-part UP (make-posn 50 (- 450 SNAKE-STEP))))
(check-expect (move-snake-part SNAKE-PART-TOP) (make-snake-part DOWN (make-posn 250 (+ 50 SNAKE-STEP))))
(check-expect (move-snake-part SNAKE-PART-LEFT) (make-snake-part RIGHT (make-posn (+ 50 SNAKE-STEP ) 250)))
(check-expect (move-snake-part SNAKE-PART-TOP-RIGHT) (make-snake-part LEFT (make-posn (- 450 SNAKE-STEP) 50)))

(check-expect (tock-snake SNAKE-MID-LEFT)
              (list (make-snake-part "right" (make-posn (+ 250 SNAKE-DIAMETER) 250))
                    (make-snake-part "right" (make-posn 250 250))
                    (make-snake-part "right" (make-posn 150 250))))

(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(check-random (food-create (make-posn 1 1))
              (food-check-create (make-posn 1 1) (make-posn (random MAX) (random MAX))))


(check-random (food-check-create (make-posn 250 250) (make-posn 250 250))
              (food-check-create (make-posn 250 250) (make-posn (random MAX) (random MAX))))

(check-random (food-check-create (make-posn 250 250) (make-posn 251 251))
              (make-posn 251 251))


(check-expect (not=-1-1? (make-posn 1 1)) #false)
(check-expect (not=-1-1? (make-posn 2 1)) #true)


(check-expect (tock (make-worm-game (list (make-snake-part "right" (make-posn 250 250)))
                                    (make-posn 250 150)))
              (make-worm-game (list (make-snake-part "right" (make-posn (+ SNAKE-STEP 250) 250)))
                              (make-posn 250 150)))

(check-random (tock (make-worm-game SNAKE-MID-LEFT (make-posn 250 250)))
              (make-worm-game (list (make-snake-part "right" (make-posn (+ SNAKE-STEP 250) 250))
                                    (make-snake-part "right" (make-posn 250 250))
                                    (make-snake-part "right" (make-posn 150 250))
                                    (make-snake-part "right" (make-posn 50 250)))
                              (make-posn (random MAX) (random MAX))))

(check-expect (eating-food? (make-worm-game (list (make-snake-part "right" (make-posn 250 250)))
                                            (make-posn 250 250)))
              #true)
(check-expect (eating-food? (make-worm-game (list (make-snake-part "right" (make-posn 250 250)))
                                            (make-posn 250 150)))
              #false)

(check-random (grow-snake+place-food (make-worm-game SNAKE-MID-LEFT (make-posn 250 250)))
              (make-worm-game (list (make-snake-part "right" (make-posn (+ SNAKE-STEP 250) 250))
                                    (make-snake-part "right" (make-posn 250 250))
                                    (make-snake-part "right" (make-posn 150 250))
                                    (make-snake-part "right" (make-posn 50 250)))
                              (make-posn (random MAX) (random MAX))))

(check-expect (grow-snake SNAKE-MID-LEFT)
              (cons (make-snake-part "right" (make-posn (+ SNAKE-STEP 250) 250)) SNAKE-MID-LEFT))
(check-expect (grow-snake BIG-SNAKE)
              (cons (make-snake-part "down" (make-posn 50 (+ SNAKE-STEP 50))) BIG-SNAKE))




;; on-key tests

(check-expect (key-h-snake-part (make-snake-part "up" (make-posn 250 250)) "down")
              (make-snake-part "up" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "down" (make-posn 250 250)) "up")
              (make-snake-part "down" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "left" (make-posn 250 250)) "right")
              (make-snake-part "left" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "right" (make-posn 250 250)) "left")
              (make-snake-part "right" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "up" (make-posn 250 250)) "right")
              (make-snake-part "right" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "down" (make-posn 250 250)) "left")
              (make-snake-part "left" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "left" (make-posn 250 250)) "up")
              (make-snake-part "up" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "right" (make-posn 250 250)) "down")
              (make-snake-part "down" (make-posn 250 250)))

(check-expect (key-h-snake-part (make-snake-part "right" (make-posn 250 250)) "w")
              (make-snake-part "right" (make-posn 250 250)))

(check-expect (sp-set-dir (make-snake-part "right" (make-posn 250 250)) "down")
              (make-snake-part "down" (make-posn 250 250)))

(check-expect (key-h (make-worm-game SNAKE-MID-LEFT (make-posn 250 250)) "left")
              (make-worm-game (key-h-snake SNAKE-MID-LEFT "left") (make-posn 250 250)))

(check-expect (key-h-snake SNAKE-MID-LEFT "up")
              (list (make-snake-part "up" (make-posn 250 250))
                    (make-snake-part "right" (make-posn 150 250))
                    (make-snake-part "right" (make-posn 50 250))))


;; stop-when

(check-expect (face-hit-border? (make-snake-part "left" (make-posn -50 250))) #true)
(check-expect (face-hit-border? (make-snake-part "down" (make-posn 50 -1))) #true)
(check-expect (face-hit-border? (make-snake-part "right" (make-posn 501 250))) #true)
(check-expect (face-hit-border? (make-snake-part "right" (make-posn 400 550))) #true)
(check-expect (face-hit-border? (make-snake-part "down" (make-posn 450 450))) #false)
(check-expect (face-hit-border? (make-snake-part "up" (make-posn 250 250))) #false)


(check-expect (sp-too-close? SNAKE-PART-CENTER (make-snake-part UP (make-posn 249 249))) #true)
(check-expect (sp-too-close? SNAKE-PART-CENTER (make-snake-part UP (make-posn 150 150))) #false)

(check-within (distance (make-posn 0 1) (make-posn 1 0)) (sqrt 2) 0.0001)
(check-within (distance (make-posn 1 1) (make-posn 1 1)) 0 0.0001)

(check-expect (snake-end? SNAKE-MID-LEFT) #false)
(check-expect (snake-end? (list (make-snake-part "right" (make-posn 500 250))
                                (make-snake-part "right" (make-posn 150 250))
                                (make-snake-part "right" (make-posn 50 250))))
              #true)
(check-expect (end? (make-worm-game (list (make-snake-part "right" (make-posn 500 250))
                                          (make-snake-part "right" (make-posn 150 250))
                                          (make-snake-part "right" (make-posn 50 250)))
                                    (make-posn 250 250)))
              #true)

(check-expect (game-over (make-worm-game SNAKE-MID-LEFT (make-posn 50 50)))
              (overlay (text "game over" 20 "black")
                       (render (make-worm-game SNAKE-MID-LEFT (make-posn 50 50)))))

;; -----------------------------------------------------------------------------

(main (make-worm-game (list (make-snake-part "right" (make-posn 250 250))) (make-posn 300 250)))