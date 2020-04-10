;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 78ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 78.
;; ------------
;; Provide a structure type and a data definition for representing three-letter
;; words. A word consists of lowercase letters, represented with the 1Strings
;; "a" through "z" plus #false. Note This exercise is a part of the design of a
;; hangman game; see exercise 396.
;; -----------------------------------------------------------------------------

; A Letter is one of
; - 1Strings from "a" to "z"
; - #false

(define-struct 3lword [l1 l2 l3])
; A 3LWord (3LetterWord) is a structure:
;   (make-3lword Letter Letter Letter)
; *interpretation* 3 letters which can either
; be 1Strings from "a" to  "b" or #false.
; (Part of the hangman game)