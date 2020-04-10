;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 191ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 191
;; ------------
;; Adapt the second example for the render-poly function to connect-dots.
;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)


(define MT (empty-scene 50 50))

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

(define square-p
  (list
   (make-posn 10 10)
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 10 20)))


; Image NELoP -> Image 
; connects the dots in p by rendering lines in img
(define (connect-dots img p)
  MT)


(check-expect (connect-dots MT square-p)
              (scene+line
               (scene+line
                (scene+line MT 20 20 10 20 "red")
                20 10 20 20 "red")
               10 10 20 10 "red"))
