;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 209ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 209
;; ------------
;; The above leaves us with two additional wishes: a function that consumes a
;; String and produces its corresponding Word, and a function for the opposite
;; direction. Here are the wish-list entries:
;; 
;;    ; String -> Word
;;    ; converts s to the chosen word representation 
;;    (define (string->word s) ...)
;;     
;;    ; Word -> String
;;    ; converts w to a string
;;    (define (word->string w) ...)
;;
;; Look up the data definition for Word in the next section and complete the
;; definitions of string->word and word->string. *Hint* You may wish to look in
;; the list of functions that BSL provides. 
;; -----------------------------------------------------------------------------

(require "provide.rkt")
(provide string->word)

; String -> Word
; converts s to the chosen word representation

(check-expect (string->word "abc") (list "a" "b" "c"))
(check-expect (string->word "") '())

(define (string->word s)
  (explode s))
 
; Word -> String
; converts w to a string

(check-expect (word->string (list "a" "b" "c")) "abc")
(check-expect (word->string '()) "")

(define (word->string w)
  (implode w))