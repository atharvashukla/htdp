#lang htdp/bsl

; Exercise 62.
; ------------
; During a door simulation the “open” state is barely visible. Modify
; door-simulation so that the clock ticks once every three seconds. Rerun the
; simulation.
; ------------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)


; <-    lock    <-  *time*
; locked     closed    open
; ->    unlock  ->  push
; < door 1 >

; <-    "l"    <-  *tick*
; locked     closed    open
; ->    "u"   ->    " "
; < door 2 >

; Figure 28: A transition diagram for a door with an automatic closer


; A DoorState is one of:
; – LOCKED
; – CLOSED
; – OPEN


(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")


; it is best to define symbolic constants and formulate
; data definitions in terms of such constants.


; "u" for unlocking
; "l" for locking
; " " for pushing it open


; wish list of big-bang functions

; - door-closer, which closes the door during one tick;
; - door-action, which acts on it in response to pressing a key; and
; - door-render, which translates the current state into an image.


; DoorState -> DoorState
; closes an open door over the period of one tick
#;
(define (door-closer state-of-door)
  state-of-door)

; given sate  desired state
; LOCKED      LOCKED
; CLOSED      CLOSED
; OPEN        CLOSED


(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN)   CLOSED)

(define (door-closer state-of-door)
  (cond
    [(string=? LOCKED state-of-door) LOCKED]
    [(string=? CLOSED state-of-door) CLOSED]
    [(string=? OPEN state-of-door) CLOSED]))



; DoorState KeyEvent -> DoorState
; turns key event k into an action on state s 
#;
(define (door-action s k)
  s)


; given state  given key event  desired state
; LOCKED       "u"              CLOSED
; CLOSED       "l"              LOCKED
; CLOSED       " "              OPEN
; OPEN         __               OPEN

(check-expect (door-action LOCKED "u") CLOSED)
(check-expect (door-action CLOSED "l") LOCKED)
(check-expect (door-action CLOSED " ") OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)

(define (door-action s k)
  (cond
    [(and (string=? LOCKED s) (string=? "u" k)) CLOSED]
    [(and (string=? CLOSED s) (string=? "l" k)) LOCKED]
    [(and (string=? CLOSED s) (string=? " " k)) OPEN]
    [else s]))


; DoorState -> Image
; translates the state s into a large text image

(check-expect (door-render CLOSED)
              (text CLOSED 40 "red"))

(define (door-render s)
  (text s 40 "red"))


; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3] ;; <- added 3 here
    [on-key door-action]
    [to-draw door-render]))


(door-simulation LOCKED)
