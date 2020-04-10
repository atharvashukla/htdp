;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 281ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 281
;; ------------
;; Write down a lambda expression that
;; 
;; 1. consumes a number and decides whether it is less than 10;
;; 2. multiplies two given numbers and turns the result into a string;
;; 3. consumes a natural number and returns 0 for evens and 1 for odds;
;; 4. consumes two inventory records and compares them by price; and
;; 5. adds a red dot at a given Posn to a given Image.
;; 
;; Demonstrate how to use these functions in the interactions area.
;; -----------------------------------------------------------------------------

; Number -> Number
; consumes a number and decides whether it is less than 10;
(check-expect (ex1 11) #false)
(check-expect (ex1 9) #true)


(define ex1
  (lambda (x) (< x 10)))


; Number Number -> String
; multiplies two given numbers and turns the result into a string;
(check-expect (ex2 2 3) "6")
(check-expect (ex2 1 1) "1")

(define ex2
  (lambda (x y)
    (number->string (* x y))))


; Nat -> {0 U 1}
; consumes a natural number and returns 0 for evens and 1 for odds;
(check-expect (ex3 0) 0)
(check-expect (ex3 1) 1)
(check-expect (ex3 2) 0)

(define ex3
  (lambda (n)
    (cond
      [(odd? n) 1]
      [else 0])))


(define-struct ir [name price])
; An IR is a structure:
;   (make-ir String Number)

(define ir-ex1 (make-ir "keyboard" 250))
(define ir-ex2 (make-ir "mouse" 100))

; IR -> Boolean
; consumes two inventory records and compares them by price; and
(check-expect (ex4 ir-ex1 ir-ex2) #true)
(check-expect (ex4 ir-ex2 ir-ex1) #false)

(define ex4
  ;; is ir x greater than y?
  (lambda (x y)
    (> (ir-price x) (ir-price y))))

(require 2htdp/image)

(define dot (circle 10 "solid" "red"))
(define scene (empty-scene 160 90))

; Number Number Image -> Image
; adds a red dot at a given Posn to a given Image.
(check-expect (ex5 80 45 scene) (place-image dot 80 45 scene))
(check-expect (ex5 20 20 scene) (place-image dot 20 20 scene))

(define ex5
  (lambda (x y im)
    (place-image dot x y im)))