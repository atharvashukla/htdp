;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 195ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Exercise 195
;; ------------
;; Design the function starts-with#, which consumes a Letter and Dictionary and
;; then counts how many words in the given Dictionary start with the given
;; Letter. Once you know that your function works, determine how many words
;; start with "e" in your computer’s dictionary and how many with "z".
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)
(require "provide.rkt")
(provide starts-with#)

; On OS X: 
(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))


; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; ---

; Letter Dictionary -> Nat
; number of words in d that start with l
#;
(define (starts-with# d l)
  0)

; checked using line# in a text editor
(check-expect (+ (starts-with# AS-LIST "a")
                 (starts-with# AS-LIST "A"))
              17096)
(check-expect (starts-with# '() "a") 0)

#;
(define (starts-with#-temp d l)
  (cond
    [(empty? d) ...]
    [else (... (first d) ... (starts-with# (rest d)) ...)]))

(define (starts-with# d l)
  (cond
    [(empty? d) 0]
    [else (if (string=? l (substring (first d) 0 1))
              (add1 (starts-with# (rest d) l))
              (starts-with# (rest d) l))]))