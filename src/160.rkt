;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 160ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 160
;; ------------
;; Design the functions set+.L and set+.R, which create a set by adding a number
;; x to some given set s for the left-hand and right-hand data definition,
;; respectively.
;; -----------------------------------------------------------------------------

; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
;
; Constraint If s is a Son.R, 
; no number occurs twice in s

; Son is used when it 
; applies to Son.L and Son.R

; Number Son.L -> Son.L
; adds x to s

(check-expect (set+.L 1 (cons 1 (cons 1 '())))
              (cons 1 (cons 1 (cons 1 '()))))
(check-expect (set+.L 2 '())
              (cons 2 '()))
(check-expect (set+.L 2 (cons 3 (cons 2 '())))
              (cons 2 (cons 3 (cons 2 '()))))

(define (set+.L x s)
  (cons x s))

; ---

; Number Son.R -> Son.R
; adds x to s


(check-expect (set+.R 1 (cons 1 '()))
              (cons 1 '()))

(check-expect (set+.R 2 '())
              (cons 2 '()))

(check-expect (set+.R 2 (cons 3 (cons 2 '())))
              (cons 3 (cons 2 '())))

(define (set+.R x s)
  (if (member? x s)
      s
      (cons x s)))

