;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 214ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 214
;; ------------
;; Integrate arrangements with the partial program from Word Games, Composition
;; Illustrated. After making sure that the entire suite of tests passes, run it
;; on some of your favorite examples. 
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; ---

(require "arrangements.rkt")
; provides:
; (arrangements s) : Word -> List-of-words
; all permutations of s

(require "../12-3-Word-Games-Composition-Illustrated/211ex.rkt")
; provides:
; (in-dictionary los d) : List-of-strings -> List-of-strings
; keeps all strings that are a part of the dictionary 

(require "../12-3-Word-Games-Composition-Illustrated/210ex.rkt")
; provides:
; (words->strings words) List-of-words -> List-of-strings
; collapses each word is `words` to a string

(require "../12-3-Word-Games-Composition-Illustrated/209ex.rkt")
; provides:
; (string->word s) : String -> Word
; converts s to the chosen word representation

; ---

(define (alternative-words s)
  (in-dictionary
   (words->strings (arrangements (string->word s)))
   AS-LIST))


(check-expect (alternative-words "cat") (list "act" "cat"))

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
    (member? "rat" w) (member? "art" w) (member? "tar" w)))

(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)
