;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 370ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 370
;; ------------
;; Make up three examples for XWords. Design word?, which checks whether some
;; ISL+ value is in XWord, and word-text, which extracts the value of the only
;; attribute of an instance of XWord.
;; -----------------------------------------------------------------------------

; An XWord is '(word ((text String))).

(define w1 '(word ((text "indore"))))
(define w2 '(word ((text "bhopal"))))
(define w3 '(word ((text "ujjain"))))

; Any -> Boolean
; a recognizer fo XWords

(check-expect (word? #false) #false)
(check-expect (word? "hello") #false)
(check-expect (word? 'sym) #false)
(check-expect (word? '()) #false)
(check-expect (word? '(1 2 3)) #false)
(check-expect (word? '(word word word)) #false)
(check-expect (word? '(word 2)) #false)
(check-expect (word? '(word ())) #false)
(check-expect (word? '(word (1 2))) #false)
(check-expect (word? '(word ((1 2)))) #false)
(check-expect (word? '(word ((text 2)))) #false)
(check-expect (word? '(word ((text "2")))) #true)
(check-expect (word? '(word ((text "2") (text "more")))) #false)
(check-expect (word? '(word ((text "2")))) #true)
(check-expect (word? w1) #true)

(define (word? a)
  (and (list? a)
       (= (length a) 2)
       (equal? 'word (first a))
       (list? (second a))
       (= (length (second a)) 1)
       (list? (first (second a)))
       (= 2 (length (first (second a))))
       (equal? 'text (first (first (second a))))
       (string? (second (first (second a))))))


; XWord -> String
; extracts the text of the word w

(check-expect (word-text w1) "indore")

(define (word-text w)
  (second (first (second w))))
