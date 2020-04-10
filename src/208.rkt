;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 208ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 208
;; ------------
;; Design boolean-attributes. The function consumes an LLists and produces the
;; Strings that are associated with a Boolean attribute. Hint Use create-set
;; from exercise 201.
;;
;; Once you are done, determine how many Boolean-valued attributes your iTunes
;; library employs for its tracks. Do they make sense? 
;; -----------------------------------------------------------------------------

(require 2htdp/itunes)

(require "201ex.rkt")
; provides
; create-set : List-of-strings -> List-of-strings
; removes duplicates from los

; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
 
; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
; 
; An Association is a list of two items: 
;   (cons String (cons BSDN '()))

(define lassoc1 (list (list "b" #t) (list "e" #f) (list "e" #t) (list "e" 1) (list "r" #t)))
(define lassoc2 (list (list "m" #t) (list "u" #f) (list "tt" 1) (list "g" #t) (list "" "")))

(define llists1 (list lassoc1 lassoc2))

; ---

(check-expect (boolean-attributes llists1) (list "b" "e" "e" "r" "m" "u" "g"))
(check-expect (boolean-attributes '()) '())

; LLists -> List-of-strings
; strings associated with a boolean attributes within the lassocs
(define (boolean-attributes llists)
  (cond
    [(empty? llists) '()]
    [else (append (lassoc-boolean-str (first llists)) (boolean-attributes (rest llists)))]))

; Lassoc -> List-of-strings
; strings associated with boolean attributes in lassoc

(check-expect (lassoc-boolean-str '()) '())
(check-expect (lassoc-boolean-str lassoc1) (list "b" "e" "e" "r"))
(check-expect (lassoc-boolean-str lassoc2) (list "m" "u" "g"))

(define (lassoc-boolean-str lassoc)
  (cond
    [(empty? lassoc) '()]
    [else (if (boolean? (second (first lassoc)))
              (cons (first (first lassoc)) (lassoc-boolean-str (rest lassoc)))
              (lassoc-boolean-str (rest lassoc)))]))
