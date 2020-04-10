;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 105ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 104.
;; -------------
;; Some program contains the following data definition:
;;
;;    ; A Coordinate is one of: 
;;    ; – a NegativeNumber 
;;    ; interpretation on the y axis, distance from top
;;    ; – a PositiveNumber 
;;    ; interpretation on the x axis, distance from left
;;    ; – a Posn
;;    ; interpretation an ordinary Cartesian point
;;
;; Make up at least two data examples per clause in the data definition. For
;; each of the examples, explain its meaning with a sketch of a canvas. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)

(define BACKG (empty-scene 200 200))
(define point (circle 5 "solid" "red"))

; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point


; Examples of the first clause:
(define cneg-1 -50)
(define cneg-2 -10)

; Examples of the second clause:
(define cpos-1 50)
(define cpos-2 10)

; Examples of the third clause:
(define cposn-1 (make-posn 50 10))
(define cposn-2 (make-posn 10 50))


(define canv-cneg-1  (place-image point (* -1 cneg-1) 0 BACKG))
(define canv-cneg-2  (place-image point(* -1 cneg-2) 0 BACKG))
(define canv-cpos-1  (place-image point 0 cpos-1 BACKG))
(define canv-cpos-2  (place-image point 0 cpos-2 BACKG))
(define canv-cposn-1 (place-image point (posn-x cposn-1) (posn-y cposn-1) BACKG))
(define canv-cposn-2 (place-image point (posn-x cposn-2) (posn-y cposn-2) BACKG))


; on the y axis
canv-cneg-1
canv-cneg-2
; on the x axis
canv-cpos-1
canv-cpos-2
; any posn
canv-cposn-1
canv-cposn-2