;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 236ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 236
;; ------------
;; Create test suites for the following two functions:
;;
;;    ; Lon -> Lon
;;    ; adds 1 to each item on l
;;    (define (add1* l)
;;      (cond
;;        [(empty? l) '()]
;;        [else (cons (add1 (first l)) (add1* (rest l)))]))
;;         
;;    
;;    ; Lon -> Lon
;;    ; adds 5 to each item on l
;;    (define (plus5 l)
;;      (cond
;;        [(empty? l) '()]
;;        [else (cons (+ (first l) 5) (plus5 (rest l)))]))
;;
;; Then abstract over them. Define the above two functions in terms of the
;; abstraction as one-liners and use the existing test suites to confirm that
;; the revised definitions work properly. Finally, design a function that
;; subtracts 2 from each number on a given list.
;; -----------------------------------------------------------------------------


; Lon -> Lon
; adds 1 to each item on l
(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons (add1 (first l)) (add1* (rest l)))]))

(check-expect (add1* '(1 2 3 4)) '(2 3 4 5))
(check-expect (add1* '()) '())
(check-expect (add1* '(3)) '(4))
(check-expect (add1* '(4 5 0 -1)) '(5 6 1 0))
     

; Lon -> Lon
; adds 5 to each item on l
(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else (cons (+ (first l) 5) (plus5 (rest l)))]))

(check-expect (plus5 '(1 2 3 4)) '(6 7 8 9))
(check-expect (plus5 '()) '())
(check-expect (plus5 '(3)) '(8))
(check-expect (plus5 '(4 5 0 -1)) '(9 10 5 4))

;; LON -> LON
;; adds val to each number on l
(define (operate l val)
  (cond
    [(empty? l) '()]
    [else (cons
      (+ (first l) val) (operate (rest l) val))]))

;; LON -> LON
;; adds 1 to each number on l
(define (add1*.v2 l)
  (operate l 1))

(check-expect (add1*.v2 '(1 2 3 4)) '(2 3 4 5))
(check-expect (add1*.v2 '()) '())
(check-expect (add1*.v2 '(3)) '(4))
(check-expect (add1*.v2 '(4 5 0 -1)) '(5 6 1 0))

;; LON -> LON
;; adds one to each number on l
(define (plus5.v2 l)
  (operate l 5))

(check-expect (plus5.v2 '(1 2 3 4)) '(6 7 8 9))
(check-expect (plus5.v2 '()) '())
(check-expect (plus5.v2 '(3)) '(8))
(check-expect (plus5.v2 '(4 5 0 -1)) '(9 10 5 4))