;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname arrangements) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "provide.rkt")
(provide arrangements)

(require "213ex.rkt")
; provides:
; (insert-everywhere/in-all-words s w) : 1String List-of-words -> List-of-words
; inserts s at all positions in w and makes a list of them


; Word -> List-of-words
; creates all rearrangements of the letters in w
#;
(define (arrangements w)
  (cond
    [(empty? w) ...]
    [else (... (first w) ...
               ... (arrangements (rest w)) ...)]))


; the empty word
; '() => only 1 possible rearrangement => (list '())

; (first w) : letter
; (arrangements (rest w)) : list of all possible arrangements.
; concretely:
;   (list "d" "e" "r")
;   =>
;   (cons (list "e" "r")
;     (cons (list "r" "e")
;       '()))

; we want:

; (list (list "d" "e" "r")
;       (list "e" "d" "r")
;       (list "e" "r" "d")
;       (list "d" "r" "e")
;       (list "r" "d" "e")
;       (list "r" "e" "d"))

; insert "d" at every position in each list.


(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words (first w)
                                          (arrangements (rest w)))]))

; tests -->

; List-of-strings -> Boolean
; checks whether each perm is a part of the list of perms w
(define (all-words-from-cat? w)
  (and (member? (list "c" "a" "t") w)
       (member? (list "c" "t" "a") w)
       (member? (list "a" "c" "t") w)
       (member? (list "t" "c" "a") w)
       (member? (list "a" "t" "c") w)
       (member? (list "t" "a" "c") w)))

 
; String -> List-of-strings
; finds all words that the letters of some given word spell

(check-satisfied (arrangements (list "c" "a" "t"))
                 all-words-from-cat?)

(check-expect (arrangements '()) (list '()))

