;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 111ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 111.
;; -------------
;; Take a look at these definitions:
;;
;;    (define-struct vec [x y])
;;    ; A vec is
;;    ;   (make-vec PositiveNumber PositiveNumber)
;;    ; interpretation represents a velocity vector
;;
;; Develop the function checked-make-vec, which is to be understood as a checked
;; version of the primitive operation make-vec. It ensures that the arguments to
;; make-vec are positive numbers. In other words, checked-make-vec enforces our
;; informal data definition. 
;; -----------------------------------------------------------------------------

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector

; ---

; Any Any -> Vec
; enforces the types in the informal data definition of vec

(check-expect (checked-make-vec 1 1) (make-vec 1 1))
(check-error (checked-make-vec -1 1) "first argument is not a positive number")
(check-error (checked-make-vec 1 -1) "second argument is not a positive number")
(check-error (checked-make-vec -1 -1) "first argument is not a positive number")

(define (checked-make-vec x y)
  (cond
    [(not (and (number? x) (positive? x))) (error "first argument is not a positive number")]
    [(not (and (number? y) (positive? y))) (error "second argument is not a positive number")]
    [else (make-vec x y)]))