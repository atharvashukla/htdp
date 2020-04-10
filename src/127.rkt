;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 127ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 127.
;; -------------
;; Suppose the program contains
;;
;;    (define-struct ball [x y speed-x speed-y])
;; 
;; Predict the results of evaluating the following expression:
;; 
;;    1. (number? (make-ball 1 2 3 4))
;;    
;;    2. (ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))
;;    
;;    3. (ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))
;;    
;;    4. (ball-x (make-posn 1 2))
;;    
;;    5. (ball-speed-y 5)
;;
;; Check your predictions in the interactions area and with the stepper. 
;; -----------------------------------------------------------------------------


(define-struct ball [x y speed-x speed-y])


(number? (make-ball 1 2 3 4))
; (make-ball 1 2 3 4) is of type ball not number.
; #false

(ball-speed-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; == (ball-speed-y (make-ball 3 6 2 3))
; == 3

(ball-y (make-ball (+ 1 2) (+ 3 3) 2 3))
; == (ball-y (make-ball 3 6 2 3))
; == 6


(ball-x (make-posn 1 2))
; (make-posn 1 2) is not a ball,
; trying ton extract a ball field will result in an error

