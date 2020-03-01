;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |013|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 13.
; ------------
;
; Define the function string-first, which extracts the first 1String from a
; non-empty string. 
;
; ----------------------------------------------------------------------------

; version 1:

(define (string-first str)
  (string-ith str 0))

; version 2:

(define (string-first.v2 str)
  (substring str 0 1))