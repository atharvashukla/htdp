;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 247ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------+
| Exercise 247.                                                         |
| +-----------+                                                         |
| Evaluate (extract < (cons 8 (cons 4 '())) 5) with DrRacket’s stepper. |
+-----------------------------------------------------------------------+
|#

(define (extract R l t)
  (cond
    [(empty? l) '()]
    [(R (first l) t) (cons (first l) (extract R (rest l) t))]
    [else (extract R (rest l) t)]))

; (extract < (cons 8 (cons 4 '())) 5)

; ==

; R -> <
; l -> (cons 8 (cons 4 '()))
; t -> 5


; cond-clause 1 -> (empty? (cons 8 (cons 4 '())) == #false
; cond-clause 2 -> (< 8 5) == #false
; cond-clause 3 -> (extract < (cons 4 '())

;  ----- (extract < (cons 4 '())

; cond-clause 1 ->  (empty? (cons 8 (cons 4 '())) == #false
; cond-clause 2 -> (< 4 5) == true => (cons 4 (extract < '() 4))

;  ----- (cons 4 (extract < '() 4))

; cons-clause 1 -> (empty? '()) == #true => (cons 4 '())


; (extract < (cons 8 (cons 4 '()) 5) == (cons 4 '() == (list 4)

(check-expect (extract < (cons 8 (cons 4 '())) 5) (list 4)) 
