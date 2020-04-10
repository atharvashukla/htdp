;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 434ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 434
;; ------------
;; Consider the following definition of smallers, one of the two “problem
;; generators” for quick-sort<:
;;
;;    ; [List-of Number] Number -> [List-of Number]
;;    (define (smallers l n)
;;      (cond
;;        [(empty? l) '()]
;;        [else (if (<= (first l) n)
;;                  (cons (first l) (smallers (rest l) n))
;;                  (smallers (rest l) n))]))
;;
;; What can go wrong when this version is used with the quick-sort< definition
;; from Recursion that Ignores Structure? 
;; -----------------------------------------------------------------------------


; It will not eliminate the pivot from the recursive argument.
; non-termination for (quick-sort '(1 1 1 1 1 1))



