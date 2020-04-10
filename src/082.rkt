;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 82ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 82.
;; ------------
;; Design the function compare-word. The function consumes two three-letter
;; words (see exercise 78). It produces a word that indicates where the given
;; ones agree and disagree. The function retains the content of the structure
;; fields if the two agree; otherwise it places #false in the field of the
;; resulting word. Hint The exercises mentions two tasks: the comparison of
;; words and the comparison of “letters.”
;; -----------------------------------------------------------------------------

; A Letter is one of
; - 1Strings from "a" to "z"
; - #false

(define-struct 3lword [l1 l2 l3])
; A 3LWord (3LetterWord) is a structure:
;   (make-3lword Letter Letter Letter)
; *interpretation* 3 letters which can either
; be 1Strings from "a" to  "b" or #false.
; (Part of the hangman game)

(define 3lw-1 (make-3lword "a" "b" "c"))
(define 3lw-2 (make-3lword "a" "c" "b"))
(define 3lw-3 (make-3lword "a" #false "c"))
(define 3lw-4 (make-3lword #false #false #false))

; 3LWord 3LWord -> 3LWord
; produces a word that indicates where
; w1 and w2 agree and disagree.
#;
(define (compare-word w1 w2)
  (make-word #false #false #false))

; comparing 3lw-1 and 3lw-2 produces (make-3lword "a" #false #false)
; comparing 3lw-2 and 3lw-3 produces (make-3lword "a" #false #false)
; comparing 3lw-3 and 3lw-4 produces (make-3lword #false #false #false)

(define (compare-word-temp w1 w2)
  (... (3lword-l1 w1) ... (3lword-l2 w1) ... (3lword-l3 w1) ...
       (3lword-l1 w2) ... (3lword-l2 w2) ... (3lword-l3 w3) ...))

(define (letter-temp l1 l2)
  (cond [(string? l1) ...]
        [(equal? #false l1) ...]))


(define (compare-word w1 w2)
  (make-3lword  (compare-letter (3lword-l1 w1) (3lword-l1 w2))
                (compare-letter (3lword-l2 w1) (3lword-l2 w2))
                (compare-letter (3lword-l3 w1) (3lword-l3 w2))))

; Letter Letter -> Letter
; if l1 and l2 are the same 1String, returns l1,
; otherwise returns #false
(define (compare-letter l1 l2)
  #;
  (cond [(string? l1) (if (equal? l1 l2) l1 #false)]
        [(equal? #false l1) #false])
  ;; simplification:
  (if (equal? l1 l2) l1 #false))


(check-expect (compare-word 3lw-1 3lw-2) (make-3lword "a" #false #false))
(check-expect (compare-word 3lw-2 3lw-3) (make-3lword "a" #false #false))
(check-expect (compare-word 3lw-3 3lw-4) (make-3lword #false #false #false))