;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 152ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 152
;; ------------
;; Design two functions: col and row.
;;
;; The function col consumes a natural number n and an image img. It produces a
;; column—a vertical arrangement—of n copies of img.
;;
;; The function row consumes a natural number n and an image img. It produces a
;; row—a horizontal arrangement—of n copies of img. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)

(define square-img (square 20 "outline" "red"))
(define circle-img (circle 20 "outline" "red"))

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