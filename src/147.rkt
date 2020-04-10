;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 147ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 147.
;; -------------
;; Develop a data definition for NEList-of-Booleans, a representation of
;; non-empty lists of Boolean values. Then redesign the functions all-true and
;; one-true from exercise 140.
;; -----------------------------------------------------------------------------


; A NEList-of-boolean is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-boolean)


;; NEList-of-booleans -> Boolean
;; are all the values in lob #true?
#;
(define (all-true lob)
  #true)

(check-expect (all-true (cons #t '())) #t)
(check-expect (all-true (cons #f '())) #f)
(check-expect (all-true (cons #t (cons #t (cons #t '())))) #t)
(check-expect (all-true (cons #t (cons #f (cons #t '())))) #f)

(define (all-true lob)
  (cond
    [(empty? (rest lob)) (first lob)]
    [else (and (first lob) (all-true (rest lob)))]))

;; NEList-of-booleans -> Boolean
;; is at least one value in lob #true?

(check-expect (one-true (cons #t '())) #t)
(check-expect (one-true (cons #f '())) #f)
(check-expect (one-true (cons #f (cons #t (cons #t '())))) #t)
(check-expect (one-true (cons #t (cons #f (cons #t '())))) #t)

(define (one-true lob)
  (cond
    [(empty? (rest lob)) (first lob)]
    [else (or (first lob) (one-true (rest lob)))]))