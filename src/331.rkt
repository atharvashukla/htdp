;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 331ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 331
;; ------------
;; Design the function how-many, which determines how many files a given Dir.v1
;; contains. Remember to follow the design recipe; exercise 330 provides you
;; with data examples.
;; -----------------------------------------------------------------------------


; Data Definition
; ===============

; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1 Dir.v1)
 
; A File.v1 is a String. 

; Data Examples
; =============

; files (as strings)
(define hang "hang")
(define draw "draw")
(define read!-in-docs "read!")
(define read!-in-ts "read!")
(define part1 "part1")
(define part2 "part2")
(define part3 "part3")

; directories (as containers (lists))
(define code (list hang draw))
(define docs (list read!-in-docs))
(define text (list part1 part2 part3))
(define libs (list code docs))
(define ts (list read!-in-ts text libs))

; Signature, Purpose Statement, Stub
; ==================================

; Dir.v1 -> Nat
; how many files does d contain?
#;
(define (how-many d)
  0)

; Tests
; =====

(check-expect (how-many ts) 7)
(check-expect (how-many text) 3)
(check-expect (how-many libs) 3)
(check-expect (how-many docs) 1)
(check-expect (how-many code) 2)
(check-expect (how-many '()) 0)

; Template
; ========

#;
(define (dir-temp d)
  (cond
    [(empty? d) ...]
    [(string? (first d)) (... (first d) ... (dir-temp (rest d)) ...)]
    [else  (... (dir-temp (first d)) ... (dir-temp (rest d)) ...)]))


; Code
; ====

(define (how-many d)
  (cond
    [(empty? d) 0]
    [(string? (first d)) (+ 1 (how-many (rest d)))]
    [else  (+ (how-many (first d)) (how-many (rest d)))]))
