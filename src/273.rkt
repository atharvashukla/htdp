;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 273ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 273
;; ------------
;; The fold functions are so powerful that you can define almost any list
;; processing functions with them. Use fold to define map.
;; -----------------------------------------------------------------------------

; [X Y] [X -> Y] [List-of X] -> [List-of Y]
; applies func to each element in lst (right to left)

(check-expect (map-with-foldr identity '(1 2 3 4 5)) '(1 2 3 4 5))
(check-expect (map-with-foldr add1 '(0 1 2 3 4)) '(1 2 3 4 5))
(check-expect (map-with-foldr zero? '(0 1 2 3 4)) '(#t #f #f #f #f))

(define (map-with-foldr func lst)
  (local ((define (func-for-foldr ele acc)
            (cons (func ele) acc)))
    (foldr func-for-foldr '() lst)))


; [X Y] [X -> Y] [List-of X] -> [List-of Y]
; applies func to each element in lst (left to right)

(check-expect (map-with-foldl identity '(1 2 3 4 5)) '(1 2 3 4 5))
(check-expect (map-with-foldl add1 '(0 1 2 3 4)) '(1 2 3 4 5))
(check-expect (map-with-foldl zero? '(0 1 2 3 4)) '(#t #f #f #f #f))

(define (map-with-foldl func lst)
  (local ((define (func-for-foldl ele acc)
            (cons (func ele) acc)))
    (reverse (foldl func-for-foldl '() lst))))