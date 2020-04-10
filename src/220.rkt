;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 220ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 220
;; ------------
;; When you are presented with a complex data definition—like the one for the
;; state of a Tetris game—you start by creating instances of the various data
;; collections. Here are some suggestive names for examples you can later use
;; for functional examples:
;; 
;;    (define landscape0 ...)
;;    (define block-dropping ...)
;;    (define tetris0 ...)
;;    (define tetris0-drop ...)
;;    ...
;;    (define block-landed (make-block 0 (- HEIGHT 1)))
;;    ...
;;    (define block-on-block (make-block 0 (- HEIGHT 2)))
;;
;; Design the program tetris-render, which turns a given instance of Tetris into
;; an Image. Use DrRacket’s interactions area to develop the expression that
;; renders some of your (extremely) simple data examples. Then formulate the
;; functional examples as unit tests and the function itself. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)

(define WIDTH 10) ; # of blocks, horizontally 
(define SIZE 30) ; blocks are squares
(define MID-SIZE (/ SIZE 2))
(define HEIGHT (* WIDTH 2))
(define SCENE-WIDTH (* WIDTH SIZE))
(define SCENE-HEIGHT (* HEIGHT SIZE))

(define BACKG-COLOR "Medium Pink")
(define BLOCK-COLOR "Dark Pink")
(define BLOCK-BORDER-COLOR "black")

(define BACKG (overlay (rectangle SCENE-WIDTH SCENE-HEIGHT "solid" BACKG-COLOR)
                       ; overlaying on 1px bigger backg to not hide the borders of blocks
                       ; in the corners
                       (rectangle (+ 1 SCENE-HEIGHT) (+ 1 SCENE-HEIGHT) "solid" BACKG-COLOR)))
 
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

; ------------------------------------------------



