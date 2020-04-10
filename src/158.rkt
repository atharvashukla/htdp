;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 158ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 158
;; ------------
;; If you run main, press the space bar (fire a shot), and wait for a goodly
;; amount of time, the shot disappears from the canvas. When you shut down the
;; world canvas, however, the result is a world that still contains this
;; invisible shot.
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(define HEIGHT 220) ; distances in terms of pixels 
(define WIDTH 30)
(define XSHOTS (- (/ WIDTH 2) 5))

; graphical constants
(define GREEN-BACK-G (rectangle WIDTH HEIGHT "solid" "green"))
(define BACKGROUND (overlay GREEN-BACK-G (empty-scene WIDTH HEIGHT)))

; (define SHOT (rectangle 2 4 "solid" "red"))

;; SHOT UPDATE
(define SHOT-COLOR "black") ; color of the shot
(define SHOT-REC-RATIO 1/4) ; the width to height ratio
(define SHOT-SCALE 8) ; the scaling of the shot
(define SHOT-WIDTH (* SHOT-SCALE SHOT-REC-RATIO)) ; shot width
(define SHOT-HEIGHT (* SHOT-SCALE 1)) ; shot height
(define SHOT (rectangle SHOT-WIDTH SHOT-HEIGHT "solid" SHOT-COLOR)) ; picture of the shot

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
    [else (update-shots (cons (sub1 (first w)) (tock (rest w))))]))


;; ShotWorld -> ShotWorld
;; remove every negative element from the list

(check-expect (update-shots '()) '())
(check-expect (update-shots (cons 1 '())) (cons 1 '()))
(check-expect (update-shots (cons -1 '())) '())
(check-expect (update-shots (cons -2 (cons 3 (cons -3 '()))))
              (cons 3 '()))

(define (update-shots w)
  (cond
    [(empty? w) '()]
    [else (if (negative? (first w))
              (update-shots (rest w))
              (cons (first w) (update-shots (rest w))))]))

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
  (if (key=? ke " ")
      (cons HEIGHT w)
      w))

(define (main ws)
  (length
   (big-bang ws
     [on-tick tock]
     [to-draw to-image]
     [on-key keyh])))

#;
(main '())