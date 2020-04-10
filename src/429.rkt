;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 429ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 429
;; ------------
;; Use filter to define smallers and largers.
;; -----------------------------------------------------------------------------

; [List-of Number] Number -> [List-of Number]
; all numbers in alon larger than or equal to n

(check-expect (largers '(1 2 3 4 5 6 7 8 9) 4)
              '(4 5 6 7 8 9))

(check-expect (largers '(1 4 8 2 6 7 3 5 9) 4)
              '(4 8 6 7 5 9))

(check-expect (smallers '() 4) '())

(define (largers alon n)
  (filter (λ (x) (>= x n)) alon))
 
; [List-of Number] Number -> [List-of Number]
; all numbers in alon smaller than or equal to n

(check-expect (smallers '(1 2 3 4 5 6 7 8 9) 4)
              '(1 2 3 4))

(check-expect (smallers '(1 4 8 2 6 7 3 5 9) 4)
              '(1 4 2 3))

(check-expect (smallers '() 4) '())

(define (smallers alon n)
  (filter (λ (x) (<= x n)) alon))

