;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 4.
; -----------
; Use the same setup as in exercise 3 to create an expression that deletes the
; ith position from str. Clearly this expression creates a shorter string than
; the given one. Which values for i are legitimate?
; ------------------------------------------------------------------------------

(define str "helloworld")
(define ind "0123456789")
(define i 5)

(string-append (substring ind 0 (- i 1))
               (substring ind i (string-length ind)))

; legitimate range for i : [0, (length str))