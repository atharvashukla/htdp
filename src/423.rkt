;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 423ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 423
;; ------------
;; Define partition. It consumes a String s and a natural number n. The function
;; produces a list of string chunks of size n.
;;
;; For non-empty strings s and positive natural numbers n,
;;
;;    (equal? (partition s n) (bundle (explode s) n))
;;
;; is #true. But don’t use this equality as the definition for partition; use
;; substring instead.
;;
;; *Hint* Have partition produce its natural result for the empty string. For
;; the case where n is 0, see exercise 421.
;;
;; *Note* The partition function is somewhat closer to what a cooperative
;; DrRacket environment would need than bundle. 
;; -----------------------------------------------------------------------------

; String Number -> [List-of String]
; list of chunks of size n

(check-expect (partition "abcdefg" 3)
              (list "abc" "def" "g"))

(check-expect (partition "ab" 3) (list "ab"))

(check-expect (partition "" 3) '())


; String N -> [List-of String]
; bundles chunks of s into strings of length n
; *idea* take n items and drop n at a time
(define (partition s n)
  (cond
    [(empty-string? s) '()]
    [else (cons (take s n)
                (partition (drop s n) n))]))
 
; String N -> String
; keeps the first n chars from s if possible or everything
(define (take s n)
  (cond
    [(zero? n) ""]
    [(empty-string? s) ""]
    [else (string-append (string-first s) (take (string-rest s) (sub1 n)))]))
 
; String N -> String
; removes the first n chars from s if possible or everything
(define (drop s n)
  (cond
    [(zero? n) s]
    [(empty-string? s) s]
    [else (drop (string-rest s) (sub1 n))]))


; ---------- String helpers ----------

; NEString -> String
; gets the first character of a ne-str

(check-expect (string-first "abc") "a")

(define (string-first ne-str)
  (substring ne-str 0 1))

; NEString -> String
; gets the rest of the ne-str

(check-expect (string-rest "abc") "bc")

(define (string-rest ne-str)
  (substring ne-str 1))


; NEString -> String
; gets the last character of ne-str

(check-expect (string-last "abc") "c")

(define (string-last ne-str)
  (substring ne-str (sub1 (string-length ne-str))))

; NEString -> String
; removes the last character of ne-str

(check-expect (string-remove-last "abc") "ab")

(define (string-remove-last ne-str)
  (substring ne-str 0 (sub1 (string-length ne-str))))

; String -> Boolean
; is the string "" ?

(check-expect (empty-string? "abc") #false)
(check-expect (empty-string? "") #true)

(define (empty-string? str)
  (string=? "" str))