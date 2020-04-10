;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 115ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 115.
;; -------------
;; Revise light=? so that the error message specifies which of the two arguments
;; isn’t an element of TrafficLight. 
;; -----------------------------------------------------------------------------

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 

(check-expect (light? "red") #t)
(check-expect (light? "green") #t)
(check-expect (light? "yellow") #t)
(check-expect (light? "black") #f)
(check-expect (light? 1) #f)
(check-expect (light? #true) #f)


; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal

(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)

(check-error (light=? 1 "yellow") "the first argument is not a light")
(check-error (light=? "red" #true) "the second argument is not a light")
 
(define (light=? a-value another-value)
  (cond
    [(not (light? a-value)) (error "the first argument is not a light")]
    [(not (light? another-value)) (error "the second argument is not a light")]
    [else (string=? a-value another-value)]))