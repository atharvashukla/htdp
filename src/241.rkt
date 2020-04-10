;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 241ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 241
;; ------------
;; Compare the definitions for NEList-of-temperatures and NEList-of-Booleans.
;; Then formulate an abstract data definition NEList-of.
;; -----------------------------------------------------------------------------

; Temperature is a Number

; NEList-of-temperatures is one of:
; - (cons Temperature '())
; - (cons Temperature NEList-of-temperatures)


; NEList-of-Booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-Boolean)


; [NEList-of ITEM] is one of:
; - (cons ITEM '())
; - (cons ITEM [NEList-of ITEM])