;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 227ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 227
;; ------------
;; The BW Machine is an FSM that flips from black to white and back to black for
;; every key event. Formulate a data representation for the BW Machine. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)

; An FSM is one of:
;   – '()
;   – (cons Transition FSM)
 
(define-struct transition [current next])
; A Transition is a structure:
;   (make-transition FSM-State FSM-State)
 
; FSM-State is a Color.
 
; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes 

(define BLACK-STATE "black")
(define WHITE-STATE "white")


; the data representation of the BW machine
(define FSM-BW
  (list (make-transition BLACK-STATE WHITE-STATE)
        (make-transition WHITE-STATE BLACK-STATE)))



