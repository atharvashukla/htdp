;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |175 [nc]|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 175
;; ------------
;; Design a BSL program that simulates the Unix command wc. The purpose of the
;; command is to count the number of 1Strings, words, and lines in a given file.
;; That is, the command consumes the name of a file and produces a value that
;; consists of three numbers.
;; -----------------------------------------------------------------------------

; I have tested this by applying the `wc` command from the terminal on some text files

(require 2htdp/batch-io)

(define-struct wc-info [1strings words lines])
; A WCInfo is a struct
;   (make-wc-info Nat Nat Nat)
; interpretation number of 1string, words and lines
; in a file.



;; Data definitions and templates

; A List-of-list-of-string (LLS) is one of:
; - '()
; - (cons List-of-strings LLS)
; interpretation a list that contains a list of strings

; LLS -> ...
(define (lls-temp lls)
  (cond
    [(empty? lls) ...]
    [else (... (los-temp (first lls)) ; LOS
               ... (lls-temp (rest lls)) ...)]))

; A List-of-strings (LOS) is one of:
; - '()
; - (cons String LOS)
; interpretation a list of strings

; LOS -> ...
(define (los-temp los)
  (cond
    [(empty? los) ...]
    [else (... (process-string (first los)) ; string
               ... (los-temp (rest los)) ...)]))

; String -> ...
(define (process-string s)
  (lo-1string-temp
   ; conversion of a string to a List-of-1Strings
   (explode s)))

;; List-of-1String (LO1S) is one of
;; - '()
;; - (cons 1String LO1S)

; List-of-1Strings -> ...
(define (lo-1string-temp lo1s)
  (cond
    [(empty? lo1s) ...]
    [else (... (process-1string (first lo1s)) ; 1String
               ... (lo-1string-temp (rest lo1s)) ...)]))


; ---- functions ----

;; LLS -> Nat
; number of lines in lls

(check-expect (lines-in-lls '()) 0)
(check-expect (lines-in-lls (cons (cons "a" '()) (cons '() '()))) 2)

(define (lines-in-lls lls)
  (cond
    [(empty? lls) 0]
    [else (add1 (lines-in-lls (rest lls)))]))


; LLS -> NAT
; number of strings in lls

(check-expect (count-strings-in-lls '()) 0)
(check-expect (count-strings-in-lls (cons (cons "a" (cons "b" '())) '())) 2)

(define (count-strings-in-lls lls)
  (cond
    [(empty? lls) 0]
    [else (+ (count-strings-in-los (first lls))
             (count-strings-in-lls (rest lls)))]))

; LOS -> Nat
; number of strings in los

(check-expect (count-strings-in-los '()) 0)
(check-expect (count-strings-in-los (make-list 4 "d")) 4)

(define (count-strings-in-los los)
  (cond
    [(empty? los) 0]
    [else (add1 (count-strings-in-los (rest los)))]))


; LLS -> NAT
; number of characters in lls (\n is a character)

(check-expect (count-1strings-in-lls '()) 0)
(check-expect (count-1strings-in-lls (cons (cons "a" (cons "b" '())) (cons (cons "a" (cons "b" '())) '()))) 7)

(define (count-1strings-in-lls lls)
  (cond
    [(empty? lls) 0]
    [(empty? (rest lls)) (count-1string-in-los (first lls))]
    [else (+ (count-1string-in-los (first lls))
             1 ; \n is a 1String
             (count-1strings-in-lls (rest lls)))]))

; LOS -> Nat
; number of 1strings in los (" " is a character)

(check-expect (count-1string-in-los '()) 0)
(check-expect (count-1string-in-los (cons "a" (cons "b" '()))) 3)

(define (count-1string-in-los los)
  (cond
    [(empty? los) 0]
    [(empty? (rest los)) (length (explode (first los)))]
    [else (+ (length (explode (first los)))
             1 ; " " is a 1String
             (count-1string-in-los (rest los)))]))


; 1String is a string of length 1

; String -> Boolean?
; is the str a 1string?

(check-expect (1string? "a") #true)
(check-expect (1string? "abc") #false)

(define (1string? str)
  (= (string-length str) 1))


; --

; String -> String
; encodes the content of the file (named `name`) using
; `encode-letter` to encode each letter

; $ wc ttt.txt
; 12      33     183 ttt.txt

(define (wc name)
  (make-wc-info (sub1 (lines-in-lls (read-words/line name))) ; (wc actually counts `\n`s) not # of lines
                (count-strings-in-lls (read-words/line name))
                (count-1strings-in-lls (read-words/line name))))


(check-expect (wc "ttt.txt") (make-wc-info 12 33 183))


