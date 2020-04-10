;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 71ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 71.
;; ------------
;; Place the following into DrRacket’s definitions area:
;;
;;    ; distances in terms of pixels:
;;    (define HEIGHT 200)
;;    (define MIDDLE (quotient HEIGHT 2))
;;    (define WIDTH  400)
;;    (define CENTER (quotient WIDTH 2))
;;     
;;    (define-struct game [left-player right-player ball])
;;     
;;    (define game0
;;      (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
;; 
;; Click RUN and evaluate the following expressions:
;;
;;    (game-ball game0)
;;    (posn? (game-ball game0))
;;    (game-left-player game0)
;;
;; Explain the results with step-by-step computations. Double-check your
;; computations with DrRacket’s stepper.
;;
;; -----------------------------------------------------------------------------


; distances in terms of pixels:
(define HEIGHT 200)
(define MIDDLE (quotient HEIGHT 2))
(define WIDTH  400)
(define CENTER (quotient WIDTH 2))
 
(define-struct game [left-player right-player ball])
 
(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))

(game-ball game0)
(posn? (game-ball game0))
(game-left-player game0)

;; Stepping through 1
(game-ball game0)
;; ==
(game-ball (make-game 100 100 (make-posn 200 200)))
;; ==
(make-posn 200 200)


;; Stepping through 2
(posn? (game-ball game0))
;; ==
(posn? (game-ball (make-game 100 100 (make-posn 200 200))))
;; ==
(posn? (make-posn 200 200))
;; ==
#true

;; Stepping through 3
(game-left-player game0)
;; ==
(game-left-player (make-game 100 100 (make-posn 200 200)))
;; ==
100
