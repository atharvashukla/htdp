;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 309ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 309
;; ------------
;; Design the function words-on-line, which determines the number of Strings per
;; item in a list of list of strings.
;; -----------------------------------------------------------------------------


(require 2htdp/abstraction)

; [List-of [List-of String]] -> [List-of Number]
; Number of strings per item in los

(check-expect (words-on-line '(("w" "qw" "dd" ""))) '(4))
(check-expect (words-on-line '(("w" "") ("w" "ry" "u") ("s"))) '(2 3 1))

#;
(define (words-on-line lolos)
  (for/list ((los lolos))
    (length los)))


(define (words-on-line lolos)
  (match lolos
    ['() '()]
    [(cons f r) (cons (length f) (words-on-line r))]))

