;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 292ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+---------------------------------------------------------------------------+
| Exercise 292.                                                             |
| +-----------+                                                             |
| Design the function sorted?, which comes with the following signature and |
| purpose statement:                                                        |
| ; [X X -> Boolean] [NEList-of X] +> Boolean                               |
| ; determines whether l is sorted according to cmp                         |
|                                                                           |
| (check-expect (sorted? < '(1 2 3)) #true)                                 |
| (check-expect (sorted? < '(2 1 3)) #false)                                |
|                                                                           |
| (define (sorted? cmp l)                                                   |
|   #false)                                                                 |
| The wish list even includes examples.                                     |
+---------------------------------------------------------------------------+
|#

; [X X -> Boolean] [NEList-of X] -> Boolean 
; determines whether l is sorted according to cmp
 
(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(2 1 3)) #false)
(check-expect (sorted? <= '(1)) #true)
 
(define (sorted? cmp l)
  (cond
    [(empty? (rest l)) #true]
    [else (and (cmp (first l) (second l))
               (sorted? cmp (rest l)))]))


;; Extra: here's a version that can also consume '()

(check-expect (sorted?2 < '(1 2 3)) #true)
(check-expect (sorted?2 < '(2 1 3)) #false)
(check-expect (sorted?2 < '()) #true)

; [X X -> Boolean] [NEList-of X] -> Boolean 
; determines whether l is sorted according to cmp
(define (sorted?2 cmp l)
  (cond
    [(empty? l) #true]
    [else (if (empty? (rest l)) ; could have called sorded? here
              #true
              (and (cmp (first l) (second  l))
                   (sorted?2 cmp (rest l))))]))


