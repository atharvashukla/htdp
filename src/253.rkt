;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 253ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 253
;; ------------
;; Each of these signatures describes a class of functions:
;;
;;    ; [Number -> Boolean]
;;    ; [Boolean String -> Boolean]
;;    ; [Number Number Number -> Number]
;;    ; [Number -> [List-of Number]]
;;    ; [[List-of Number] -> Boolean]
;; 
;; Describe these collections with at least one example from ISL.
;; -----------------------------------------------------------------------------




; [Number -> Boolean]

odd?

; [Boolean String -> Boolean]

; is s the same as the canonical string form of the boolean b
; i.e. is s either "#true" or "#false"?
(check-expect (string=boolean? #t "#true") #true)
(check-expect (string=boolean? #t "troo") #false)
(define (string=boolean? b s)
  (string=? (boolean->string b) s))

string=boolean?


; [Number Number Number -> Number]
; add a and b then divide the result by c
(check-expect (add-div 9 3 4) 3)
(check-expect (add-div 0 0 1) 0)
(define (add-div a b c)
  (/ (+ a b) c))

add-div

; [Number -> [List-of Number]]

; list of numbers from
(check-expect (n-to-0 5) '(5 4 3 2 1 0))
(check-expect (n-to-0 0) '(0))
(define (n-to-0 n)
  (cond
    [(= 0 n) (list 0)]
    [else (cons n (n-to-0 (sub1 n)))]))

; [[List-of Number] -> Boolean]
(check-expect (all-even? '()) #true)
(check-expect (all-even? '(1 2 3)) #false)
(check-expect (all-even? '(0 2 4)) #true)
(define (all-even? l)
  (cond
    [(empty? l) #t]
    [else (and (even? (first l))
               (all-even? (rest l)))]))

all-even?