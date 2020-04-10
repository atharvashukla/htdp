;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 265ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 265
;; ------------
;; Use DrRacket’s stepper to fill in any gaps above.
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