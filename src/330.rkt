;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 330ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 330
;; ------------
;; Translate the directory tree in figure 123 into a data representation
;; according to model 1.
;; -----------------------------------------------------------------------------


; files (as strings)
(define hang "hang")
(define draw "draw")
(define read!-in-docs "read!")
(define read!-in-ts "read!")
(define part1 "part1")
(define part2 "part2")
(define part3 "part3")

; directories (as containers (lists))
(define code (list hang draw))
(define docs (list read!-in-docs))
(define text (list part1 part2 part3))
(define libs (list code docs))
(define ts (list read!-in-ts text libs))


ts
; ==
(list
 "read!"
 (list "part1" "part2" "part3")
 (list
  (list "hang" "draw")
  (list "read!")))