;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 67ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 67.
;; ------------
;; 
;; Here is another way to represent bouncing balls:
;;
;;    (define SPEED 3)
;;    (define-struct balld [location direction])
;;    (make-balld 10 "up")
;; 
;; Interpret this code fragment and create other instances of balld.
;;
;; -----------------------------------------------------------------------------

; the speed of the ball
(define SPEED 3)
; location is the number of px from the top
; direction is one of "up" or "down"
(define-struct balld [location direction])

(make-balld 10 "up")
; a ball moving up at 3px per second currently 10px from the top


