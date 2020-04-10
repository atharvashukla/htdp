;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 221ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 221
;; ------------
;; Design the interactive program tetris-main, which displays blocks dropping in
;; a straight line from the top of the canvas and landing on the floor or on
;; blocks that are already resting. The input to tetris-main should determine
;; the rate at which the clock ticks. See the documentation of on-tick for how
;; to specify the rate.
;;
;; To discover whether a block landed, we suggest you drop it and check whether
;; it is on the floor or it overlaps with one of the blocks on the list of
;; resting blocks. Hint Read up on the member? primitive.
;;
;; When a block lands, your program should immediately create another block that
;; descends on the column to the right of the current one. If the current block
;; is already in the right-most column, the next block should use the left-most
;; one. Alternatively, define the function block-generate, which randomly
;; selects a column different from the current one; see exercise 219 for
;; inspiration. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH 10) ; # of blocks, horizontally 
(define SIZE 30) ; blocks are squares
(define MID-SIZE (/ SIZE 2)) ; # of pixels half way through a block
(define HEIGHT (* WIDTH 2)) ; # of blocks, vertically
(define SCENE-WIDTH (* WIDTH SIZE))
(define SCENE-HEIGHT (* HEIGHT SIZE))

(define BACKG-COLOR "Medium Pink")
(define BLOCK-COLOR "Dark Pink")
(define BLOCK-BORDER-COLOR "black")

(define BACKG (overlay (rectangle SCENE-WIDTH SCENE-HEIGHT "solid" BACKG-COLOR)
                       ; overlaying on 1px bigger backg to not hide the borders of blocks
                       ; in the corners
                       (rectangle (+ 1 SCENE-WIDTH) (+ 1 SCENE-HEIGHT) "solid" BACKG-COLOR)))
 
(define BLOCK ; red squares with black rims
  (overlay (square (- SIZE 1) "solid" BLOCK-COLOR)
           (square SIZE "outline" BLOCK-BORDER-COLOR)))


(define-struct tetris [block landscape])
(define-struct block [x y])

; A Tetris is a structure:
;   (make-tetris Block Landscape)
; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)
; A Block is a structure:
;   (make-block N N);

; interpretations
; (make-block x y) depicts a block whose left 
; corner is (* x SIZE) pixels from the left and
; (* y SIZE) pixels from the top;
; (make-tetris b0 (list b1 b2 ...)) means b0 is the
; dropping block, while b1, b2, and ... are resting


(define b00 (make-block 0 19))
(define b01 (make-block 1 19))
(define b02 (make-block 2 19))
(define b03 (make-block 3 19))
(define b04 (make-block 4 19))

(define landscape0 '())
(define landscape1 (list b00 b01 b02 b03 b04))

(define block-dropping (make-block 5 5))

(define tetris0 (make-tetris (make-block 4 0) landscape0))
(define tetris0-drop (make-tetris block-dropping landscape0))
(define tetris1-drop (make-tetris block-dropping landscape1))

(define block-landed (make-block 0 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))


; -------------------- TO-DRAW -------------------

; Tetris -> Image
; places the image of landscape and block into BACKG
(define (tetris-render t)
  (block-render (tetris-block t) (landscape-render (tetris-landscape t) BACKG)))

; Landscape -> Image
; places all blocks in landscape onto backg
(define (landscape-render landscape backg)
  (cond
    [(empty? landscape) backg]
    [else (block-render (first landscape)
                        (landscape-render (rest landscape) backg))]))

; Block -> Image
; places block on backg
(define (block-render block backg)
  (place-image-offset BLOCK (* SIZE (block-x block)) (* SIZE (block-y block)) backg))


; Image -> Image
; like place-image but makes the left corner the pinhols
(define (place-image-offset i1 x y i2)
  (place-image i1 (+ x (/ SIZE 2)) (+ y (/ SIZE 2)) i2))


; Tests:

(check-expect (tetris-render tetris0) (place-image BLOCK (+ (* 4 SIZE) MID-SIZE) MID-SIZE BACKG))
(check-expect (tetris-render tetris0-drop) (place-image BLOCK (+ (* 5 SIZE) MID-SIZE) (+ (* 5 SIZE) MID-SIZE) BACKG))
(check-expect (landscape-render '() BACKG) BACKG)
(check-expect (landscape-render (list b00) BACKG) (block-render b00 BACKG))
(check-expect (place-image-offset BLOCK 0 0 BACKG) (place-image BLOCK MID-SIZE MID-SIZE BACKG))
(check-expect (block-render b00 BACKG) (place-image BLOCK MID-SIZE (+ 570 MID-SIZE) BACKG))

; -------------------- ON-TICK --------------------

; Tetris -> Tetris
; generate a new block if the current 
; moving block cannot go down
(define (tock t)
  (if (equal? (tetris-block (move-block-down t)) (tetris-block t)) ; moving block stable?
      (fresh-block (add-to-landscape t))
      (move-block-down t)))

; Tetris -> Tetris
; generates a new block
(define (fresh-block t)
  (make-tetris (make-block (random WIDTH) 0) (tetris-landscape t)))

; Tetris -> Tetris
; adds the block to the landscape

(check-expect (add-to-landscape (make-tetris (make-block 0 19) '()))
              (make-tetris (make-block 0 19) (list (make-block 0 19))))

(define (add-to-landscape t)
  (make-tetris (tetris-block t) (cons (tetris-block t) (tetris-landscape t))))

; Tetris -> Boolean
; is the moving block on the ground?

(check-expect (block-on-ground? (make-tetris (make-block 0 19) '())) #true)
(check-expect (block-on-ground? (make-tetris (make-block 0 18) '())) #false)
(check-expect (block-on-ground? (make-tetris (make-block 0 18) (list (make-block 0 19)))) #false)

(define (block-on-ground? t)
  (= (block-y (tetris-block t)) (- HEIGHT 1)))

; ----- move-block -----

; Tetris -> Tetris
; moves the block down in tetris
(define (move-block-down t)
  (cond
    [(block-on-ground? t) (add-to-landscape t)]
    [(block-down-exists? t) t]
    [else (make-tetris (make-block (block-x (tetris-block t)) (+ (block-y (tetris-block t)) 1))
                       (tetris-landscape t))]))

; Tetris -> Tetris
; moves the block down in tetris 
(define (move-block-right t)
  (if (block-right-exists? t)
      t
      (make-tetris (make-block (+ (block-x (tetris-block t)) 1) (block-y (tetris-block t)))
                   (tetris-landscape t))))

; Tetris -> Tetris
; moves the block down in tetris 
(define (move-block-left t)
  (if (block-left-exists? t)
      t
      (make-tetris (make-block (- (block-x (tetris-block t)) 1) (block-y (tetris-block t)))
                   (tetris-landscape t))))


; ----- block-exists? -----


; Tetris -> Boolean
; does a block exists to the left of the moving block in t?
(define (block-left-exists? t)
  (member? (make-block (- (block-x (tetris-block t)) 1) (block-y (tetris-block t)))
           (tetris-landscape t)))

; Tetris -> Boolean
; does a block exist below the moving block in t?
(define (block-down-exists? t)
  (member? (make-block (block-x (tetris-block t)) (+ (block-y (tetris-block t)) 1))
           (tetris-landscape t)))

; Tetris -> Boolean
; does a block exists to the right of the moving block in t?
(define (block-right-exists? t)
  (member? (make-block (+ (block-x (tetris-block t)) 1) (block-y (tetris-block t)))
           (tetris-landscape t)))

; -------- tests ----------

(check-expect (tock (make-tetris (make-block 0 0) landscape1)) (make-tetris (make-block 0 1) landscape1))
(check-random (tock (make-tetris (make-block 0 18) landscape1))
              (make-tetris (make-block (random WIDTH) 0) (cons (make-block 0 18) landscape1)))
(check-random (fresh-block (make-tetris (make-block 0 19) '())) (make-tetris (make-block (random WIDTH) 0) '()))
(check-expect (move-block-down (make-tetris (make-block 5 5) landscape1)) (make-tetris (make-block 5 6) landscape1))
(check-expect (move-block-down (make-tetris (make-block 5 5) (cons (make-block 5 6) landscape1)))
              (make-tetris (make-block 5 5) (cons (make-block 5 6) landscape1)))

(check-expect (move-block-down (make-tetris (make-block 0 19) '()))
              (make-tetris (make-block 0 19) (list (make-block 0 19))))
(check-expect (block-on-ground? (make-tetris (make-block 0 0) '())) #false)
(check-expect (block-on-ground? (make-tetris (make-block 0 19) '())) #true)
(check-expect (block-down-exists? (make-tetris (make-block 5 5) landscape1)) #false)
(check-expect (block-down-exists? (make-tetris (make-block 5 5) (cons (make-block 5 6) landscape1))) #true)
(check-expect (move-block-right (make-tetris (make-block 5 5) landscape1)) (make-tetris (make-block 6 5) landscape1))
(check-expect (move-block-right (make-tetris (make-block 5 5) (cons (make-block 6 5) landscape1)))
              (make-tetris (make-block 5 5) (cons (make-block 6 5) landscape1)))
(check-expect (block-right-exists? (make-tetris (make-block 5 5) landscape1)) #false)
(check-expect (block-right-exists? (make-tetris (make-block 5 5) (cons (make-block 6 5) landscape1))) #true)
(check-expect (move-block-left (make-tetris (make-block 5 5) landscape1)) (make-tetris (make-block 4 5) landscape1))
(check-expect (move-block-left (make-tetris (make-block 5 5) (cons (make-block 4 5) landscape1)))
              (make-tetris (make-block 5 5) (cons (make-block 4 5) landscape1)))
(check-expect (block-left-exists? (make-tetris (make-block 5 5) landscape1)) #false)
(check-expect (block-left-exists? (make-tetris (make-block 5 5) (cons (make-block 4 5) landscape1))) #true) 

; -------------------- BIG-BANG -------------------

; WorldState Number -> WorldState
; launches the program from state ws
; with rate ticks per second
(define (main ws rate)
  (landscape-length
   (big-bang ws
     [to-draw tetris-render]
     [on-tick tock rate])))

; Tetris -> Number
; how many blocks have been placed?
(define (landscape-length t)
  (length (tetris-landscape t)))

(check-expect (landscape-length (make-tetris (make-block 0 4)
                                             landscape1))
              5)

#;
(main (make-tetris (make-block 4 0) landscape1) 0.01)
