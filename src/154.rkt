;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 154ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 154
;; ------------
;; Design the function colors. It consumes a Russian doll and produces a string
;; of all colors, separated by a comma and a space. Thus our example should
;; produce
;;
;;    "yellow, green, red"
;;
;; -----------------------------------------------------------------------------

(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)


(define rd1 (make-layer "yellow" (make-layer "green" "red")))
(define rd2 (make-layer "pink" (make-layer "black" "white")))

; RD -> String
; produces a string of all colors, separated by a comma and a space.
#;
(define (color rd)
  "")

(check-expect (color rd1) "yellow, green, red")
(check-expect (color rd2) "pink, black, white")
(check-expect (color "yellow") "yellow")


(define (color rd)
  (cond
    [(string? rd) rd]
    [(layer? rd)
     (string-append (layer-color rd)
                    ", "
                    (color (layer-doll rd)))]))