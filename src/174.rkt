;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |174|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
 ;; Exercise 174
;; ------------
;; Design a program that encodes text files numerically. Each letter in a word
;; should be encoded as a numeric three-letter string with a value between 0 and
;; 256. Figure 69 shows our encoding function for single letters. Before you
;; start, explain these functions.
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)

; Figure 69: Encoding strings

; 1String -> String
; converts the given 1String to a 3-letter numeric String
 
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t")
              (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a")
              (string-append "0" (code1 "a")))
 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))
 
; 1String -> String
; converts the given 1String into a String
 
(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))


;; According to the documentation for `string->int` =>
;; "Converts a 1-letter string to an integer in [0,55295] or [57344, 1114111]."
;; code1 then wraps it in number->string to convert it back to a string

; encode-letter calls code1 and then prepends 00, 0, or 10 if the number
; is less than 10, less than 100, or greater or equal to than 100



;; --------------------------------------------------------------------------

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

; stubs

;; LLS -> String
;; encodes a list of list of string by using
;; encode-letter to encode each letter
#;
(define (lls-encode lls)
  "")

;; LOS -> String
;; encodes a list of strings by using
;; encode-letter to encode each letter
#;
(define (los-encode los)
  "")

;; String -> String
;; encodes a string
#;
(define (string-encode los)
  "")

;; String -> String
;; encodes a list of 1Strings by using
;; encode-letter to encode each letter
#;
(define (lo1s-encode lo1s)
  "")

;; integration test

(define part1 "06609709910703210511003211610410103205704811501007")
(define part2 "30321190971150321051100320970321181011141210321020")
(define part3 "97109111117115032084086032115104111119")

(define result (string-append part1 part2 part3))


(check-expect (encode-file "bojack.txt") result)

; unit tests + functions

(check-expect (lls-encode '()) "")

(define (lls-encode lls)
  (cond
    [(empty? lls) ""]
    [(empty? (rest lls)) (los-encode (first lls))]
    [else (string-append (los-encode (first lls))
                         (encode-letter "\n") ; adding that new line
                         (lls-encode (rest lls)))]))


(check-expect (los-encode '()) "")
(check-expect (los-encode (cons "Back" (cons "in" (cons "the" (cons "90s" '())))))
              "066097099107032105110032116104101032057048115")

(define (los-encode los)
  (cond
    [(empty? los) ""]
    [(empty? (rest los)) (string-encode (first los))]
    [else (string-append (string-encode (first los))
                         (encode-letter " ") ; adding space lost by explode
                         (los-encode (rest los)))]))

(check-expect (string-encode "Back")
              "066097099107")

(define (string-encode s)
  (lo1s-encode (explode s)))


(check-expect (lo1s-encode '())
              "")
(check-expect (lo1s-encode (cons "B" (cons "a" (cons "c" (cons "k" '())))))
              "066097099107")



(define (lo1s-encode lo1s)
  (cond
    [(empty? lo1s) ""]
    [else (string-append (encode-letter (first lo1s))
                         (lo1s-encode (rest lo1s)))]))

;; --


; String -> String
; encodes the content of the file (named `name`) using
; `encode-letter` to encode each letter
(define (encode-file name)
  (lls-encode (read-words/line name)))




