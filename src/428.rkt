;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 428ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 428
;; ------------
;; If the input to quick-sort< contains the same number several times, the
;; algorithm returns a list that is strictly shorter than the input. Why? Fix
;; the problem so that the output is as long as the input.
;; -----------------------------------------------------------------------------

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct

(check-expect (quick-sort< '(1 4 2 0 8 7 3))
              (list 0 1 2 3 4 7 8))

(check-expect (quick-sort< '()) '())

(check-expect (quick-sort< '(1 3 3 5 2 2 5 2))
              ; '(1 2 3 5) ; this removes the number that's the same as the pivot
              (list 1 2 2 2 3 3 5 5))

(check-expect (quick-sort< '(8 8 8 8 8 8))
              ; '(8) ; this removes the number that's the same as the pivot
              '(8 8 8 8 8 8))

(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (sames alon pivot)
                    (quick-sort< (largers alon pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
; numbers in alon strictly larger than n

(check-expect (largers '(4 2 5 2 9 7) 2) '(4 5 9 7))
(check-expect (largers '(2 2 2 2 2) 2) '())

(define (largers alon n)
  (filter (λ (x) (> x n)) alon))
 
; [List-of Number] Number -> [List-of Number]
; numbers in alon strictly smaller than n

(check-expect (smallers '(4 2 1 2 9 7) 2) '(1))
(check-expect (smallers '(2 2 2 2 2) 2) '())

(define (smallers alon n)
  (filter (λ (x) (< x n)) alon))


; [List-of Number] Number -> [List-of Number]
; numbers in alon that re the same as n

(check-expect (sames '(1 2 3 4 2 9 3 3) 3) '(3 3 3))
(check-expect (sames '(1 2 3 4 2 9 3 3) 0) '())
(check-expect (sames '() 0) '())

(define (sames alon n)
  (filter (λ (x) (= x n)) alon))


; largers and smallers were ignoring the same numbers. the
; helper sames saves the day