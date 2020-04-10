;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 155ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 155
;; ------------
;; Design the function inner, which consumes an RD and produces the (color of
;; the) innermost doll. Use DrRacket’s stepper to evaluate (inner rd) for your
;; favorite rd.
;; -----------------------------------------------------------------------------

(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)


(define rd1 (make-layer "yellow" (make-layer "green" "red")))
(define rd2 (make-layer "pink" (make-layer "black" "white")))

; RD -> String
; produces the color of the innermost doll
#;
(define (inner rd)
  "blue")

(check-expect (inner rd1) "red")
(check-expect (inner rd2) "white")
(check-expect (inner "yellow") "yellow")

#;
(define (inner rd)
  (cond
    [(string? rd) ...]
    [(layer? rd) (... (layer-color rd) ... (inner (layer-doll rd)) ...)]))

(define (inner rd)
  (cond
    [(string? rd) rd]
    [(layer? rd) (inner (layer-doll rd))]))