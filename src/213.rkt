;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 213ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 213
;; ------------
;; Design insert-everywhere/in-all-words. It consumes a 1String and a list of
;; words. The result is a list of words like its second argument, but with the
;; first argument inserted at the beginning, between all letters, and at the end
;; of all words of the given list.
;;
;; Start with a complete wish-list entry. Supplement it with tests for empty
;; lists, a list with a one-letter word, and another list with a two-letter
;; word, and the like. Before you continue, study the following three hints
;; carefully.
;;
;; *Hints* (1) Reconsider the example from above. It says that "d" needs to be
;; inserted into the words (list "e" "r") and (list "r" "e"). The following
;; application is therefore one natural candidate for an example:
;;
;;    (insert-everywhere/in-all-words "d"
;;      (cons (list "e" "r")
;;        (cons (list "r" "e")
;;          '())))
;; (2) You want to use the BSL+ operation append, which consumes two lists and
;; produces the concatenation of the two lists:
;;
;;    > (append (list "a" "b" "c") (list "d" "e"))
;;    (list "a" "b" "c" "d" "e")
;;
;; The development of functions like append is the subject of Simultaneous
;; Processing.
;;
;; (3) This solution of this exercise is a series of functions. Patiently stick
;; to the design recipe and systematically work through your wish list. 
;; -----------------------------------------------------------------------------

(require "provide.rkt")
(provide insert-everywhere/in-all-words)

(check-expect
 (insert-everywhere/in-all-words
  "d"
  (list (list)))
 (list (list "d")))

(check-expect
 (insert-everywhere/in-all-words
  "d"
  (list (list "r")))
 (list (list "r" "d")
       (list "d" "r")))

(check-expect
 (insert-everywhere/in-all-words
  "d"
  (list (list "e" "r")
        (list "r" "e")))
 (list (list "e" "r" "d")
       (list "e" "d" "r")
       (list "d" "e" "r")
       (list "r" "e" "d")
       (list "r" "d" "e")
       (list "d" "r" "e")))

; 1String List-of-words -> List-of-words
#;
(define (insert-everywhere/in-all-words s l)
  (cond
    [(empty? l) ...]
    [else (...  ... (first l) ; : Word
                ... (insert-everywhere/in-all-words s (rest l))  ; : List-of-words
                ...)]))

(define (insert-everywhere/in-all-words s l)
  (cond
    [(empty? l) '()]
    [else (append (insert-everywhere s (first l)) ; : Word -> List-of-words
                  (insert-everywhere/in-all-words s (rest l))  ; : List-of-words
                  )]))

; 1String Word -> List-of-words
; inserts s at all positions in w and makes a list of them

(check-expect (insert-everywhere "d" (list "e" "r"))
              (list (list "e" "r" "d") (list "e" "d" "r") (list "d" "e" "r")))

(check-expect (insert-everywhere "d"  '())
              (list (list "d")))

(define (insert-everywhere s w)
  (insert-everywhere-aux s w (length w)))


; 1String Word  Nat -> List-of-words
; inserts s at all positions in w at positions 0 to n


(check-expect (insert-everywhere-aux "d"  '() 0)
              (list (list "d")))

(check-expect (insert-everywhere-aux "d" (list "e" "r") 0)
              (list (list "d" "e" "r")))

(check-expect (insert-everywhere-aux "d" (list "e" "r") 1)
              (list (list "e" "d" "r") (list "d" "e" "r")))

(check-expect (insert-everywhere-aux "d" (list "e" "r") 2)
              (list (list "e" "r" "d") (list "e" "d" "r") (list "d" "e" "r")))

(define (insert-everywhere-aux s w n)
  (cond
    [(= 0 n) (list (insert-s-at-ith s w 0))]
    [else (cons (insert-s-at-ith s w n)
                (insert-everywhere-aux s w (sub1 n)))]))


; 1String Word Nat -> Word
; inserts s at ith position in w (i <= (length w))

(check-expect (insert-s-at-ith "d" (list "e" "r") 0) (list "d" "e" "r"))
(check-expect (insert-s-at-ith "d" (list "e" "r") 1) (list "e" "d" "r"))
(check-expect (insert-s-at-ith "d" (list "e" "r") 2) (list "e" "r" "d"))

(define (insert-s-at-ith s w i)
  (cond
    [(= i 0) (cons s w)]
    [else (cons (first w) (insert-s-at-ith s (rest w) (sub1 i)))]))



