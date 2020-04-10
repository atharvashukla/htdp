;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 308ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 308
;; ------------
;; Design the function replace, which substitutes the area code 713 with 281 in
;; a list of phone records.
;; -----------------------------------------------------------------------------

(require 2htdp/abstraction)

(define-struct phone [area switch num])
; A Phone# is a structure
;   (make-phone Number Number Number)
; *interpretation* phone number
; `area` is a Number [000, 999]
; switch is a Number [000, 9999]
; `num` is a Number [0000, 9999]


(define p1 (make-phone 713 664 9993))
(define p2 (make-phone 731 664 9993))
(define p3 (make-phone 713 664 9991))

(define p1-rep (make-phone 281 664 9993))
(define p2-rep (make-phone 731 664 9993))
(define p3-rep (make-phone 281 664 9991))

(check-expect (replace (list p1 p2 p3)) (list p1-rep p2-rep p3-rep))

; [List-of Phone] -> [List-of Phone]
; replaces the area code 713 with 281

(define (replace lop)
  (for/list ((p lop))
    (match p
      [(phone x y z) (make-phone (if (= x 713) 281 x) y z)])))