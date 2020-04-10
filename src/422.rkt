;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 422ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 422
;; ------------
;; Define the function list->chunks. It consumes a list l of arbitrary data and
;; a natural number n. The function’s result is a list of list chunks of size n.
;; Each chunk represents a sub-sequence of items in l.
;; 
;; Use list->chunks to define bundle via function composition.
;; -----------------------------------------------------------------------------

; [X] [List-of X] -> [List-of [List-of X]]
; chunks l into sublists of size n

(check-expect (list->chunks (explode "abcdefg") 3)
              (map explode (list "abc" "def" "g")))

(check-expect (list->chunks '("a" "b") 3)
              (list (explode "ab")))

(check-expect (list->chunks '() 3) '())

(define (list->chunks l n)
  (cond
    [(empty? l) '()]
    [else
     (cons (take l n) (list->chunks (drop l n) n))]))


; --------------------

(check-expect (bundle (explode "abcdefg") 3)
              (list "abc" "def" "g"))

(check-expect (bundle '("a" "b") 3) (list "ab"))

(check-expect (bundle '() 3) '())

; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
; idea take n items and drop n at a time
(define (bundle s n)
  (map implode (list->chunks s n)))


; --------------------


; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
 
; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))