;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 198ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 198
;; ------------
;; Design words-by-first-letter. The function consumes a Dictionary and produces
;; a list of Dictionarys, one per Letter.
;;
;; Redesign most-frequent from exercise 197 using this new function. Call the
;; new function most-frequent.v2. Once you have completed the design, ensure
;; that the two functions compute the same result on your computer’s dictionary:
;;
;;    (check-expect
;;      (most-frequent AS-LIST)
;;      (most-frequent.v2 AS-LIST))
;;
;; *Note on Design Choices* For words-by-first-letter you have a choice for
;; dealing with the situation when the given dictionary does not contain any
;; words for some letter:
;;
;; - One alternative is to exclude the resulting empty dictionaries from the
;;   overall result. Doing so simplifies both the testing of the function and
;;   the design of most-frequent.v2, but it also requires the design of an
;;   auxiliary function.
;;
;; - The other one is to include '() as the result of looking for words of a
;;   certain letter, even if there aren’t any. This alternative avoids the
;;   auxiliary function needed for the first alternative but adds complexity
;;   to the design of most-frequent.v2. *End*
;;
;; Note on Intermediate Data and Deforestation This second version of the
;; word-counting function computes the desired result via the creation of a
;; large intermediate data structure that serves no real purpose other than that
;; its parts are counted. On occasion, the programming language eliminates them
;; automatically by fusing the two functions into one, a transformation on
;; programs that is also called deforestation. When you know that the language
;; does not deforest programs, consider eliminating such data structures if the
;; program does not process data fast enough.
;;
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

; On OS X: 
(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend

; ------ DATA DEFINITIONS ------ 
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))


; List-of-dictionaries is one of:
; - '()
; - (cons Dictionary List-of-dictionaries)

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; List-of-dictionaries -> List-of-dictionaries
; removes empty dictionaries from a list of dictionaries

(define-struct letter-count [letter count])
; Letter-Count is a structure
;   (make-struct 1String Number)
; interpretation. letter is the letter considered
; count is the number of occurrences

; Letter-Counts is a List-of-letter-counts which is one of:
; - '()
; - (cons Letter-Count List-of-letter-counts)

;; -----------------------------------------------------------------------------

(check-expect (remove-emptys '()) '())
(check-expect (remove-emptys (list (list "a" "c" "d") '() (list "a")))
              (list (list "a" "c" "d") (list "a")))
(check-expect (remove-emptys (list '() '())) '())

(define (remove-emptys l)
  (cond
    [(empty? l) '()]
    [else (if (empty? (first l))
              (remove-emptys (rest l))
              (cons (first l) (remove-emptys (rest l))))]))

; Dictionary -> List-of-dictionaries
; created individual dictionaries per letter from dic (no empty dictionaries)

(check-expect (word-by-first-letter (list "asd" "app" "pow" "aws" "o" "e" "poe" "eee"))
              (list (list "asd" "app" "aws") (list "e" "eee") (list "o") (list "pow" "poe")))

(define (word-by-first-letter dic)
  (remove-emptys (create-dics dic LETTERS)))

; Dictionary Letters -> List-of-dictionaries
; created individual dictionaries per letter from dic

(define (create-dics dic ls)
  (cond
    [(empty? ls) '()]
    [else (cons (create-dic dic (first ls)) (create-dics dic (rest ls)))]))


; Dictionary Letter -> Dictionary
; creates a dictionary by extracting all words that start with l in dic

(check-expect (create-dic '() "a") '())
(check-expect (create-dic (list "asd" "app" "pow" "aws" "o" "e" "poe" "eee") "a")
              (list "asd" "app" "aws"))

(define (create-dic dic l)
  (cond
    [(empty? dic) '()]
    [else  (if (string=? l (substring (first dic) 0 1))
               (cons (first dic) (create-dic (rest dic) l))
               (create-dic (rest dic) l))]))



;; -----------------------------------------------------------------------------

(define FREQ-LST
  (list (make-letter-count "a" 14537) (make-letter-count "s" 22759) (make-letter-count "z" 719)))


; Letter-Counts -> Letter-Count
; letter count with the max # of occurrences

(check-expect (most-frequent FREQ-LST) (make-letter-count "s" 22759))
(check-expect (most-frequent (list (first FREQ-LST))) (make-letter-count "a" 14537))
(check-error (most-frequent '()))

(define (most-frequent lcl)
  (cond
    [(empty? lcl) (error "no max element in an empty list")]
    [(empty? (rest lcl)) (first lcl)]
    [else (if (>= (letter-count-count (first lcl))
                  (letter-count-count (most-frequent (rest lcl))))
              (first lcl)
              (most-frequent (rest lcl)))]))


;; -----------------------------------------------------------------------------

; Dictionary -> Letter-Count
; letter count with the mac # of occurrences

(check-expect (most-frequent.v2 (list "asd" "app" "pow" "aws" "o" "e" "poe" "eee"))
              (make-letter-count "a" 3))

(define (most-frequent.v2 d)
  (make-letter-count
   ; the first letter of the first word
   (substring (first (longest-dic (word-by-first-letter d))) 0 1)
   ; length of the sub dictionary
   (length (longest-dic (word-by-first-letter d)))))


; List-of-dictionaries -> Dictionary
; extracts the longest dictionary from a list of dictionaries

(check-error (longest-dic '()))
(check-expect (longest-dic (list (list "e" "eee") (list "asd" "app" "aws") (list "o") (list "pow" "poe")))
                          (list "asd" "app" "aws"))

(define (longest-dic lod)
  (cond
    [(empty? lod) (error "no longest sub-dictionary of an empty list of dictionary")]
    [(empty? (rest lod)) (first lod)]
    [else (if (>= (length (first lod)) (length (longest-dic (rest lod))))
              (first lod)
              (longest-dic (rest lod)))]))