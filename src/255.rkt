;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 255ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 255.                                                               |
| -------------                                                               |
|                                                                             |
| Formulate signatures for the following functions:                           |
|                                                                             |
| map-n, which consumes a list of numbers and a function from numbers to      |
| numbers to produce a list of numbers.                                       |
|                                                                             |
| map-s, which consumes a list of strings and a function from strings to      |
| strings and produces a list of strings.                                     |
|                                                                             |
| Then abstract over the two signatures, following the above steps. Also show |
| that the generalized signature can be instantiated to describe the          |
| signature of the map1 function above.                                       |
+-----------------------------------------------------------------------------+
|#


; [List-of Number] [Number -> Number] -> [List-of Number]
; maps func onto all elements in lon
(define (map-n lon func)
  (cond
    [(empty? lon) '()]
    [else (cons (func (first lon)) (map-n (rest lon) func))]))

; [List-of String] [String -> String] -> [List-of String]
; maps func onto all elements in los
(define (map-n los func)
  (cond
    [(empty? los) '()]
    [else (cons (func (first los)) (map-n (rest los) func))]))

; [List-of X] [X -> Y] -> [List-of Y]
; maps func onto all elements in los
(define (my-map lst func)
  (cond
    [(empty? lst) '()]
    [else (cons (func (first lst)) (my-map (rest lst) func))]))


; instantiation with map-1

; my-map: [List-of X]    [X -> Y]           -> [List-of Y]
;           |               |                       |   
;           |               |                       |
;           v               v                       v 
; map1:  List-of-numbers [Number -> Number] -> List-of-numbers

; instantiation using X: Number, and Y: Number.