;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 404ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 404
;; ------------
;; Design the function andmap2. It consumes a function f from two values to
;; Boolean and two equally long lists. Its result is also a Boolean.
;; Specifically, it applies f to pairs of corresponding values from the two
;; lists, and if f always produces #true, andmap2 produces #true, too.
;; Otherwise, andmap2 produces #false. In short, andmap2 is like andmap but for
;; two lists.
;; -----------------------------------------------------------------------------

; [X Y] [X Y -> Boolean] [List-of X] [List-of Y] -> Boolean
; applies f to elements of l1 and l2, returns #t if all
; applications are #t, otherwise #f.
; ASSUMPTION. l1 and l2 have the same length

(check-expect (andmap2 > '(2 3 4) '(1 2 3)) #true)
(check-expect (andmap2 (λ (x y) (string=? (number->string x) y)) '(1 2 3) '("1" "2" "3"))
              #true)
(check-expect (andmap2 (λ (x y) (string=? (number->string x) y)) '(1 4 3) '("1" "2" "3"))
              #false)
(check-expect (andmap2 > '() '()) #true)

(define (andmap2 f l1 l2)
  (cond
    [(empty? l1) #true]
    [else (and (f (first l1) (first l2))
               (andmap2 f (rest l1) (rest l2)))]))



