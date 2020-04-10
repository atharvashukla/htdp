;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 126ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 126.
;; -------------
;; Identify the values among the following expressions, assuming the
;; definitions area contains these structure type definitions:
;;
;;    (define-struct point [x y z])
;;    (define-struct none  [])
;;
;;    1. (make-point 1 2 3)
;;    
;;    2. (make-point (make-point 1 2 3) 4 5)
;;    
;;    3. (make-point (+ 1 2) 3 4)
;;    
;;    4. (make-none)
;;    
;;    5. (make-point (point-x (make-point 1 2 3)) 4 5)
;;
;; Explain why the expressions are values or not. 
;; -----------------------------------------------------------------------------




(define-struct point [x y z])
(define-struct none  [])



; 1.
(make-point 1 2 3)
; this is a value, the language specification defines a struct instance
; as a type of value

; 2.
(make-point (make-point 1 2 3) 4 5)
; structure instances are values, this may not make sense according to the
; informal invariants of a data definition, it is, still a value

; 3.
(make-point (+ 1 2) 3 4)
;  this is a value the subexpression is evaluated and the whole expression is
; a structure instance

; 4.
(make-none)
; this is a proper structure instance of the none struct, it is therefore a
; value

; 5.
(make-point (point-x (make-point 1 2 3)) 4 5)
; this is a value because according to the evalueation rule
; of the selector function, (point-x (make-point 1 2 3)) == 1.
; and (make-point (point-x (make-point 1 2 3)) 4 5) ==
; (make-point 1 4 5), which is a value







