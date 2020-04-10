;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 229ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 229
;; ------------
;;  Here is a revised data definition for Transition:
;;
;;    (define-struct ktransition [current key next])
;;    ; A Transition.v2 is a structure:
;;    ;   (make-ktransition FSM-State KeyEvent FSM-State)
;;
;; Represent the FSM from exercise 109 using lists of Transition.v2s; ignore
;; errors and final states.
;; 
;; Modify the design of simulate so that it deals with keystrokes in the
;; appropriate manner now. Follow the design recipe, starting with the
;; adaptation of the data examples.
;; 
;; Use the revised program to simulate a run of the FSM from exercise 109 on the
;; following sequence of keystrokes: "a", "b", "b", "c", and "d". 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; An FSM is one of:
;   – '()
;   – (cons Transition FSM)
 
(define-struct ktransition [current key next])
; A Transition.v2 is a structure:
;   (make-ktransition FSM-State KeyEvent FSM-State)
 
; FSM-State is a Color.
 
; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes 

 
(define AA-STATE "red")    ; "start, expect an 'a'"
(define BB-STATE "green")  ; "expect 'b', 'c', or 'd'"
(define DD-STATE "yellow") ; "finished"
(define ER-STATE "blue")   ; "error, illegal key"

(define AA->BB-a (make-ktransition AA-STATE "a" BB-STATE))
; (define AA->ER )
; (define BB->ER )
(define BB->BB-b (make-ktransition BB-STATE "b" BB-STATE))
(define BB->BB-c (make-ktransition BB-STATE "c" BB-STATE))
(define BB->DD-d (make-ktransition BB-STATE "d" DD-STATE))


(define ex-109 (list AA->BB-a BB->BB-b BB->DD-d))


(define BLACK-STATE "black")
(define WHITE-STATE "white")

; the data representation of the BW machine
(define FSM-BW
  (list (make-ktransition BLACK-STATE "w" WHITE-STATE)
        (make-ktransition WHITE-STATE "b" BLACK-STATE)))

(define fsm-traffic
  (list (make-ktransition "red" "g" "green")
        (make-ktransition "green" "y" "yellow")
        (make-ktransition "yellow" "r" "red")))


(define-struct fs [fsm current])
; A SimulationState.v2 is a structure: 
;   (make-fs FSM FSM-State)


; FSM FSM-State -> SimulationState.v2 
; match the keys pressed with the given FSM 
(define (simulate.v2 an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw state-as-colored-square]
    [on-key find-next-state]))


; SimulationState.v2 -> Image 
; renders current world state as a colored square 
(define (state-as-colored-square an-fsm)
  (square 100 "solid" (fs-current an-fsm)))

(check-expect (state-as-colored-square
               (make-fs fsm-traffic "red"))
              (square 100 "solid" "red"))


; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from key and cs
(define (find-next-state an-fsm key)
  (make-fs (fs-fsm an-fsm) (find (fs-fsm an-fsm) (fs-current an-fsm) key)))

(check-expect
  (find-next-state (make-fs fsm-traffic "red") "n")
  (make-fs fsm-traffic "red"))
(check-expect
  (find-next-state (make-fs fsm-traffic "red") "a")
  (make-fs fsm-traffic "red"))

(check-expect
  (find-next-state (make-fs fsm-traffic "green") "q")
  (make-fs fsm-traffic "green"))

(check-expect
  (find-next-state (make-fs fsm-traffic "red") "g")
  (make-fs fsm-traffic "green"))

(check-expect
  (find-next-state (make-fs fsm-traffic "green") "y")
  (make-fs fsm-traffic "yellow"))


; FSM FSM-State KeyEvent -> FSM-State
; finds the state representing current in transitions
; and retrieves the next field if the key matches

(check-expect (find fsm-traffic "red" "g") "green")
(check-expect (find fsm-traffic "green" "y") "yellow")
(check-expect (find fsm-traffic "green" "r") "green")
(check-error (find fsm-traffic "black" "r")
             "not found: black")


(define (find transitions current key)
  (if (from-state-exists? transitions current)
      (find-h transitions current key)
      (error (string-append "not found: " current))))


; helpers

; Transition.v2 FSM-State -> Boolean
; does a "from" state called `state` exist in transitions?
(define (from-state-exists? transitions state)
  (cond
    [(empty? transitions) #false]
    [else (or (equal? (ktransition-current (first transitions)) state)
              (from-state-exists? (rest transitions) state))]))


; Transition.v2 FSM-State KeyEvent -> FSM-State
; we know that the "from" state exists, is the "key" correct?
; if so, we move on to the next state, otherwise, we're on that
; current state
(define (find-h transitions current key)
  (cond
    [(empty? transitions) current]
    [else (if (and (equal? (ktransition-current (first transitions)) current)
                   (equal? (ktransition-key (first transitions)) key))
              (ktransition-next (first transitions))
              (find-h (rest transitions) current key))]))

#;
(simulate.v2 fsm-traffic "red")