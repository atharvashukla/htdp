;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 251ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 251
;; ------------
;; 
;; Design fold1, which is the abstraction of the two functions in figure 93.
;;
;;    ; [List-of Number] -> Number
;;    ; computes the sum of 
;;    ; the numbers on l
;;    (define (sum l)
;;      (cond
;;        [(empty? l) 0]
;;        [else (+ (first l) (sum (rest l)))]))
;;      
;;    
;;    ; [List-of Number] -> Number
;;    ; computes the product of 
;;    ; the numbers on l
;;    (define (product l)
;;      (cond
;;        [(empty? l) 1]
;;        [else (* (first l) (product (rest l)))]))
;;
;; Figure 93: The similar functions for exercise 251
;; -----------------------------------------------------------------------------


; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(define (sum l)
  (cond
    [(empty? l) 0]
    [else (+ (first l) (sum (rest l)))]))
  

; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(define (product l)
  (cond
    [(empty? l) 1]
    [else (* (first l) (product (rest l)))]))


; concrete tests

(define list1 (list 1 2 3))
(define list2 (list 3 3 3))

(check-expect (sum list1) 6)
(check-expect (product list1) 6)

(check-expect (sum list2) 9)
(check-expect (product list2) 27)

; [List-of Number] -> Number
; computes f of the numbers
; on l with base case b
(define (fold1 l f b)
  (cond
    [(empty? l) b]
    [else (f (first l) (fold1 (rest l) f b))]))

(check-expect (fold1 '() * 1) 1)
(check-expect (fold1 '(1 2 3) + 99) (+ 1 2 3 99))

; abstract tests

(check-expect (sum-fold list1) (sum list1))
(check-expect (sum-fold list2) (sum list2))

(define (sum-fold l)
  (fold1 l + 0))

(check-expect (product-fold list1) (product list1))
(check-expect (product-fold list2) (product list2))

(define (product-fold l)
  (fold1 l * 1))

