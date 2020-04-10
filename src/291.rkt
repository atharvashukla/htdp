;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |291.1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 291
;; ------------
;; The fold functions are so powerful that you can define almost any
;; list-processing functions with them. Use fold to define map-via-fold, which
;; simulates map.
;; -----------------------------------------------------------------------------

;; [X Y] [X-->Y] [List-of X] -> [List-of Y]
;; simulate map using foldr

(check-expect (map-via-fold add1 (list 1 2 3)) (list 2 3 4))
(check-expect (map-via-fold sub1 (list 1 2 3)) (list 0 1 2))
(check-expect (map-via-fold (lambda (n) (string-append n "ean")) (list "bool" "fool" "nool"))
 (list "boolean" "foolean" "noolean"))

(define (map-via-fold func lox)
  (foldr (lambda (x y) (cons (func x) y)) '() lox))

