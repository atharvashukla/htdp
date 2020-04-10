;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 210ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 210
;; ------------
;; Complete the design of the words->strings function specified in figure 78.
;; *Hint* Use your solution to exercise 209. 
;; -----------------------------------------------------------------------------

(require "provide.rkt")
(provide words->strings)

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-words is one of:
; - '()
; - (cons Word List-of-words)
; interpretation a List-of-words is a list of Words


; List-of-words -> List-of-strings
; collapses each word is `words` to a string

(check-expect (words->strings '()) '())
(check-expect (words->strings (list (list "a" "b" "c") (list "x" "y"))) (list "abc" "xy"))

(define (words->strings words)
  (cond
    [(empty? words) '()]
    [else (cons (implode (first words))
                (words->strings (rest words)))]))



