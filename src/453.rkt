;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 453ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 453
;; ------------
;; Design the function tokenize. It turns a Line into a list of tokens. Here a
;; token is either a 1String or a String that consists of lower-case letters and
;; nothing else. That is, all white-space 1Strings are dropped; all other
;; non-letters remain as is; and all consecutive letters are bundled into
;; “words.” *Hint* Read up on the string-whitespace? function.
;; -----------------------------------------------------------------------------


; A File is one of: 
; – '()
; – (cons "\n" File)
; – (cons 1String File)
; interpretation represents the content of a file 
; "\n" is the newline character


; A Line is a [List-of 1String].

; A Token is one of
; - 1String
; - String
; interpretation. either a string of lower-case letters
; or a 1string (does not include whitespace)


; Line -> [List-of Token]
; bundles all lower-case letters into words,
; drops whitespaces, and keeps the rest as 1strings
#;
(define (tokenize line)
'())

(check-expect
 (tokenize
  (list "a" "b" "c" "\n" "d" "e" "\n" "f" "g" "h" "\n"))
 (list "abc" "de" "fgh"))

(check-expect
 (tokenize
  (list "a" "b" "c" "\n" "D" "e" "\n" "f" "g" "H" "\n"))
 (list "abc" "D" "e" "fg" "H"))

(check-expect
 (tokenize
  (list "a" "1" "c" "\n" "D" "e" "\n" "5" "g" "H" "\n"))
 (list "a" "1" "c" "D" "e" "5" "g" "H"))

(check-expect
 (tokenize
  (list "a" "b" "c" "4" "d" "e" "\n" "f" "g" "h" "\n"))
 (list "abc" "4" "de" "fgh"))



(define (tokenize line)
  (cond
    [(empty? line) '()]
    [(and (string-whitespace? (first line))(empty? (rest line))) '()]
    [else (cons (extract-first-token line) (tokenize (remove-first-token line)))]))



; Line -> Token
; first token of the line

(check-expect (extract-first-token (list "a" "b" "c" "\n")) "abc")
(check-expect (extract-first-token (list "a" "b" "c" "S")) "abc")
(check-expect (extract-first-token (list "a" "b" "c" "4" "d" "e" "\n" "f" "g" "h" "\n")) "abc")

(define (extract-first-token l)
  (local ((define (extract-first-token-h line)
            (cond
              [(empty? line) ""]
              [(string-whitespace? (first line)) ""]
              [(not (string-lower-case? (first line))) ""]
              [(string-lower-case? (first line))
               (string-append (first line) (extract-first-token-h (rest line)))])))
    (if (and (not (empty? l))
             (not (string-whitespace? (first l)))
             (not (string-lower-case? (first l))))
        (first l)
        (extract-first-token-h l))))




; Line -> Line
; remove the first token from the line

(check-expect (remove-first-token (list "a" "b" "c" "4" "d" "e" "\n" "f" "g" "h" "\n"))
              (list "4" "d" "e" "\n" "f" "g" "h" "\n"))

(define (remove-first-token l)
  (local ((define (remove-first-token-h line)
            (cond
              [(empty? line) '()]
              [(string-whitespace? (first line)) (rest line)]
              [(not (string-lower-case? (first line))) line]
              [else (remove-first-token-h (rest line))])))
    (if (and (not (empty? l))
             (not (string-whitespace? (first l)))
             (not (string-lower-case? (first l))))
        (rest l)
        (remove-first-token-h l))))


