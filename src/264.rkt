;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 264ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 264 
;; ------------
;; Use DrRacket’s stepper to calculate out how it evaluates
;;
;;    (sup (list 2 1 3))
;;
;; where sup is the function from figure 89 equipped with local.
;;
;; For the explanation of the lifting step, we use a toy example that gets to
;; the heart of the issue, namely, that functions are now values:
;;
;;    ((local ((define (f x) (+ (* 4 (sqr x)) 3))) f)
;;     1)
;;
;; Deep down we know that this is equivalent to (f 1) where
;;
;;    (define (f x) (+ (* 4 (sqr x)) 3))
;;
;; but the rules of pre-algebra don’t apply. The key is that functions can be
;; the result of expressions, including local expressions. And the best way to
;; think of this is to move such local definitions to the top and to deal with
;; them like ordinary definitions. Doing so renders the definition visible for
;; every step of the calculation. By now you also understand that the renaming
;; step makes sure that the lifting of definitions does not accidentally conflate
;; names or introduce conflicting definitions.
;;
;; Here are the first two steps of the calculation:
;;
;;    ((local ((define (f x) (+ (* 4 (sqr x)) 3))) f)
;;     1)
;;    ==
;;    ((local ((define (f-1 x) (+ (* 4 (sqr x)) 3)))
;;       f-1)
;;     1)
;;    ==
;;    (define (f-1 x) (+ (* 4 (sqr x)) 3))
;;    ⊕
;;    (f-1 1)
;;
;; Remember that the second step of the local rule replaces the local expression
;; with its body. In this case, the body is just the name of the function, and
;; its surrounding is an application to 1. The rest is arithmetic:
;;
;;    (f-1 1) == (+ (* 4 (sqr 1)) 3) == 7
;;
;; -----------------------------------------------------------------------------


; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define sup-rest (sup (rest l))))
       (if (> (first l) sup-rest)
           (first l)
           sup-rest))]))


(sup (list 2 1 3))

== [beta-v]

(cond
  ((empty? (rest (list 2 1 3))) (first (list 2 1 3)))
 (else
  (local
    ((define sup-rest (sup (rest (list 2 1 3)))))
    (if (> (first (list 2 1 3)) sup-rest) (first (list 2 1 3)) sup-rest))))

== [cond]

(local
 ((define sup-rest (sup (rest (list 2 1 3)))))
 (if (> (first (list 2 1 3)) sup-rest) (first (list 2 1 3)) sup-rest))

== [local]

(define sup-rest_0 (sup (rest (list 2 1 3))))
(if (> (first (list 2 1 3)) sup-rest_0) (first (list 2 1 3)) sup-rest_0)

== [beta-v]

(define sup-rest_0
  (cond
   ((empty? (rest (list 1 3))) (first (list 1 3)))
   (else
    (local
     ((define sup-rest (sup (rest (list 1 3)))))
     (if (> (first (list 1 3)) sup-rest) (first (list 1 3)) sup-rest)))))
(if (> (first (list 2 1 3)) sup-rest_0) (first (list 2 1 3)) sup-rest_0)

== [cond]

(define sup-rest_0
  (local
   ((define sup-rest (sup (rest (list 1 3)))))
   (if (> (first (list 1 3)) sup-rest) (first (list 1 3)) sup-rest)))
(if (> (first (list 2 1 3)) sup-rest_0) (first (list 2 1 3)) sup-rest_0)

== [local]

(define sup-rest_1 (sup (rest (list 1 3))))
(define sup-rest_0
  (if (> (first (list 1 3)) sup-rest_1) (first (list 1 3)) sup-rest_1))
(if (> (first (list 2 1 3)) sup-rest_0) (first (list 2 1 3)) sup-rest_0)

== [beta-v]

(define sup-rest_1
  (cond
   ((empty? (rest (list 3))) (first (list 3)))
   (else
    (local
     ((define sup-rest (sup (rest (list 3)))))
     (if (> (first (list 3)) sup-rest) (first (list 3)) sup-rest)))))
(define sup-rest_0
  (if (> (first (list 1 3)) sup-rest_1) (first (list 1 3)) sup-rest_1))
(if (> (first (list 2 1 3)) sup-rest_0) (first (list 2 1 3)) sup-rest_0)

== [cond]

(define sup-rest_1 (first (list 3)))
(define sup-rest_0
  (if (> (first (list 1 3)) sup-rest_1) (first (list 1 3)) sup-rest_1))
(if (> (first (list 2 1 3)) sup-rest_0) (first (list 2 1 3)) sup-rest_0)

==

(define sup-rest_1 3)
(define sup-rest_0 sup-rest_1)
(if (> (first (list 2 1 3)) sup-rest_0) (first (list 2 1 3)) sup-rest_0)

==

(define sup-rest_1 3)
(define sup-rest_0 3)
sup-rest_0

==

3