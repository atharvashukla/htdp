;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 196ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 196
;; ------------
;; Design count-by-letter. The function consumes a Dictionary and counts how
;; often each letter is used as the first one of a word in the given dictionary.
;; Its result is a list of Letter-Counts, a piece of data that combines letters
;; and counts.
;; 
;; Once your function is designed, determine how many words appear for all
;; letters in your computer’s dictionary.
;; 
;; *Note on Design Choices* An alternative is to design an auxiliary function
;; that consumes a list of letters and a dictionary and produces a list of
;; Letter-Counts that report how often the given letters occur as first ones
;; in the dictionary. You may of course reuse your solution of exercise 195.
;; *Hint* If you design this variant, notice that the function consumes two
;; lists, requiring a design problem that is covered in Simultaneous Processing
;; in detail. Think of Dictionary as an atomic piece of data that is along for
;; the ride and is handed over to starts-with# as needed. 
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

; provides (starts-with# d l) : Letter Dictionary -> Nat
(require "195ex.rkt")


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


(define-struct letter-count [letter count])
; Letter-Count is a structure
;   (make-struct 1String Number)
; interpretation. letter is the letter considered
; count is the number of occurrences

; Letter-Counts is a List-of-letter-counts which is one of:
; - '()
; - (cons Letter-Count List-of-letter-counts)


; Dictionary -> List-of-letter-counts
(define (count-by-letter d)
  (count-by-letter-aux LETTERS d))


; List-of-letters Dictionary -> List-of-letter-counts
#;
(define (count-by-letter-aux l-lst d)
  '())

#;
(define (count-by-letter-aux-temp l-lst d)
  (cond
    [(empty? l-lst) ...]
    [else (... (first l-lst) ... (count-by-letter-aux-temp (rest l-lst)) ...)]))


(define (count-by-letter-aux l-lst d)
  (cond
    [(empty? l-lst) '()]
    [else (cons (make-letter-count (first l-lst)                   ; letter
                                   (starts-with# d (first l-lst))) ; count
                (count-by-letter-aux (rest l-lst) d))]))

(count-by-letter AS-LIST)


; -- verfification --

(define CAPITAL-LETTERS
  (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))

(define TOTAL-WORDS 235886)

; List-of-letter-counts -> Number
; sum of all the letter counts in the list

(check-expect (sum-letter-counts '()) 0)
(check-expect (sum-letter-counts (list (make-letter-count "a" 14537) (make-letter-count "b" 9675))) 24212)

(define (sum-letter-counts l-lst)
  (cond
    [(empty? l-lst) 0]
    [else (+ (letter-count-count (first l-lst))
             (sum-letter-counts (rest l-lst)))]))

(check-expect (+ (sum-letter-counts (count-by-letter-aux LETTERS AS-LIST))
                 (sum-letter-counts (count-by-letter-aux CAPITAL-LETTERS AS-LIST)))
              TOTAL-WORDS)

