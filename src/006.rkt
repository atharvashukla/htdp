;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 6.
; -----------
; Add the following line to the definitions area:Copy and paste the image into
; your DrRacket.
; 
;    (define cat <image of the cat>)
;;
; Create an expression that counts the number of pixels in the image. 
; ------------------------------------------------------------------------------

(require 2htdp/image)


(define cat (bitmap "cat.png"))

; # of pixels in cat
(* (image-height cat) (image-width cat))
; => 8775