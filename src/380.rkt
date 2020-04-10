;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 380ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 380
;; -----------
;; Reformulate the data definition for 1Transition so that it is possible to
;; restrict transitions to certain keystrokes. Try to formulate the change so
;; that find continues to work without change. What else do you need to change
;; to get the complete program to work? Which part of the design recipe provides
;; the answer(s)? See exercise 229 for the original exercise statement.
;; -----------------------------------------------------------------------------



(require 2htdp/image)
(require 2htdp/universe)

; An FSM is a [List-of 1Transition]
; A 1Transition is a list of two items:
;   (cons FSM-State (cons FSM-State (cons KeyEvent '()))
; An FSM-State is a String that specifies a color
 
; data examples 
(define fsm-traffic
  '(("red" "green" "r") ("green" "yellow" "g") ("yellow" "red" "y")))
 
; FSM FSM-State -> FSM-State 
; matches the keys pressed by a player with the given FSM 
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw
     (lambda (current)
       (overlay (text current 24 "black")
                (square 100 "solid" current)))]
    [on-key
     (lambda (current key-event)
       (if (or (and (key=? "r" key-event) (equal? current "red"))
               (and (key=? "g" key-event) (equal? current "green"))
               (and (key=? "y" key-event) (equal? current "yellow")))
           (find transitions current)
           current))]))
 
; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist

(check-expect (find fsm-traffic "red") "green")
(check-error (find fsm-traffic "purple"))

(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))

(simulate "red" fsm-traffic)