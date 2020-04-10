;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 316ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 316
;; ------------
;; Define the atom? function.
;; -----------------------------------------------------------------------------

; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)
          

; An Atom is one of: 
; – Number
; – String
; – Symbol


;; Any -> Boolean
;; is the x an atom?

(check-expect (atom? 'x) #t)
(check-expect (atom? "x") #t)
(check-expect (atom? 1) #t)
(check-expect (atom? (list 1 "x" 'x)) #f)

(define (atom? x)
  (not (list? x)))