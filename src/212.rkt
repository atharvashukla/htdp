;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 212ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 212
;; ------------
;; Write down the data definition for List-of-words. Make up examples of Words
;; and List-of-words. Finally, formulate the functional example from above with
;; check-expect. Instead of the full example, consider working with a word of
;; just two letters, say "d" and "e".  
;; -----------------------------------------------------------------------------

; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-words is one of:
; - '()
; - (cons Word List-of-words)
; interpretation a List-of-words is a list of Words



; Consider "de" -> (list "d" "e")
;               -> (list "e" "d")