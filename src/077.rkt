;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 77ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 77.
;; ------------
;; Provide a structure type definition and a data definition for representing
;; points in time since midnight. A point in time consists of three numbers:
;; hours, minutes, and seconds.
;; -----------------------------------------------------------------------------


(define-struct time [hours minutes seconds])
; A Time is a structure
;   (make-time Number Number Number)
; *interpretation* 
; hours is a Number in [0, 24] which represents the hours since midnight
; minutes is a Number in [0, 59] which represents the minutes since last hour
; seconds is a Number in [0, 59] which represents the seconds since last minute
