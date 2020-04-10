;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 252ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 252
;; ------------
;; Design fold2, which is the abstraction of the two functions in figure 94.
;; Compare this exercise with exercise 251. Even though both involve the product
;; function, this exercise poses an additional challenge because the second
;; function, image*, consumes a list of Posns and produces an Image. Still, the
;; solution is within reach of the material in this section, and it is
;; especially worth comparing the solution with the one to the preceding
;; exercise. The comparison yields interesting insights into abstract
;; signatures.
;;
;;    ; [List-of Number] -> Number
;;    (define (product l)
;;      (cond
;;        [(empty? l) 1]
;;        [else (* (first l) (product (rest l)))]))
;;      
;;    
;;    ; [List-of Posn] -> Image
;;    (define (image* l)
;;      (cond
;;        [(empty? l) emt]
;;        [else (place-dot (first l) (image* (rest l)))]))
;;     
;;    ; Posn Image -> Image 
;;    (define (place-dot p img)
;;      (place-image dot (posn-x p) (posn-y p) img))
;;     
;;    ; graphical constants:    
;;    (define emt (empty-scene 100 100))
;;    (define dot (circle 3 "solid" "red"))
;;
;; Figure 94: The similar functions for exercise 252
;; -----------------------------------------------------------------------------

(require 2htdp/image)

; [List-of Number] -> Number
(define (product l)
  (cond
    [(empty? l) 1]
    [else (* (first l) (product (rest l)))]))
  
; [List-of Posn] -> Image
(define (image* l)
  (cond
    [(empty? l) emt]
    [else (place-dot (first l) (image* (rest l)))]))
 
; Posn Image -> Image 
(define (place-dot p img)
  (place-image dot (posn-x p) (posn-y p) img))
 
; graphical constants:    
(define emt (empty-scene 100 100))
(define dot (circle 3 "solid" "red"))


(define posn-lst1 (list (make-posn 50 50) (make-posn 25 25) (make-posn 75 75)))
(define posn-lst2 (list (make-posn 50 50) (make-posn 50 25) (make-posn 50 75)))

(define img1 (place-image dot 50 50 (place-image dot 25 25 (place-image dot 75 75 emt))))
(define img2 (place-image dot 50 50 (place-image dot 50 25 (place-image dot 50 75 emt))))

(check-expect (image* '()) emt)
(check-expect (image* posn-lst1) img1)
(check-expect (image* posn-lst2) img2)
(check-expect (product '()) 1)
(check-expect (product '(1 2 3)) 6)

; [List-of from] [from to -> to] base  -> base
; applies f from right to left to each item in l and b
(define (fold2 l f b)
  (cond
    [(empty? l) b]
    [else (f (first l) (fold2 (rest l) f b))]))

(check-expect (fold-product '()) (product '()))
(check-expect (fold-product '(1 2 3)) (product '(1 2 3)))

(define (fold-product l)
  (fold2 l * 1))

(check-expect (fold-image* '()) (image* '()))
(check-expect (fold-image* posn-lst1) (image* posn-lst1))
(check-expect (fold-image* posn-lst2) (image* posn-lst2))

(define (fold-image* l)
  (fold2 l place-dot emt))
