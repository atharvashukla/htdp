;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 272ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 272
;; ------------
;; Recall that the append function in ISL concatenates the items of two lists
;; or, equivalently, replaces '() at the end of the first list with the second
;; list:
;;
;;    (equal? (append (list 1 2 3) (list 4 5 6 7 8))
;;            (list 1 2 3 4 5 6 7 8))
;;
;; Use foldr to define append-from-fold. What happens if you replace foldr with
;; foldl?
;; 
;; Now use one of the fold functions to define functions that compute the sum
;; and the product, respectively, of a list of numbers.
;;
;; With one of the fold functions, you can define a function that horizontally
;; composes a list of Images. Hints (1) Look up beside and empty-image. Can you
;; use the other fold function? Also define a function that stacks a list of
;; images vertically. (2) Check for above in the libraries. 
;; -----------------------------------------------------------------------------


; [List-of Number] [List-of Number] -> [List-of Number]
; appeds l1 and l2

(check-expect (append-from-fold '() '()) '())
(check-expect (append-from-fold '() '(1 2 3)) '(1 2 3))
(check-expect (append-from-fold '(1 2 3) '()) '(1 2 3))
(check-expect (append-from-fold '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))

(define (append-from-fold l1 l2)
  (foldr cons l2 l1))

; [List-of Number] -> Number
; sum of all the numbers in l

(check-expect (sum-from-fold '()) 0)
(check-expect (sum-from-fold '(1 2 3)) (+ 1 2 3))

(define (sum-from-fold l)
  (foldr + 0 l))

; [List-of Number] -> Number
; product from fold

(check-expect (product-from-fold '()) 1)
(check-expect (product-from-fold '(1 2 3)) (* 1 2 3))

(define (product-from-fold l)
  (foldr * 1 l))


(require 2htdp/image)

(define img1 (circle 50 "solid" "red"))
(define img2 (circle 30 "solid" "green"))
(define img3 (circle 20 "solid" "blue"))

(define horizontal-combine (beside img1 img2 img3))
(define vertical-combine (above img1 img2 img3))

;; [List-of Image] -> Image
;; combines all images in lo-img horizontally

(check-expect (beside-from-fold '()) empty-image)
(check-expect (beside-from-fold (list img1 img2 img3)) horizontal-combine)

(define (beside-from-fold lo-img)
  (foldr beside empty-image lo-img))


;; [List-of Image] -> Image
;; combines all images in lo-img horizontally (using foldl)

(check-expect (beside-from-fold2 '()) empty-image)
(check-expect (beside-from-fold2 (list img1 img2 img3)) horizontal-combine)

(define (beside-from-fold2 lo-img)
  (foldl beside empty-image (reverse lo-img)))

;; [List-of Image] -> Image
;; stacks all images in lo-img vertically (first image on top)

(check-expect (above-from-fold '()) empty-image)
(check-expect (above-from-fold (list img1 img2 img3)) vertical-combine)

(define (above-from-fold lo-img)
  (foldr above empty-image lo-img))





