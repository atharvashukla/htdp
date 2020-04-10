;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 153ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 153
;; ------------
;; The goal of this exercise is to visualize the result of a 1968-style European
;; student riot. Here is the rough idea. A small group of students meets to make
;; paint-filled balloons, enters some lecture hall, and randomly throws the
;; balloons at the attendees. Your program displays how the balloons color the
;; seats in the lecture hall.

;; Use the two functions from exercise 152 to create a rectangle of 8 by 18
;; squares, each of which has size 10 by 10. Place it in an empty-scene of the
;  same size. This image is your lecture hall.

;; Design add-balloons. The function consumes a list of Posn whose coordinates
;; fit into the dimensions of the lecture hall. It produces an image of the
;; lecture hall with red dots added as specified by the Posns.

;; Figure 60 shows the output of our solution when given some list of Posns. The
;; left-most is the clean lecture hall, the second one is after two balloons
;; have hit, and the last one is a highly unlikely distribution of 10 hits.
;; Where is the 10th? 
;; -----------------------------------------------------------------------------

(require 2htdp/image)


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
#|
(define square-len 20)
(define square-col "black")
(define square-img2 (square square-len "outline" square-col))

; N N -> Image
; produces a image of n by n grid

(define (lecture-hall r c)
  (place-image (row r (col c square-img2))
               (/ (* square-len r) 2)
               (/ (* square-len c) 2)
               (empty-scene (* square-len c) (* square-len r))))
|#

; posnew = sidelen*pos

(define lecture-hall-width (* 8 20))
(define lecture-hall-height (* 18 20))
(define lecture-hall (empty-scene lecture-hall-width lecture-hall-height))

(define p1 (make-posn 1 1))
(define p2 (make-posn 2 2))
(define p3 (make-posn 3 3))
(define p4 (make-posn 4 4))
(define p5 (make-posn 5 5))

(define lop1 (list p1 p2 p3 p4 p5))

(define final-lec-hall
  (place-image (row 8 (col 18 square-img))
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


; the 10th one could be a double-hit?