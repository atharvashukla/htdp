;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 479ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 479
;; ------------
;; Design the threatening? function. It consumes two QPs and determines whether
;; queens placed on the two respective squares would threaten each other.
;;
;; Domain Knowledge (1) Study figure 172. The queen in this figure threatens all
;; squares on the horizontal, the vertical, and the diagonal lines. Conversely,
;; a queen on any square on these lines threatens the queen.
;;
;; (2) Translate your insights into mathematical conditions that relate the
;; squares’ coordinates to each other. For example, all squares on a horizontal
;; have the same y-coordinate. Similarly, all squares on one diagonal have
;; coordinates whose sums are the same. Which diagonal is that? For the other
;; diagonal, the differences between the two coordinates remain the same. Which
;; diagonal does this idea describe?
;;
;; Hint Once you have figured out the domain knowledge, formulate a test suite
;; that covers horizontals, verticals, and diagonals. Don’t forget to include
;; arguments for which threatening? must produce #false.
;; -----------------------------------------------------------------------------


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

