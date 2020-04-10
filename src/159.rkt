;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 159ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 159
;; ------------
;; 
;; Turn the solution of exercise 153 into a world program. Its main function,
;; dubbed riot, consumes how many balloons the students want to throw; its
;; visualization shows one balloon dropping after another at a rate of one per
;; second. The function produces the list of Posns where the balloons hit.
;;
;; *Hints* (1) Here is one possible data representation:
;;
;;    (define-struct pair [balloon# lob])
;;    ; A Pair is a structure (make-pair N List-of-posns)
;;    ; A List-of-posns is one of: 
;;    ; – '()
;;    ; – (cons Posn List-of-posns)
;;    ; interpretation (make-pair n lob) means n balloons 
;;    ; must yet be thrown and added to lob
;;
;; (2) A big-bang expression is really just an expression. It is legitimate to
;;     nest it within another expression.
;;
;; (3) Recall that random creates random numbers. 
;;
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(define square-img (square 20 "outline" "black"))
(define circle-img (circle 20 "outline" "black"))

; N Image -> Image
; produces a column of n copies of img
#;
(define (col n img)
  empty-image)

(check-expect (col 1 square-img) square-img)
(check-expect (col 2 square-img) (above square-img square-img))
(check-expect (col 3 square-img) (above square-img square-img square-img))

(define (col n img)
  (cond
    [(zero? n) empty-image]
    [else (above img (col (sub1 n) img))]))

; N Image -> Image
; produces a row of n copies of img
#;
(define (row n img)
  empty-image)

(check-expect (row 1 square-img) square-img)
(check-expect (row 2 square-img) (beside square-img square-img))
(check-expect (row 3 square-img) (beside square-img square-img square-img))

(define (row n img)
  (cond
    [(zero? n) empty-image]
    [else (beside img (row (sub1 n) img))]))

; -------------------------------------------

; posnew = sidelen*pos
(define lecture-hall-row-seats 8)
(define lecture-hall-col-seats 18)
(define seat-width 20)


(define lecture-hall-width (* lecture-hall-row-seats seat-width))
(define lecture-hall-height (* lecture-hall-col-seats seat-width))
(define lecture-hall (empty-scene lecture-hall-width lecture-hall-height))

(define p1 (make-posn 1 1))
(define p2 (make-posn 2 2))
(define p3 (make-posn 3 3))
(define p4 (make-posn 4 4))
(define p5 (make-posn 5 5))

(define lop1 (list p1 p2 p3 p4 p5))

(define final-lec-hall
  (place-image (row lecture-hall-row-seats (col lecture-hall-col-seats square-img))
               (/ lecture-hall-width 2)
               (/ lecture-hall-height 2)
               lecture-hall))

(define ball-im (circle 3 "solid" "red"))

; Posn -> Image
; adds one balloon to the hall
(define (add-one-balloon pos lec-hall)
  (place-image ball-im (* (posn-x pos) 20) (* (posn-y pos) 20) lec-hall))

(check-expect (add-one-balloon p1 final-lec-hall) (place-image ball-im 20 20 final-lec-hall))
(check-expect (add-one-balloon p2 final-lec-hall) (place-image ball-im 40 40 final-lec-hall))

; List-of-posns -> Image
; adds all the balloons in the list to the lecture hall

(define (add-balloons lop lec-hall)
  (cond
    [(empty? lop) lec-hall]
    [else (add-balloons (rest lop) (add-one-balloon (first lop) lec-hall))]))

(check-expect (add-balloons (list p1) final-lec-hall)
              (place-image ball-im 20 20 final-lec-hall))
(check-expect (add-balloons (list p1 p2) final-lec-hall)
              (place-image ball-im 40 40 (add-balloons (list p1) final-lec-hall)))


; ------------------------------------------------
; New:

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair N List-of-posns)
; A List-of-posns is one of: 
; – '()
; – (cons Posn List-of-posns)
; interpretation (make-pair n lob) means n balloons 
; must yet be thrown and added to lob

(define (draw-riot ws)
  (add-balloons (pair-lob ws) final-lec-hall))

(define (tock ws)
  (make-pair (- (pair-balloon# ws) 1) (random-posn-list (pair-lob ws))))


;; Nat -> List-of-posns
;; adds a random posn to the list

(define (random-posn-list lop)
  (cons (make-posn (+ 1 (random lecture-hall-row-seats))
                   (+ 1 (random lecture-hall-col-seats)))
        lop))

(define (stop-riot ws)
  (= (pair-balloon# ws) 0))

(define (riot n)
  (big-bang (make-pair n '())
    [to-draw draw-riot]
    [stop-when stop-riot]
    [on-tick tock 1]))

(riot 10)