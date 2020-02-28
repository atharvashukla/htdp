;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 6ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/image)

;; Exercise 6.
;; -----------
;; Add the following line to the definitions area:Copy and paste the image into
;; your DrRacket.
;; 
;;    (define cat <image of the cat>)
;;
;; Create an expression that counts the number of pixels in the image. 


;; the number of pixels in the cat image

(* (image-height (bitmap "cat.png"))
   (image-width (bitmap "cat.png")))

;; => 8775