;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 483ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 483
;; ------------
;; Develop a data definition for Board and design the three functions specified
;; in exercise 482. Consider the following ideas:
;;
;; - a Board collects those positions where a queen can still be placed;
;; - a Board contains the list of positions where a queen has been placed;
;; - a Board is a grid of n by n squares, each possibly occupied by a queen. Use
;;   a structure with three fields to represent a square: one for x, one for y,
;;   and a third one saying whether the square is threatened.
;;
;; Use one of the above ideas to solve this exercise.
;;
;; *Challenge* Use all three ideas to come up with three different data
;; representations of Board. Abstract your solution to exercise 482 and confirm
;; that it works with any of your data representations of Board. 
;; -----------------------------------------------------------------------------

(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at 
; the r-th row and c-th column


; Interpretation #2: a Board contains the list of positions where a queen has been placed;

; Board is a [List-of QP]
; interpretation. a list of queen positions so far

; N -> Board 
; creates the initial n by n board

(check-expect (board0 4) '())

(define (board0 n) '())
 
; Board QP -> Board 
; places a queen at qp on a-board

(check-expect (add-queen (list (make-posn 2 1)) (make-posn 1 2))
              (list (make-posn 1 2) (make-posn 2 1)))

(define (add-queen a-board qp)
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


; ----------------------------------- Exercise 479: threatening?

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