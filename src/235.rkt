;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 235ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 235
;; ------------
;; Use the contains? function to define functions that search for "atom",
;; "basic", and "zoo", respectively. 
;; -----------------------------------------------------------------------------


; String Los -> Boolean
; determines whether l contains the string s

(check-expect (contains? "a" '()) #false)
(check-expect (contains? "a" '("b" "c")) #false)
(check-expect (contains? "a" '("b" "a" "c")) #true)

(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))

; Los -> Boolean
; does l contain "dog"

(check-expect (contains-dog? '()) #false)
(check-expect (contains-dog? '("b" "c")) #false)
(check-expect (contains-dog? '("b" "dog" "c")) #true)

(define (contains-dog? l)
  (contains? "dog" l))
     

; Los -> Boolean
; does l contain "cat"

(check-expect (contains-cat? '()) #false)
(check-expect (contains-cat? '("b" "c")) #false)
(check-expect (contains-cat? '("b" "cat" "c")) #true)

(define (contains-cat? l)
  (contains? "cat" l))

; Los -> Boolean
; does l contain "atom"

(check-expect (contains-atom? '()) #false)
(check-expect (contains-atom? '("b" "c")) #false)
(check-expect (contains-atom? '("b" "atom" "c")) #true)

(define (contains-atom? l)
  (contains? "atom" l))
     

; Los -> Boolean
; does l contain "basic"

(check-expect (contains-basic? '()) #false)
(check-expect (contains-basic? '("b" "c")) #false)
(check-expect (contains-basic? '("b" "basic" "c")) #true)

(define (contains-basic? l)
  (contains? "basic" l))

; Los -> Boolean
; does l contain "zoo"

(check-expect (contains-zoo? '()) #false)
(check-expect (contains-zoo? '("b" "c")) #false)
(check-expect (contains-zoo? '("b" "zoo" "c")) #true)

(define (contains-zoo? l)
  (contains? "zoo" l))