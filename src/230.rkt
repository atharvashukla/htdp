;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 230ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 230
;; ------------
;;  Consider the following data representation for FSMs:
;;
;;    (define-struct fsm [initial transitions final])
;;    (define-struct transition [current key next])
;;    ; An FSM.v2 is a structure: 
;;    ;   (make-fsm FSM-State LOT FSM-State)
;;    ; A LOT is one of: 
;;    ; – '() 
;;    ; – (cons Transition.v3 LOT)
;;    ; A Transition.v3 is a structure: 
;;    ;   (make-transition FSM-State KeyEvent FSM-State)
;;
;; Represent the FSM from exercise 109 in this context.
;; 
;; Design the function fsm-simulate, which accepts an FSM.v2 and runs it on a
;; player’s keystrokes. If the sequence of keystrokes forces the FSM.v2 to reach
;; a final state, fsm-simulate stops. *Hint* The function uses the initial field
;; of the given fsm structure to track the current state. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)


(define-struct fsm [initial transitions final])
(define-struct transition [current key next])
; An FSM.v2 is a structure: 
;   (make-fsm FSM-State LOT FSM-State)
; A LOT is one of: 
; – '() 
; – (cons Transition.v3 LOT)
; A Transition.v3 is a structure: 
;   (make-transition FSM-State KeyEvent FSM-State)

; FSM-State is a Color.
 
; interpretation An FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to keystrokes 

 
(define AA-STATE "red")    ; "start, expect an 'a'"
(define BB-STATE "green")  ; "expect 'b', 'c', or 'd'"
(define DD-STATE "yellow") ; "finished"
(define ER-STATE "blue")   ; "error, illegal key"

(define AA->BB-a (make-transition AA-STATE "a" BB-STATE))
; (define AA->ER )
; (define BB->ER )
(define BB->BB-b (make-transition BB-STATE "b" BB-STATE))
(define BB->BB-c (make-transition BB-STATE "c" BB-STATE))
(define BB->DD-d (make-transition BB-STATE "d" DD-STATE))


(define ex-109 (list AA->BB-a BB->BB-b BB->DD-d))
(define fsm-ex-109 (make-fsm AA-STATE ex-109 DD-STATE))

(define fsm-traffic
  (make-fsm "red"
            (list (make-transition "red" "g" "green")
                  (make-transition "green" "y" "yellow")
                  (make-transition "yellow" "r" "red"))
            "red"))

(define-struct fs [fsm current])
; A SimulationState.v2 is a structure: 
;   (make-fs FSM FSM-State)

; FSM.v2 -> FSM-State
(define (fsm-simulate fsm)
  (simulate.v2 fsm (fsm-initial fsm)))

; FSM FSM-State -> SimulationState.v2 
; match the keys pressed with the given FSM 
(define (simulate.v2 an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw state-as-colored-square]
    [on-key find-next-state]
    [stop-when reached-final-state? state-as-colored-square]))


; SimulationState.v2 -> Boolean
; are we on the final state?

(check-expect (reached-final-state? (make-fs fsm-ex-109 DD-STATE)) #true)
(check-expect (reached-final-state? (make-fs fsm-ex-109 AA-STATE)) #false)

(define (reached-final-state? fs)
  (equal? (fs-current fs) (fsm-final (fs-fsm fs))))


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
  (if (from-state-exists? (fsm-transitions transitions) current)
      (find-h (fsm-transitions transitions) current key)
      (error (string-append "not found: " current))))


; helpers

; Transition.v2 FSM-State -> Boolean
; does a "from" state called `state` exist in transitions?
(define (from-state-exists? transitions state)
  (cond
    [(empty? transitions) #false]
    [else (or (equal? (transition-current (first transitions)) state)
              (from-state-exists? (rest transitions) state))]))


; Transition.v2 FSM-State KeyEvent -> FSM-State
; we know that the "from" state exists, is the "key" correct?
; if so, we move on to the next state, otherwise, we're on that
; current state
(define (find-h transitions current key)
  (cond
    [(empty? transitions) current]
    [else (if (and (equal? (transition-current (first transitions)) current)
                   (equal? (transition-key (first transitions)) key))
              (transition-next (first transitions))
              (find-h (rest transitions) current key))]))
