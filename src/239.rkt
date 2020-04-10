;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 239ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 239
;; ------------
;; A list of two items is another frequently used form of data in ISL
;; programming. Here is a data definition with two parameters:
;;
;;    ; A [List X Y] is a structure: 
;;    ;   (cons X (cons Y '()))
;;
;; Instantiate this definition to describe the following classes of data:
;; - pair of Numbers
;; - pairs of Numbers and 1Strings, and
;; - pairs of Strings and Booleans
;;
;; Also make one concrete example for each of these three data definitions. 
;; -----------------------------------------------------------------------------

; A [List X Y] is a structure:
;   (cons X (cons Y '()))

; -- pairs of Numbers

; A [List Number Number] is a structure
;    (cons Number (cons Number '()))

(define ex1 (list 1 2))
(define ex2 (list 45 69))

; -- pairs of Numbers and 1Strings

; A [List Number 1String] is a structute
;     (cons Number (cons 1String '()))

(define ex3 (list 33 "w"))
(define ex4 (list 9 "q"))

; -- pairs of Strings and Booleans

; A [List String Boolean] is a structure
;    (cons String (cons Boolean '()))

(define ex5 (list "he" #true))
(define ex5 (list "hl" #true))