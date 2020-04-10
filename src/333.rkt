;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 333ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 333
;; ------------
;; Design the function how-many, which determines how many files a given Dir.v2
;; contains. Exercise 332 provides you with data examples. Compare your result
;; with that of exercise 331.
;; -----------------------------------------------------------------------------

; Data Definition
; ===============

(define-struct dir [name content])
; A Dir.v2 is a structure: 
;   (make-dir String LOFD)
 
; An LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a String.

; Data Examples
; =============

; files 
(define hang "hang")
(define draw "draw")
(define read!-in-docs "read!")
(define read!-in-ts "read!")
(define part1 "part1")
(define part2 "part2")
(define part3 "part3")

; directories
(define code (make-dir "Code" (list hang draw)))
(define docs (make-dir "Docs" (list read!-in-docs)))
(define text (make-dir "Text" (list part1 part2 part3)))
(define libs (make-dir "Libs" (list code docs)))
(define ts (make-dir "TS" (list read!-in-ts text libs)))

; lofd
(define lofd-code (list code))
(define lofd-docs (list docs))
(define lofd-text (list text))
(define lofd-libs (list libs))
(define lofd-ts (list ts))

; Signature, Purpose Statement, Stub
; ==================================

; LOFD -> Nat
; how many files does lofd contain?
#;
(define (how-many d)
  0)

; Tests
; =====
(check-expect (how-many lofd-ts) 7)
(check-expect (how-many lofd-text) 3)
(check-expect (how-many lofd-libs) 3)
(check-expect (how-many lofd-docs) 1)
(check-expect (how-many lofd-code) 2)
(check-expect (how-many '()) 0)

; Template
; ========

#;
(define (lofd-temp l)
  (cond
    [(empty? l) ...]
    [(dir? (first l)) (... (dir-temp (first l)) ... (lofd-temp (rest l)) ...)]
    [else (... (first l) ... (lofd-temp (rest l)) ...)]))

(define (dir-temp d)
  (... (dir-name d) ... (dir-content d) ...))


; Code
; ====

(define (how-many l)
  (local (; Dir.v2 -> Number
          ; how many files in directory d?
          (define (how-many-dir d)
            (how-many (dir-content d))))
    (cond
      [(empty? l) 0]
      [(dir? (first l)) (+ (how-many-dir (first l)) (how-many (rest l)))]
      [else (+ 1 (how-many (rest l)))])))