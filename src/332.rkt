;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 332ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 332
;; ------------
;; Translate the directory tree in figure 123 into a data representation
;; according to model 2.
;; -----------------------------------------------------------------------------


; Data Definition
; ===============

(define-struct dir [name content])
; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
 
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String.

; Data Examples
; =============

; files 
(define hang "hang")
(define draw "draw")
(define read!-in-docs "read!")
(define read!-in-ts "read!")
(define part1 "part1")
(define part2 "part2")
(define part3 "part3")

; directories 
(define code (make-dir "Code" (list hang draw)))
(define docs (make-dir "Docs" (list read!-in-docs)))
(define text (make-dir "Text" (list part1 part2 part3)))
(define libs (make-dir "Libs" (list code docs)))
(define ts (make-dir "TS" (list read!-in-ts text libs)))

ts
; ==
(make-dir
 "TS"
 (list
  "read!"
  (make-dir "Text" (list "part1" "part2" "part3"))
  (make-dir
   "Libs"
   (list (make-dir "Code" (list "hang" "draw"))
         (make-dir "Docs" (list "read!"))))))


