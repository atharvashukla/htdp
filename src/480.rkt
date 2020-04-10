;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 480ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 479
;; ------------
;; Exercise 480. Design render-queens. The function consumes a natural number n,
;; a list of QPs, and an Image. It produces an image of an n by n chess board
;; with the given image placed according to the given QPs.
;;
;; You may wish to look for an image for a chess queen on-line or create a
;; simplistic one with the available image functions. 
;; -----------------------------------------------------------------------------


(require 2htdp/image)

(define SIDE 50)

(define BORDER "darkbrown")
(define DARK "darkolivegreen")
(define LIGHT "goldenrod")

; Number -> Image
; square of side n and color c
(define (make-square n c)
  (square n "solid" c))

(define DARK-SQUARE (make-square SIDE DARK))
(define LIGHT-SQUARE (make-square SIDE LIGHT))

(define Q-img (bitmap "queen.png"))
(define Q-img-side (image-width Q-img))
(define shrink-factor 9/10)

(define Q (scale (* shrink-factor (/ SIDE Q-img-side)) Q-img))

; Number -> Image
; creates a board image of dimension dim
(define (gen-empty-board dim)
  (overlay (grid-list->img (grid-list dim gen-chess-board-squares))
           (border dim)))

; Number -> Image
; creates a brown base to overlay the board on
(define (border n)
  (square (* (+ 1 n) SIDE) "solid" BORDER))

; Number Number -> Image
; square images based on row and col of board
(define gen-chess-board-squares
  (λ (row col) (if (dark-square-posn? row col) DARK-SQUARE LIGHT-SQUARE)))

; Number Number -> [List-of [List-of Image]]
; n by n list grid where each square in of `side` length
(define (grid-list n gen-square)
  (build-list n (λ (row) (build-list n (λ (col) (gen-square row col))))))

; [List-of [List-of Image]] -> Image
; converts a grid of squares into a single image
(define (grid-list->img gl)
  (local ((define rows (map (λ (sqr) (apply beside sqr)) gl)))
    (apply above rows)))

; Number Number -> Boolean
; does a dark square belong to this row and col?
(define (dark-square-posn? row col)
  (or (and (odd? row) (even? col))
      (and (even? row) (odd? col))))


; Image Posn Image -> Image
; places a queen image on square p in a board image
(define (place-a-queen q-im p b-im)
  (place-image q-im
               (px->board-coord (posn-x p))
               (px->board-coord (posn-y p))
               b-im))

; Number -> Number
; offsetts the pixel posn to center it
; in the corresponding board square
(define (px->board-coord n)
  (+ SIDE (* SIDE n)))

; Number [List-of QP] Image -> Image
; places the img of queen on n by n board at qps
(define (render-queens n qps img)
  (foldr (λ (e a) (place-a-queen img e a)) (gen-empty-board n) qps))

(render-queens 8
               (list (make-posn 0 0) (make-posn 1 1) (make-posn 2 2)
                     (make-posn 7 1) (make-posn 6 4) (make-posn 5 3))
               Q)