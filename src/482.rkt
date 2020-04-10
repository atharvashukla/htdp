;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 482ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 482
;; ------------
;; The key idea to is to design a function that places n queens on a chess board
;; that may already contain some queens:
;;
;;    ; Board N -> [Maybe [List-of QP]]
;;    ; places n queens on board; otherwise, returns #false
;;    (define (place-queens a-board n)
;;      #false)
;;
;; Figure 175 already refers to this function in the definition of n-queens.
;;
;; Design the place-queens algorithm. Assume you have the following functions to
;; deal with Boards:
;;
;;    ; N -> Board 
;;    ; creates the initial n by n board
;;    (define (board0 n) ...)
;;     
;;    ; Board QP -> Board 
;;    ; places a queen at qp on a-board
;;    (define (add-queen a-board qp)
;;      a-board)
;;     
;;    ; Board -> [List-of QP]
;;    ; finds spots where it is still safe to place a queen
;;    (define (find-open-spots a-board)
;;      '())
;;
;; The first function is used in figure 175 to create the initial board
;; representation for place-queens. You will need the other two to describe the
;; generative steps for the algorithm. 
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


(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at 
; the r-th row and c-th column


; Board is a [List-of QP]
; interpretation. a list of queen positions so far


; data example: [List-of QP]
(define 4QUEEN-SOLUTION-2
  (list  (make-posn 0 2) (make-posn 1 0)
         (make-posn 2 3) (make-posn 3 1)))
 
 
(define 0-1 (make-posn 0 1))
(define 1-3 (make-posn 1 3))
(define 2-0 (make-posn 2 0))
(define 3-2 (make-posn 3 2))


;; --------------------------------------------------------- Functions
 
; Number -> [List-of QP]
; solutions to queen positions
(define (n-queens BOARD-DIM)
  (local (; Board N -> [Maybe [List-of QP]]
          ; places n queens on board; otherwise, returns #false
          (define (place-queens b n) 
            (cond
              [(= n 0) b]
              [else (local ((define open-spots (find-open-spots b BOARD-DIM))
                            (define candidate-solution (find-placement/spots open-spots b n)))
                      (if (boolean? candidate-solution)
                          #false
                          candidate-solution))]))
          
          ; finds a queen placement from on board with n queens left
          ; produces #false if not possible to place
          (define (find-placement/spots open-spots board n)
            (cond
              [(empty? open-spots) #false]
              [else (local ((define candidate
                              (place-queens (add-queen (first open-spots) board)
                                            (sub1 n))))
                      (if (boolean? candidate)
                          (find-placement/spots (rest open-spots) board n)
                          candidate))])))
    (place-queens (board0 BOARD-DIM) BOARD-DIM)))


; ------------------------------------------------------------ Helpers 

; N -> Board 
; creates the initial n by n board
(define (board0 n) '())
 
; Board QP -> Board 
; places a queen at qp on a-board

(check-expect (add-queen (make-posn 1 2) (list (make-posn 2 1)))
              (list (make-posn 1 2) (make-posn 2 1)))

(define (add-queen qp a-board)
  (cons qp a-board))
 
; Board N -> [List-of QP]
; finds spots where it is still safe to place a queen

(check-member-of (find-open-spots (list (make-posn 0 0)) 3)
                 (list (make-posn 1 2) (make-posn 2 1))
                 (list (make-posn 2 1) (make-posn 1 2)))

(define (find-open-spots a-board n)
  (filter (λ (p) (andmap (λ (q) (not (threatening? q p))) a-board))
          (all-board-posns n)))

; [List-of QP] -> Boolean
; any threatening any other queen in qps

(check-expect (any-queen-threatening? (list (make-posn 2 3) (make-posn 5 1)
                                            (make-posn 4 1) (make-posn 7 9)))
              #true)

(check-expect (any-queen-threatening? (list (make-posn 7 9) (make-posn 5 1)
                                            (make-posn 2 3)))
              #false)

(define (any-queen-threatening? qps)
  (cond
    [(empty? qps) #false]
    [else (or (ormap (λ (x) (threatening? (first qps) x)) (rest qps))
              (any-queen-threatening? (rest qps)))]))


; Number -> [List-of QP]
; all board posns in a n dim board

(check-expect (all-board-posns 3)
              (list (make-posn 0 0) (make-posn 0 1) (make-posn 0 2)
                    (make-posn 1 0) (make-posn 1 1) (make-posn 1 2)
                    (make-posn 2 0) (make-posn 2 1) (make-posn 2 2)))

(define (all-board-posns n)
  (local ((define rows (build-list n identity))
          (define all-posns (map (λ (x) (build-list n (λ (y) (make-posn x y)))) rows)))
    (apply append all-posns)))


; ------------------------------------------------------- threatening?

; QP QP -> Boolean
; do the two qps threaten each other?

(check-expect (threatening? (make-posn 0 1) (make-posn 3 2)) #false)
(check-expect (threatening? (make-posn 0 1) (make-posn 1 3)) #false)
(check-expect (threatening? (make-posn 3 1) (make-posn 1 2)) #false)

(check-expect (threatening? (make-posn 0 1) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 0 1)) #true)

(check-expect (threatening? (make-posn 1 3) (make-posn 3 1)) #true)
(check-expect (threatening? (make-posn 3 1) (make-posn 1 3)) #true)

(check-expect (threatening? (make-posn 2 0) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 2 0)) #true)

(check-expect (threatening? (make-posn 1 0) (make-posn 3 0)) #true)
(check-expect (threatening? (make-posn 3 0) (make-posn 1 0)) #true)

(define (threatening? qp1 qp2)
  (local ((define r1 (posn-x qp1))
          (define r2 (posn-x qp2))
          (define c1 (posn-y qp1))
          (define c2 (posn-y qp2)))
    (or (= r1 r2)
        (= c1 c2)
        (= (+ c1 r1) (+ c2 r2))
        (= (- c1 r1) (- c2 r2)))))





; ---------------------------------------------------- Rendering functions


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


; ---------------------------------------------------------- Spec and Testing

; N -> [[List-of QP]-> Boolean]

(check-expect ((n-queens-solution? 4) 4QUEEN-SOLUTION-2) #true)
(check-expect ((n-queens-solution? 4) (list (make-posn 2 2) 1-3 2-0 3-2)) #false)

(define (n-queens-solution? n)
  (λ (qps-or-false)
    (if (and (<= n 3) (equal? #false qps-or-false))
        #true
        (and (cons? qps-or-false)
             (equal? n (length qps-or-false))
             (not (any-queen-threatening? qps-or-false))))))



(check-satisfied (n-queens 3) (n-queens-solution? 3))
(check-satisfied (n-queens 4) (n-queens-solution? 4))


;; -----------------------------------------------------------------------------


; N -> Image
; renders the n-queens solution as an image
(define (render-n-queens n)
  (render-queens n (n-queens n) Q))
