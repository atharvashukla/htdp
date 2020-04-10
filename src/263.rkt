;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 263ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 263
;; ------------
;; Use DrRacket’s stepper to study the steps of this calculation in detail.
;; -----------------------------------------------------------------------------

; Nelon -> Number
; determines the smallest number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define smallest-in-rest (inf (rest l))))
       (cond [(< (first l) smallest-in-rest) (first l)]
             [else smallest-in-rest]))]))


(inf (list 2 1 3)) == 1

== [beta-v]

(cond
  [(empty? (rest (list 2 1 3)))
   (first (list 2 1 3))]
  [else
   (local ((define smallest-in-rest
             (inf (rest (list 2 1 3)))))
     (cond
       [(< (first (list 2 1 3)) smallest-in-rest) (first (list 2 1 3))]
       [else smallest-in-rest]))])

== [cond-laws]

(local ((define smallest-in-rest
          (inf (rest (list 2 1 3)))))
  (cond
    [(< (first (list 2 1 3)) smallest-in-rest)
     (first (list 2 1 3))]
    [else smallest-in-rest]))

== [local-law]

(define smallest-in-rest-1
  (inf (rest (list 2 1 3))))
⊕
(cond
  [(< (first (list 2 1 3))
      smallest-in-rest-1)
   (first (list 2 1 3))]
  [else smallest-in-rest-1])


== [beta-v]

(define smallest-in-rest-1
  (cond
    [(empty? (rest (list 1 3))) (first (list 1 3))]
    [else
     (local ((define smallest-in-rest
               (inf (rest (list 1 3)))))
       (cond
         [(< (first (list 1 3)) smallest-in-rest)
          (first (list 1 3))]
         [else smallest-in-rest]))]))
⊕
(cond
  [(< (first (list 2 1 3)) smallest-in-rest-1)
   (first (list 2 1 3))]
  [else smallest-in-rest-1])

== [cond-laws]

(define smallest-in-rest-1
  (local ((define smallest-in-rest
            (inf (rest (list 1 3)))))
    (cond
      [(< (first (list 1 3)) smallest-in-rest)
       (first (list 1 3))]
      [else smallest-in-rest])))
⊕
(cond
  [(< (first (list 2 1 3)) smallest-in-rest-3) ; <- smallest-in-rest-1
   (first (list 2 1 3))]
  [else smallest-in-rest-3]) ; <- smallest-in-rest-1

== [local-law]

(define smallest-in-rest-2
  (inf (rest (list 1 3))))
⊕
(define smallest-in-rest-2 ; <- smallest-in-rest-1
  (cond
    [(< (first (list 1 3)) smallest-in-rest-2)
     (first (list 1 3))]
    [else smallest-in-rest-2]))
⊕
(cond
  [(< (first (list 2 1 3)) smallest-in-rest-2) ; <- smallest-in-rest-1
   (first (list 2 1 3))]
  [else smallest-in-rest-2]) ; <- smallest-in-rest-1

...

(define smallest-in-rest-2 3)
(define smallest-in-rest-1 1)
smallest-in-rest-1

==

1