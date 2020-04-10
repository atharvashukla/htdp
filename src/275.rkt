;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 275ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 275
;; ------------
;; Real-World Data: Dictionaries deals with relatively simple tasks relating to
;; English dictionaries. The design of two of them just call out for the use of
;; existing abstractions:
;;
;; - Design most-frequent. The function consumes a Dictionary and produces the
;;   Letter-Count for the letter that is most frequently used as the first one
;;   in the words of the given Dictionary.
;;
;; - Design words-by-first-letter. The function consumes a Dictionary and
;;   produces a list of Dictionarys, one per Letter. Do not include '() if there
;;   are no words for some letter; ignore the empty grouping instead.
;;
;; For the data definitions, see figure 74. 
;; -----------------------------------------------------------------------------


; A Dictionary is a [List-of String]
; interpretation. the words of a dictionary

(define-struct letter-count [letter count])
; Letter-Count is a structure
;   (make-struct 1String Number)
; interpretation. letter is the letter considered
; count is the number of occurrences

; Dictionary -> Letter-Count
; the letter count of the most frequent starting letter

(check-expect (most-frequent (list "a" "d" "w" "a" "q" "w" "w" "a" " " "a"))
              (make-letter-count "a" 4))

(define (most-frequent d)
  (argmax letter-count-count (map (λ (x) (make-letter-count x (occurrences x d))) d)))

; 1String [List-of String] -> Nat
; how many words in l that start with el?

(check-expect (occurrences "x" '()) 0)
(check-expect (occurrences "x" '("a" "b" "x" "y" "x" "c" "x")) 3)

(define (occurrences el l)
  (foldr (λ (e a) (if (equal? el (substring e 0 1)) (+ a 1) a)) 0 l))

;; -----------------------------------------------------------------------------

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; Dictionary -> List-of-dictionaries
; created individual dictionaries per letter from dic (no empty dictionaries)

(check-expect (word-by-first-letter (list "asd" "app" "pow" "aws" "o" "e" "poe" "eee"))
              (list (list "asd" "app" "aws") (list "e" "eee") (list "o") (list "pow" "poe")))

(define (word-by-first-letter dic)
  (local (; Letter -> Dictionary
          ; creates a dictionary of words starting with letters l
          (define (create-dic l)
            (local (; Dictionary -> Dictionary
                    ; walks through dic to collect all words startint with l
                    (define (create-dic-h dic)
                      (foldr (λ (e a) (if (string=? l (substring e 0 1)) (cons e a) a)) '() dic)))
              (create-dic-h dic))))
    (remove-all '() (map create-dic LETTERS))))