;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 382ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 382
;; ------------
;; Formulate an XML configuration for the BW machine, which switches from white
;; to black and back for every key event. Translate the XML configuration into
;; an XMachine representation. See exercise 227 for an implementation of the
;; machine as a program. 
;; -----------------------------------------------------------------------------


; An XMachine is a nested list of this shape:
;   `(machine ((initial ,FSM-State)) [List-of X1T])
; An X1T is a nested list of this shape:
;   `(action ((state ,FSM-State) (next ,FSM-State)))


(define xm0
  '(machine ((initial "black"))
            (action ((state "black") (next "white")))
            (action ((state "white") (next "black")))))


#|
<machine initial="black">
  <action state="black"  next="white" />
  <action state="white"  next="black" />
</machine>
|#
