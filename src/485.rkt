;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 485ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 485
;; ------------
;; A number tree is either a number or a pair of number trees. Design sum-tree,
;; which determines the sum of the numbers in a tree. What is its abstract
;; running time? What is an acceptable measure of the size of such a tree? What
;; is the worst possible shape of the tree? What’s the best possible shape?
;; -----------------------------------------------------------------------------


; NumberTree (NT) is one of
; - Number
; - (list NT NT)
; interpretation, a tree of numbers


(define t0 7)
(define t1 (list 3 4))
(define t2 (list t0 t1))
(define t3 (list t2 t2))



; NT -> Number
; num of all the numbers in a tree

(check-expect (sum-tree t0) 7)
(check-expect (sum-tree t3) 28)

(define (sum-tree nt)
  (cond
    [(number? nt) nt]
    [else (+ (sum-tree (first nt))
             (sum-tree (second nt)))]))


;; What is its abstract running time?
;; => On the order of n

;; What is an acceptable measure of the size of such a tree?
;; => The nodes of a tree (depth for some uses)

;; What is the worst possible shape of the tree?
;; => one single branch (like a list)

;; What’s the best possible shape?
;; => equal amount of nodes in both the sub-trees