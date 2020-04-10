;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |80ex copy|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 81.
;; ------------
;; Design the function time->seconds, which consumes instances of time
;; structures (see exercise 77) and produces the number of seconds that have
;; passed since midnight. For example, if you are representing 12 hours, 30
;; minutes, and 2 seconds with one of these structures and if you then apply
;; time->seconds to this instance, the correct result is 45002.
;; -----------------------------------------------------------------------------

(define-struct time [hours minutes seconds])
; A Time is a structure
;   (make-time Number Number Number)
; *interpretation* 
; hours is a Number in [0, 24] which represents the hours since midnight
; minutes is a Number in [0, 59] which represents the minutes since last hour
; seconds is a Number in [0, 59] which represents the seconds since last minute

(define t1 (make-time 12 30 2))
(define t2 (make-time 0 0 1))
(define t3 (make-time 17 44 9))

; Time -> Number
; number of seconds since midnight
#;
(define (time->seconds t)
  0)

; 12h 30m 2s -- time->seconds --> 45002
; 00h 00m 1s -- time->seconds --> 1
; 17h 44m 9s -- time->seconds --> 17*3600 + 44*60 + 9 = 63849

#;
(define (time->seconds t)
  (... (time-hours t) ... (time-minutes t) ... (time-seconds t) ...))

(define (time->seconds t)
  (+ (* 60 60 (time-hours t)) (* 60 (time-minutes t)) (time-seconds t)))

(check-expect (time->seconds t1) 45002)
(check-expect (time->seconds t2) 1)
(check-expect (time->seconds t3) 63849)