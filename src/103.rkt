;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 103ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 103.
;; -------------
;; Develop a data representation for the following four kinds of zoo animals:
;;
;; - spiders, whose relevant attributes are the number of remaining legs (we
;;   assume that spiders can lose legs in accidents) and the space they need in
;;   case of transport;
;; - elephants, whose only attributes are the space they need in case of
;;   transport;
;; - boa constrictors, whose attributes include length and girth; and
;; - armadillos, for which you must determine appropriate attributes, including
;;   one that determines the space needed for transport.
;;
;; Develop a template for functions that consume zoo animals.
;;
;; Design the fits? function, which consumes a zoo animal and a description of
;; a cage. It determines whether the cage’s volume is large enough for the
;; animal. 
;; -----------------------------------------------------------------------------

(define-struct spider [legs space])
; A Spider is a structure
;   (make-spider Number Number)
; interpretation. the number of `legs` and
; the `space` needed for transportation

(define spider-ex1 (make-spider 8 2))
(define spider-ex2 (make-spider 7 3))


(define-struct elephant [space])
; An Elephant is a structure
;   (make-elephant Number)
; interpretation. the `space` needed for
; transportation

(define elephant-ex1 (make-elephant 800))
(define elephant-ex2 (make-elephant 600))

(define-struct boa-constrictor [length girth])
; A BoaConstrictor is a structure
;   (make-boa-constrictor Number Number)
; interpretation. the `length` and the `girth`
; of the boa constrictor

(define boa-ex1 (make-boa-constrictor 3 10))
(define boa-ex2 (make-boa-constrictor 4 12))

(define-struct armadillo [type space])
; An Armadillo is a structure
;   (make-armadillo String Number)
; interpretation. the `type` of armadillo
; and the space needed for transportation

(define armadillo-ex1 (make-armadillo "screaming hairy armadillo" 20))
(define armadillo-ex2 (make-armadillo "big hairy armadillo" 15))


; A ZooAnimal is one of
; - Spider
; - Elephant
; - BoaConstrictor
; - Armadillo
; interpretation. 4 kinds of zoo animals.


; ZooAnimal -> ...
#;; Template for ZooAnimal
(define (zoo-animal-temp za)
  (cond
    [(spider? za) (... (spider-legs za) ... (spider-space za) ...)]
    [(elephant? za) (... (elephant-space za) ...)]
    [(boa-constrictor? za) (... (boa-constrictor-length za) ... (boa-constrictor-girth za) ...)]
    [(armadillo? za) (... (armadillo-type za) ... (armadillo-space za) ...)]))


; ZooAnimal Number -> Boolean
; does za fit in cage of size c?

(check-expect (fit? spider-ex2 8) #true)
(check-expect (fit? boa-ex2 45) #false)
(check-expect (fit? elephant-ex1 800) #true)
(check-expect (fit? armadillo-ex1 12) #false)

(define (fit? za c)
  (cond
    [(spider? za) (<= (spider-space za) c)]
    [(elephant? za) (<= (elephant-space za) c)]
    [(boa-constrictor? za) (<= (boa-constrictor-space za) c)]
    [(armadillo? za) (<= (armadillo-space za) c)]))


; BoaConstrictor -> Number
; the space consumed by bc
; V = (C^2 * H)/ 4*pi
(check-within (boa-constrictor-space boa-ex1) 23.87 0.01)
(check-within (boa-constrictor-space boa-ex2) 45.83 0.01)

(define (boa-constrictor-space bc)
  (/ (* (sqr (boa-constrictor-girth bc)) (boa-constrictor-length bc)) 
     (* 4 pi)))