;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 307ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 307
;; ------------
;; Define find-name. The function consumes a name and a list of names. It
;; retrieves the first name on the latter that is equal to, or an extension of,
;; the former.
;;
;; Define a function that ensures that no name on some list of names exceeds
;; some given width. Compare with exercise 271. 
;; -----------------------------------------------------------------------------

(require 2htdp/abstraction)

; String [List-of String]
; any strings in l an extension of s?

(check-expect (find-name "s" '()) #false)
(check-expect (find-name "s" '("as")) #false)
(check-expect (find-name "s" '("s")) "s")
(check-expect (find-name "sas" '("s" "tr" "sass")) "sass")

(define (find-name s l)
  (for/or ((e l))
    (if (and ; first make sure lenght is appropriate for substring
         (>= (string-length e) (string-length s)) 
         (string=? (substring e 0 (string-length s)) s))
        e
        #false)))



; [List-of String] -> Boolean
; does none of the strings in name have more than length # of char?

(check-expect (none-exceeds-lenght? '() 5) #t)
(check-expect (none-exceeds-lenght? '("a" "b" "c") 2) #true)
(check-expect (none-exceeds-lenght? '("a" "ab" "abc") 2) #false)

(define (none-exceeds-lenght? names length)
  (for/and ((str names))
    (> length (string-length str))))