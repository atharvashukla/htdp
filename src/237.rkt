;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 237ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 237
;; ------------
;;  Evaluate (squared>? 3 10) and (squared>? 4 10) in DrRacket. How about
;; (squared>? 5 10)? 
;; -----------------------------------------------------------------------------

; Lon Number -> Lon
; select those numbers on l
; that are below t
(define (small l t)
  (cond
    [(empty? l) '()]
    [else (cond [(< (first l) t) (cons (first l) (small (rest l) t))]
                [else (small (rest l) t)])]))

(check-expect (small '(1 2 3 4 5) 4) '(1 2 3))

; Lon Number -> Lon
; select those numbers on l
; that are above t
(define (large l t)
  (cond [(empty? l) '()]
        [else (cond [(> (first l) t) (cons (first l) (large (rest l) t))]
                    [else (large (rest l) t)])]))

(check-expect (large '(1 2 3 4 5) 4) '(5))

; Comp Lon Number -> Lon
; uses Comp to compare the numbersin l with t
; and produces a Lon that pass the comparison
(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else (cond [(R (first l) t) (cons (first l) (extract R (rest l) t))]
                [else (extract R (rest l) t)])]))

(check-expect (extract < '() 5) (small '() 5))
(check-expect (extract < '(3) 5) (small '(3) 5))
(check-expect (extract < '(1 6 4) 5)
              (small '(1 6 4) 5))

; Lon Number -> Lon
(define (small-1 l t)
  (extract < l t))

(check-expect (small-1 '(1 2 3 4 5) 4) '(1 2 3))

; Lon Number -> Lon
(define (large-1 l t)
  (extract > l t))

(check-expect (large-1 '(1 2 3 4 5) 4) '(5))


; Lon Number -> Lon
(define (equal-1 l t)
  (extract = l t))

(check-expect (equal-1 '(1 2 3 4 5) 4) '(4))


; Number Number -> Boolean
; is the area of a square with side x larger than c
(define (squared>? x c)
  (> (* x x) c))

(extract squared>? (list 3 4 5) 10)

(squared>? 3 10)
; => #false
(squared>? 4 10)
; => #true
(squared>? 5 10)
; => #true