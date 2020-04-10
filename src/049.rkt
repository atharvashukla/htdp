;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 49ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 48.
;; ------------
;; A cond expression is really just an expression and may therefore show up in
;; the middle of another expression:
;;
;;    (- 200 (cond [(> y 200) 0] [else y]))
;;
;; Use the stepper to evaluate the expression for y as 100 and 210.
;;
;;    (define WIDTH  100)
;;    (define HEIGHT  60)
;;    (define MTSCN  (empty-scene WIDTH HEIGHT))
;;    (define ROCKET (bitmap "rocket.png"))
;;    (define ROCKET-CENTER-TO-TOP
;;      (- HEIGHT (/ (image-height ROCKET) 2)))
;;     
;;    (define (create-rocket-scene.v5 h)
;;      (cond
;;        [(<= h ROCKET-CENTER-TO-TOP)
;;         (place-image ROCKET 50 h MTSCN)]
;;        [(> h ROCKET-CENTER-TO-TOP)
;;         (place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)]))
;;
;; Nesting cond expressions can eliminate common expressions. Consider the
;; function for launching a rocket, repeated in figure 20. Both branches of the
;; cond expression have the same shape except as indicated with ...:
;;
;;    (place-image ROCKET X ... MTSCN)
;;
;; Reformulate create-rocket-scene.v5 to use a nested expression; the resulting
;; function mentions place-image only once. 
;; -----------------------------------------------------------------------------


;; y = 100

(- 200 (cond [(> 100 200) 0] [else 100]))

;; ==

(- 200 (cond [#false 0] [else 100]))

;; ==

(- 200 (cond [else 100]))

;; ==

(- 200 100)

;; ==

100


;; y = 120

(- 200 (cond [(> 120 200) 0] [else 120]))

;; ==

(- 200 (cond [#false 0] [else 120]))

;; ==

(- 200 (cond [else 120]))

;; ==

(- 200 120)

;; ==

80


(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))
 
(define (create-rocket-scene.v5 h)
  (cond
    [(<= h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 h MTSCN)]
    [(> h ROCKET-CENTER-TO-TOP)
     (place-image ROCKET 50 ROCKET-CENTER-TO-TOP MTSCN)]))



(define (create-rocket-scene.v5.2 h)
  (place-image
   ROCKET
   50
   (cond [(<= h ROCKET-CENTER-TO-TOP) h]
         [(> h ROCKET-CENTER-TO-TOP) ROCKET-CENTER-TO-TOP])
   MTSCN))



