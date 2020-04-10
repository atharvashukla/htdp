;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 194ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 194.
;; ------------
;; Modify connect-dots so that it consumes an additional Posn to which the last
;; Posn is connected. Then modify render-poly to use this new version of
;; connect-dots.
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(define MT (empty-scene 50 50))

; An NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

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

(check-expect (connect-dots MT triangle-p (make-posn 20 10))
              (scene+line
               (scene+line
                (scene+line MT 30 20 20 10 "red")
                20 20 30 20 "red")
               20 10 20 20 "red"))


(check-expect (connect-dots MT square-p (make-posn 10 10))
              (scene+line
               (scene+line
                (scene+line
                 (scene+line MT 10 20 10 10 "red")
                 20 20 10 20 "red")
                20 10 20 20 "red")
               10 10 20 10 "red"))


; Image NELoP Posn -> Image 
; connects the dots in p by rendering lines in img
(define (connect-dots img poly p)
  (cond
    [(empty? (rest poly))
     (scene+line img (posn-x (first poly)) (posn-y (first poly)) (posn-x p) (posn-y p) "red")]
    [else
     (render-line
       (connect-dots img (rest poly) p)
       (first poly)
       (second poly))]))


; Image Posn Posn -> Image 
; draws a red line from Posn p to Posn q into im
(define (render-line im p q)
  (scene+line
    im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))


; -- using render poly with the new version of connect-dots

; Image Polygon -> Image 
; adds an image of p to MT
(define (render-poly img p)
  (connect-dots MT p (first p)))


(check-expect
  (render-poly MT triangle-p)
  (scene+line
    (scene+line
      (scene+line MT 20 10 20 20 "red")
      20 20 30 20 "red")
    30 20 20 10 "red"))


(check-expect
  (render-poly MT square-p)
  (scene+line
    (scene+line
      (scene+line
        (scene+line MT 10 10 20 10 "red")
        20 10 20 20 "red")
      20 20 10 20 "red")
    10 20 10 10 "red"))