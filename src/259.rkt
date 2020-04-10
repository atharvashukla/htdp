;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 259ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 259
;; ------------
;; Use a local expression to organize the functions for rearranging words from
;; Word Games, the Heart of the Problem.
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; ---


(define (arrangements w)
  (local (; Word -> List-of-words
          ; creates all rearrangements of the letters in w
          (define (arrangements-in w)
            (cond
              [(empty? w) (list '())]
              [else (insert-everywhere/in-all-words (first w)
                                                    (arrangements-in (rest w)))]))

          ; 1String List-of-words -> List-of-words
          (define (insert-everywhere/in-all-words s l)
            (cond
              [(empty? l) '()]
              [else (append (insert-everywhere s (first l)) ; : Word -> List-of-words
                            (insert-everywhere/in-all-words s (rest l))  ; : List-of-words
                            )]))

          ; 1String Word -> List-of-words
          ; inserts s at all positions in w and makes a list of them
          (define (insert-everywhere s w)
            (insert-everywhere-aux s w (length w)))

          ; 1String Word  Nat -> List-of-words
          ; inserts s at all positions in w at positions 0 to n
          (define (insert-everywhere-aux s w n)
            (cond
              [(= 0 n) (list (insert-s-at-ith s w 0))]
              [else (cons (insert-s-at-ith s w n)
                          (insert-everywhere-aux s w (sub1 n)))]))

          ; 1String Word Nat -> Word
          ; inserts s at ith position in w (i <= (length w))
          (define (insert-s-at-ith s w i)
            (cond
              [(= i 0) (cons s w)]
              [else (cons (first w) (insert-s-at-ith s (rest w) (sub1 i)))])))
    
    (arrangements-in w)))

; ------- these functions are useful outside a local

; List-of-strings -> List-of-strings
; keeps all strings that are a part of the dictionary
(define (in-dictionary los d)
  (cond
    [(empty? los) '()]
    [else (if (word-in-dic? (first los) d)
              (cons (first los) (in-dictionary (rest los) d))
              (in-dictionary (rest los) d))]))

; String -> Boolean
; is w a part of the dictionary?
(define (word-in-dic? w d)
  (cond
    [(empty? d) #false]
    [else (or (string=? w (first d))
              (word-in-dic? w (rest d)))]))

; List-of-words -> List-of-strings
; collapses each word is `words` to a string
(define (words->strings words)
  (cond
    [(empty? words) '()]
    [else (cons (implode (first words))
                (words->strings (rest words)))]))

; String -> Word
; converts s to the chosen word representation
(define (string->word s)
  (explode s))

; ------- 

(define (alternative-words s)
  (local ((define s-as-word (string->word s))
          (define word-arrangements (arrangements s-as-word))
          (define arrangements-as-strings (words->strings word-arrangements))
          (define strings-in-dic (in-dictionary arrangements-as-strings AS-LIST)))
    strings-in-dic))



; ----- tests -----

(check-expect (alternative-words "cat") (list "act" "cat"))


; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
    (member? "rat" w) (member? "art" w) (member? "tar" w)))

(check-satisfied (alternative-words "rat")
                 all-words-from-rat?)
