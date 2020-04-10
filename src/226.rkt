;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 226ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 226
;; ------------
;; Design state=?, an equality predicate for states.
;; -----------------------------------------------------------------------------

(require 2htdp/image)

; FSM-State is a Color


(define fsm-state1 "red")
(define fsm-state2 "green")
(define fsm-state3 "blue")


; FSM-State FSM-State -> Boolean
; an equality predicate for fsm states
(define (state=? fsm-s1 fsm-s2)
  (cond
    [(not (image-color? fsm-s1)) (error "the first arg is not an fsm-state")]
    [(not (image-color? fsm-s2)) (error "the second arg is not an fsm-state")]
    [else (string=? fsm-s1 fsm-s2)]))


(check-error (state=? 1 fsm-state1))
(check-error (state=? fsm-state2 1))
(check-expect (state=? fsm-state2 fsm-state3) #false)
(check-expect (state=? fsm-state3 fsm-state3) #true)