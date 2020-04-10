;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 197ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 197
;; ------------
;; Design most-frequent. The function consumes a Dictionary. It produces the
;; Letter-Count for the letter that occurs most often as the first one in the
;; given Dictionary.
;;
;; What is the most frequently used letter in your computer’s dictionary and
;; how often is it used?
;;
;; *Note on Design Choices* This exercise calls for the composition of the
;; solution to the preceding exercise with a function that picks the correct
;; pairing from a list of Letter-Counts. There are two ways to design this
;; latter function:
;; 
;; - Design a function that picks the pair with the maximum count.
;; - Design a function that selects the first from a sorted list of pairs.
;;
;; Consider designing both. Which one do you prefer? Why? 
;; -----------------------------------------------------------------------------

(require 2htdp/batch-io)


(define-struct letter-count [letter count])
; Letter-Count is a structure
;   (make-struct 1String Number)
; interpretation. letter is the letter considered
; count is the number of occurrences

; Letter-Counts is a List-of-letter-counts which is one of:
; - '()
; - (cons Letter-Count List-of-letter-counts)


(define FREQ-LST
  (list
   (make-letter-count "a" 14537)
   (make-letter-count "b" 9675)
   (make-letter-count "c" 17406)
   (make-letter-count "d" 9946)
   (make-letter-count "e" 7818)
   (make-letter-count "f" 6382)
   (make-letter-count "g" 5843)
   (make-letter-count "h" 7889)
   (make-letter-count "i" 8303)
   (make-letter-count "j" 1158)
   (make-letter-count "k" 1735)
   (make-letter-count "l" 5211)
   (make-letter-count "m" 10709)
   (make-letter-count "n" 6098)
   (make-letter-count "o" 7219)
   (make-letter-count "p" 22171)
   (make-letter-count "q" 1075)
   (make-letter-count "r" 8955)
   (make-letter-count "s" 22759)
   (make-letter-count "t" 11389)
   (make-letter-count "u" 16179)
   (make-letter-count "v" 3079)
   (make-letter-count "w" 3607)
   (make-letter-count "x" 293)
   (make-letter-count "y" 532)
   (make-letter-count "z" 719)))

(define FREQ-LST-SORTED
  (list
 (make-letter-count "s" 22759)
 (make-letter-count "p" 22171)
 (make-letter-count "c" 17406)
 (make-letter-count "u" 16179)
 (make-letter-count "a" 14537)
 (make-letter-count "t" 11389)
 (make-letter-count "m" 10709)
 (make-letter-count "d" 9946)
 (make-letter-count "b" 9675)
 (make-letter-count "r" 8955)
 (make-letter-count "i" 8303)
 (make-letter-count "h" 7889)
 (make-letter-count "e" 7818)
 (make-letter-count "o" 7219)
 (make-letter-count "f" 6382)
 (make-letter-count "n" 6098)
 (make-letter-count "g" 5843)
 (make-letter-count "l" 5211)
 (make-letter-count "w" 3607)
 (make-letter-count "v" 3079)
 (make-letter-count "k" 1735)
 (make-letter-count "j" 1158)
 (make-letter-count "q" 1075)
 (make-letter-count "z" 719)
 (make-letter-count "y" 532)
 (make-letter-count "x" 293)))

;; --------------------------- looks for the max (doesn't sort)

; Letter-Counts -> Letter-Count
; letter count with the max # of occurrences

(check-expect (most-frequent FREQ-LST) (make-letter-count "s" 22759))
(check-expect (most-frequent (list (first FREQ-LST))) (make-letter-count "a" 14537))
(check-error (most-frequent '()))

(define (most-frequent lcl)
  (cond
    [(empty? lcl) (error "no max element in an empty list")]
    [(empty? (rest lcl)) (first lcl)]
    [else (if (>= (letter-count-count (first lcl))
                  (letter-count-count (most-frequent (rest lcl))))
              (first lcl)
              (most-frequent (rest lcl)))]))

;; --------------------------- sorts and picks the first 

; Letter-Counts -> Letter-Count
; picks the letter count with the max # of occurrence

(check-expect (most-frequent.v2 FREQ-LST) (make-letter-count "s" 22759))

(define (most-frequent.v2 lcl)
  (first (sort-letter-count>= lcl)))

; Letter-Counts -> Letter-Counts
; sorts Letter-Counts by occurrence #

(check-expect (sort-letter-count>= FREQ-LST) FREQ-LST-SORTED)

(define (sort-letter-count>= lcl)
  (cond
    [(empty? lcl) '()]
    [else (insert-lc>= (first lcl) (sort-letter-count>= (rest lcl)))]))

; Letter-Count Letter-Counts -> Letter-Counts
; inserts a letter count into letter counts
(define (insert-lc>= lc lcl)
  (cond
    [(empty? lcl) (list lc)]
    [else (if (>= (letter-count-count lc)
                  (letter-count-count  (first lcl)))
              (cons lc lcl)
              (cons (first lcl) (insert-lc>= lc (rest lcl))))]))


; Depends.
; A dictionary is already sorted lexicographically. It makes sense to directly
; search for the max. If there already exists a copy of the dictionary sorted
; by the count (descending), the msecond alternative would be preferable.