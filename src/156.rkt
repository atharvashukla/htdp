;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 156ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 156
;; ------------
;; Equip the program in figure 61 with tests and make sure it passes those.
;; Explain what main does. Then run the program via main.
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))

; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired 

; A Shot is a Number.
; interpretation represents the shot's y-coordinate 

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot

; ShotWorld -> Image
; adds the image of a shot for each  y on w 
; at (MID,y} to the background image

(check-expect (to-image (cons 9 '()))
              (place-image SHOT XSHOTS 9 BACKGROUND))
(check-expect (to-image (cons 9 (cons 40 '())))
              (place-image SHOT XSHOTS 40
                           (place-image SHOT XSHOTS 9 BACKGROUND)))
(check-expect (to-image '())
              BACKGROUND)

(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))

; ShotWorld -> ShotWorld
; moves each shot on w up by one pixel

(check-expect (tock '()) '())
(check-expect (tock (cons 1 '())) (cons 0 '()))
(check-expect (tock (cons 33 (cons 12 (cons 23 (cons 1 '())))))
              (cons 32 (cons 11 (cons 22 (cons 0 '())))))

(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world 
; if the player presses the space bar

(check-expect (keyh '() " ") (cons HEIGHT '()))
(check-expect (keyh '() "b") '())
(check-expect (keyh (cons 22 (cons 2 '())) " ")
              (cons HEIGHT (cons 22 (cons 2 '()))))
(check-expect (keyh (keyh (cons 22 (cons 2 '())) " ") "b")
              (keyh (cons 22 (cons 2 '())) " "))

(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

(define (main ws)
  (big-bang ws
    [on-tick tock]
    [to-draw to-image]
    [on-key keyh]))

#;; main starts the program with 0 bullets shot so far
(main '())