;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 205ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 205
;; ------------
;; Develop examples of LAssoc and LLists, that is, the list representation of
;; tracks and lists of such tracks. 
;; -----------------------------------------------------------------------------


; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
 
; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
; 
; An Association is a list of two items: 
;   (cons String (cons BSDN '()))

; A BSDN is one of: 
; – Boolean
; – Number
; – String
; – Date

(define lassoc1
  (list
   (list "Name" "Call It Stormy Monday (Live)")
   (list "Artist" "Albert King 38 Stevie Ray Vaughan")
   (list "Album Artist" "Albert King 38 Stevie Ray Vaughan")
   (list "Album" "In Session (Live)")
   (list "Total Time" 540167)))

(define lassoc2
  (list
   (list "Name" "Brianstorm")
   (list "Artist" "Arctic Monkeys")
   (list "Album Artist" "Arctic Monkeys")
   (list "Album" "Favourite Worst Nightmare")
   (list "Total Time" 172253)))

(define llist1 (list lassoc1))
(define llist2 (list lassoc1 lassoc2))
