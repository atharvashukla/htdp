;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 396ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 396
;; ------------
;; Hangman is a well-known guessing game. One player picks a word, the other
;; player gets told how many letters the word contains. The latter picks a
;; letter and asks the first player whether and where this letter occurs in the
;; chosen word. The game is over after an agreed-upon time or number of rounds.
;;
;; Figure 136 presents the essence of a time-limited version of the game. See
;; Local Definitions Add Expressive Power for why checked-compare is defined
;; locally.
;;
;; The goal of this exercise is to design compare-word, the central function.
;; It consumes the word to be guessed, a word s that represents how much/little
;; the guessing player has discovered, and the current guess. The function
;; produces s with all "_" where the guess revealed a letter.
;;
;; Once you have designed the function, run the program like this:
;;
;;    (define LOCATION "/usr/share/dict/words") ; on OS X
;;    (define AS-LIST (read-lines LOCATION))
;;    (define SIZE (length AS-LIST))
;;    (play (list-ref AS-LIST (random SIZE)) 10)
;;
;; See figure 74 for an explanation. Enjoy and refine as desired! 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)
(require 2htdp/batch-io)

(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

; An HM-Word is a [List-of Letter or "_"]
; interpretation "_" represents a letter to be guessed 
 
; HM-Word N -> String
; runs a simplistic hangman game, produces the current state
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ; HM-Word -> HM-Word
          (define (do-nothing s) s)
          ; HM-Word KeyEvent -> HM-Word 
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status)))
    (implode
     (big-bang the-guess ; HM-Word
       [to-draw render-word]
       [on-tick do-nothing 1 time-limit]
       [on-key  checked-compare]))))
 
; HM-Word -> Image
(define (render-word w)
  (text (implode w) 22 "black"))

; Figure 136: A simple hangman game



; HM-Word HM-Word 1String -> HM-Word
; reveals a letter in current-status according to ke

(check-expect (compare-word (explode "atharva") (explode "_th_rv_") "a") (explode "atharva"))
(check-expect (compare-word (explode "aaaaaaa") (explode "_______") "b") (explode "_______"))
(check-expect (compare-word (explode "bbbbbbb") (explode "_______") "b") (explode "bbbbbbb"))

#;
(define (compare-word the-word current-status ke)
  (cond
    [(empty? the-word) ...]
    [else (... (first the-word) ... (compare-word (rest the-word) (rest current-status) ke))]))

(define (compare-word the-word current-status ke)
  (cond
    [(empty? the-word) '()]
    [else (cons (if (or (equal? (first the-word) ke)
                        (equal? (first the-word) (first current-status)))
                    (first the-word)
                    (first current-status))
                (compare-word (rest the-word) (rest current-status) ke))]))



(define LOCATION "/usr/share/dict/words") ; on OS X
(define AS-LIST (read-lines LOCATION))
(define SIZE (length AS-LIST))
(play (list-ref AS-LIST (random SIZE)) 10)
