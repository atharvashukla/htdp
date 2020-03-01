;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 5.
; -----------
;
; Use the 2htdp/image library to create the image of a simple boat or tree. 
; Make sure you can easily change the scale of the entire image.
;
; ------------------------------------------------------------------------------


(require 2htdp/image)

; BOAT

;   ASCII ART
;.- - + - - - - - - + - -.
; \   |             |   /
;  \  |             |  /
;   \ |             | /
;    \|_ _ _ _ _ _ _|/


(define TRANS 150)
(define TRI-COLOR "yellow")
(define RECT-COLOR "gray")

(define BOAT-SCALE 200)

(define BASE-LENGTH BOAT-SCALE)
(define BASE-HEIGHT (/ BOAT-SCALE 2))
(define BASE (rectangle BASE-LENGTH BASE-HEIGHT TRANS RECT-COLOR))

(define RIGHT-TRI-L (right-triangle BASE-HEIGHT BASE-HEIGHT TRANS RECT-COLOR))
(define RIGHT-TRI-R  (flip-horizontal RIGHT-TRI-L))

(define POINTY-LEFT (rotate 180 RIGHT-TRI-L))
(define POINTY-RIGHT (rotate 180 RIGHT-TRI-R))

(beside POINTY-LEFT BASE POINTY-RIGHT)


; TREE


(define tree-height 300)

(define trunk (rectangle (/ tree-height 10) tree-height "solid" "brown"))
(define crown (circle (/ tree-height 5) "solid" "dark green"))

(define tree (overlay/offset crown 0 (/ tree-height 2) trunk))

tree