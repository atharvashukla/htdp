;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 417ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 417
;; ------------
;; Evaluate (expt 1.001 1e-12) in Racket and in ISL+. Explain what you see.
;; -----------------------------------------------------------------------------



(expt 1.001 1e-12)

; In ISL+
; => #i1.000000000000001

; In Racket
; => 1.000000000000001

; ISL+ tells you whether the number is lying or not
; whether it's inexact or not.