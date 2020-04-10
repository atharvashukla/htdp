;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 88ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 88.
;; ------------
;; Define a structure type that keeps track of the cat’s x-coordinate and its
;; happiness. Then formulate a data definition for cats, dubbed VCat, including
;; an interpretation.
;; -----------------------------------------------------------------------------

(define-struct vcat [x happiness])
; VCat is a struct
;   (make-vcat Number [0, 100])
; interp. x is the x-coordinate
; happiness is the % happiness

