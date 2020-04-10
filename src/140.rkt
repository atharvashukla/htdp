;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 140ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 140.
;; -------------
;; Design the function all-true, which consumes a list of Boolean values and
;; determines whether all of them are #true. In other words, if there is any
;; #false on the list, the function produces #false.
;;
;; Now design one-true, a function that consumes a list of Boolean values and
;; determines whether at least one item on the list is #true.
;; -----------------------------------------------------------------------------


;; List-of-booleans is one of
;; - '()
;; - (cons Boolean List-of-booleans)
;; interpretation. a list of booleans.

(define (lob-temp lob)
  (cond
    [(empty? lob) ...]
    [else (... (first lob) ... (lob-temp (rest lob)) ...)]))

;; List-of-booleans -> Boolean
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
    [(empty? lob) #true]
    [else (and (first lob) (all-true (rest lob)))]))

;; List-of-booleans -> Boolean
;; is at least one value in lob #true?

(check-expect (one-true (cons #t '())) #t)
(check-expect (one-true (cons #f '())) #f)
(check-expect (one-true (cons #t (cons #t (cons #t '())))) #t)
(check-expect (one-true (cons #t (cons #f (cons #t '())))) #t)

(define (one-true lob)
  (cond
    [(empty? lob) #false]
    [else (or (first lob) (one-true (rest lob)))]))