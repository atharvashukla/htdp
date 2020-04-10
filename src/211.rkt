;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 211ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 211
;; ------------
;; Complete the design of in-dictionary, specified in figure 78. *Hint* See
;; Real-World Data: Dictionaries for how to read a dictionary. 
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))


(require "provide.rkt")
(provide in-dictionary)

; List-of-strings -> List-of-strings
; keeps all strings that are a part of the dictionary

(check-expect (in-dictionary (list "car" "rac" "arc" "acr" "cra") AS-LIST) (list "car" "arc"))
(check-expect (in-dictionary '() AS-LIST) '())

(define (in-dictionary los d)
  (cond
    [(empty? los) '()]
    [else (if (word-in-dic? (first los) d)
              (cons (first los) (in-dictionary (rest los) d))
              (in-dictionary (rest los) d))]))

; String -> Boolean
; is w a part of the dictionary?

(check-expect (word-in-dic? "cra" AS-LIST) #false)
(check-expect (word-in-dic? "arc" AS-LIST) #true)
(check-expect (word-in-dic? "arc" '()) #false)

(define (word-in-dic? w d)
  (cond
    [(empty? d) #false]
    [else (or (string=? w (first d))
              (word-in-dic? w (rest d)))]))

