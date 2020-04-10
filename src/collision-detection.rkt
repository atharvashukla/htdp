;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname collision-detection) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require racket/base)
(require 2htdp/image)
(provide overlaps?)

(define BACKG (empty-scene 200 200))

; dimensions of the UFO and MISSILE
(define UFO-W 40)
(define UFO-H 20)

(define MIS-W 20)
(define MIS-H 40)

(define UFO  (rectangle UFO-W UFO-H "outline" "red"))
(define MISSILE (rectangle MIS-W MIS-H "outline" "blue"))

; Posn Posn -> Image
; places UFO and the MISSILE on u-p and m-p on BACKG

(check-expect (place-recs (make-posn 100 100) 40 20 (make-posn 100 100) 20 40)
              (overlay UFO (overlay MISSILE BACKG)))

(define (place-recs r1 r1-w r1-h r2 r2-w r2-h)
  (place-image (rectangle r1-w r1-h "outline" "red")
               (posn-x r1) (posn-y r1) 
               (place-image (rectangle r2-w r2-h "outline" "blue")
                            (posn-x r2) (posn-y r2)
                            BACKG)))

; * overlapping examples

; - overlay
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 100) 20 40) #true) ; extends vertically
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 100) 50 10) #true) ; extends horiz
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 100) 50 50) #true) ; covering
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 100) 10 15) #true) ; within

; - touching edges
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 70) 20 40) #true)  ; t
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 130) 20 40) #true) ; b
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 70 100) 20 40) #true)  ; l
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 130 100) 20 40) #true) ; r

; - touching corners
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 70 130) 20 40) #true)  ; bl
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 130 130) 20 40) #true) ; br
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 70 70) 20 40) #true)   ; tl
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 130 70) 20 40) #true)  ; tr

; - intersecting at corners
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 80 120) 20 40) #true)  ; bl
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 120 120) 20 40) #true) ; br
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 80 80) 20 40) #true)   ; tl
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 120 80) 20 40) #true)  ; tr

; - intersecting at edges
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 80 100) 20 40) #true)  ; l
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 120 100) 20 40) #true) ; r
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 80) 20 40) #true)  ; t
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 120) 20 40) #true) ; b

; * non overlapping examples

; - outside edges
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 60) 20 40) #false)  ; t
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 100 140) 20 40) #false) ; b
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 60 100) 20 40) #false)  ; l
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 140 100) 20 40) #false) ; r

; - outside corners
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 60 140) 20 40) #false)  ; bl
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 140 140) 20 40) #false) ; br
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 60 60) 20 40) #false)   ; tl
(check-expect (overlaps? (make-posn 100 100) 40 20 (make-posn 140 60) 20 40) #false)  ; tr

; Posn Posn -> Boolean
; does "rectangle r1 with width r1-w and r1-h" and
; "rectangle r2 with width r2-w and r2h" overlap?
(define (overlaps? r1 r1-w r1-h r2 r2-w r2-h)
  (or (intersecting-at-corners? r1 r1-w r1-h r2 r2-w r2-h)
      (intersecting-at-corners? r2 r2-w r2-h r1 r1-w r1-h)
      (overlap? r1 r1-w r1-h r2 r2-w r2-h)
      (overlap? r2 r2-w r2-h r1 r1-w r1-h)))

; Posn Posn -> Boolean
; does "rectangle r2 with width r2-w and r2h" overlap any of
; the corners or edges of "rectangle r1 with width r1-w and r1-h"?
(define (intersecting-at-corners? r1 r1-w r1-h r2 r2-w r2-h)
  (or (intersecting-at-bl-corner? r1 r1-w r1-h r2 r2-w r2-h)
      (intersecting-at-br-corner? r1 r1-w r1-h r2 r2-w r2-h)
      (intersecting-at-tl-corner? r1 r1-w r1-h r2 r2-w r2-h)
      (intersecting-at-tr-corner? r1 r1-w r1-h r2 r2-w r2-h)))

; Posn Number Number Posn Number Number -> Boolean
(define (overlap? r1 r1-w r1-h r2 r2-w r2-h)
  (and (<= (get-left r1 r1-w r1-h) (get-left r2 r2-w r2-h) (get-right r2 r2-w r2-h) (get-right r1 r1-w r1-h))
       (<= (get-top r2 r2-w r2-h) (get-top r1 r1-w r1-h) (get-bot r1 r1-w r1-h) (get-bot r2 r2-w r2-h))))

; Posn Number Number Posn Number Number -> Boolean
; does "rectangle r2 with width r2-w and r2h" overlap any of the 
; bottom-left corner or edges of "rectangle r1 with width r1-w and r1-h"?
(define (intersecting-at-bl-corner? r1 r1-w r1-h r2 r2-w r2-h)
  (and (<= (get-top r1 r1-w r1-h) (get-top r2 r2-w r2-h) (get-bot r1 r1-w r1-h))
       (<= (get-left r1 r1-w r1-h) (get-right r2 r2-w r2-h) (get-right r1 r1-w r1-h))))

; Posn Number Number Posn Number Number -> Boolean
; does "rectangle r2 with width r2-w and r2h" overlap any of the 
; bottom-right corner or edges of "rectangle r1 with width r1-w and r1-h"?
(define (intersecting-at-br-corner? r1 r1-w r1-h r2 r2-w r2-h)
  (and (<= (get-top r1 r1-w r1-h) (get-top r2 r2-w r2-h) (get-bot r1 r1-w r1-h))
       (<= (get-left r1 r1-w r1-h) (get-left r2 r2-w r2-h) (get-right r1 r1-w r1-h))))

; Posn Number Number Posn Number Number -> Boolean
; does "rectangle r2 with width r2-w and r2h" overlap any of the 
; top-left corner or edges of "rectangle r1 with width r1-w and r1-h"?
(define (intersecting-at-tl-corner? r1 r1-w r1-h r2 r2-w r2-h)
  (and (<= (get-top r1 r1-w r1-h) (get-bot r2 r2-w r2-h) (get-bot r1 r1-w r1-h))
       (<= (get-left r1 r1-w r1-h) (get-right r2 r2-w r2-h) (get-right r1 r1-w r1-h))))

; Posn Number Number Posn Number Number -> Boolean
; does "rectangle r2 with width r2-w and r2h" overlap any of the 
; top-right corner or edges of "rectangle r1 with width r1-w and r1-h"?
(define (intersecting-at-tr-corner? r1 r1-w r1-h r2 r2-w r2-h)
  (and (<= (get-top r1 r1-w r1-h) (get-bot r2 r2-w r2-h) (get-bot r1 r1-w r1-h))
       (<= (get-left r1 r1-w r1-h) (get-left r2 r2-w r2-h) (get-right r1 r1-w r1-h))))

; Posn Number Number -> Number
; y coordinate of the top edge of a rectangle
; with center c, width w, and height h
(check-expect (get-top (make-posn 100 100) 40 20) 90)
(define (get-top c w h)
  (- (posn-y c) (/ h 2)))

; Posn Number Number -> Number
; y coordinate of the bot edge of a rectangle
; with center c, width w, and height h
(check-expect (get-bot (make-posn 100 100) 40 20) 110)
(define (get-bot c w h)
  (+ (posn-y c) (/ h 2)))

; Posn Number Number -> Number
; x coordinate of the left edge of a rectangle
; with center c, width w, and height h
(check-expect (get-left (make-posn 100 100) 40 20) 80)
(define (get-left c w h)
  (- (posn-x c) (/ w 2)))

; Posn Number Number -> Number
; x coordinate of the right edge of a rectangle
; with center c, width w, and height h
(check-expect (get-right (make-posn 100 100) 40 20) 120)
(define (get-right c w h)
  (+ (posn-x c) (/ w 2)))

