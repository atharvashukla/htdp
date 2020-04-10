;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 193ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 193
;; ------------
;;
;; Here are two more ideas for defining render-poly:
;;
;; - render-poly could cons the last item of p onto p and then call
;;   connect-dots.
;;
;; - render-poly could add the first item of p to the end of p via a version of
;;   add-at-end that works on Polygons.
;;
;; Use both ideas to define render-poly; make sure both definitions pass the
;; test cases.
;;
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(define MT (empty-scene 50 50))

; A Polygon is one of:
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

(define triangle-p
  (list
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 30 20)))
 

(define square-p
  (list
    (make-posn 10 10)
    (make-posn 20 10)
    (make-posn 20 20)
    (make-posn 10 20)))


; Image Polygon -> Image 
; adds an image of p to MT
(define (render-polygon img p)
  (render-line (connect-dots img p) (first p) (last p)))

(check-expect
  (render-polygon MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))

(check-expect
  (render-polygon MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))
 
; Image NELoP -> Image
; connects the Posns in p in an image
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) MT]
    [else (render-line (connect-dots img (rest p))
                       (first p)
                       (second p))]))
 
; Image Posn Posn -> Image 
; draws a red line from Posn p to Posn q into im
(define (render-line im p q)
  (scene+line
    im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))
 
; Polygon -> Posn
; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))


; --- Ex. starts here

; Part 1

; Image Polygon -> Image
; renders polygon p
(define (render-poly1 img p)
  (connect-dots img (cons (last p) p)))

(check-expect
  (render-poly1 MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))

(check-expect
  (render-poly1 MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))


; ---

; Part 2

; Posn Polygon -> Polygon
; adds posn p to the end of poly

(check-expect (add-at-end-poly (make-posn 10 10) square-p)
              (list (make-posn 10 10) (make-posn 20 10) (make-posn 20 20) (make-posn 10 20) (make-posn 10 10)))

(check-expect (add-at-end-poly (make-posn 20 10) triangle-p)
              (list (make-posn 20 10) (make-posn 20 20) (make-posn 30 20) (make-posn 20 10)))

(define (add-at-end-poly p poly)
  (cond
    [(empty? (rest (rest (rest poly)))) (list (first poly) (second poly) (third poly) p)]
    [else (cons (first poly) (add-at-end-poly p (rest poly)))]))

; Image Polygon -> Image
; renders polygon p
(define (render-poly2 img p)
  (connect-dots img (add-at-end-poly (first p) p)))

(check-expect
  (render-poly2 MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))

(check-expect
  (render-poly2 MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))