;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 5.
;; -----------
;; Use the 2htdp/image library to create the image of a simple boat or tree.
;; Make sure you can easily change the scale of the entire image.

;; -----------------------------------------------------------------------------


(require 2htdp/image)


;; Boat

(define width 200)

(define right-edge-triangle (triangle/ass 90 (/ width 2) (/ width 2) "solid" "brown"))
(define left-edge-triangle (triangle/sas (/ width 2) 90 (/ width 2) "solid" "brown"))
(define body-rectangle (rectangle width (/ width 2) "solid" "brown"))

(define boat
  (beside left-edge-triangle
          body-rectangle
          right-edge-triangle))

boat

;; Tree


(define tree-height 300)

(define trunk (rectangle (/ tree-height 10) tree-height "solid" "brown"))
(define crown (circle (/ tree-height 5) "solid" "dark green"))

(define tree (overlay/offset crown 0 (/ tree-height 2) trunk))

tree