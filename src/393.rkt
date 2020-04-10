;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 393ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 393
;; ------------
;; Figure 62 presents two data definitions for finite sets. Design the union
;; function for the representation of finite sets of your choice. It consumes
;; two sets and produces one that contains the elements of both.
;; 
;; Design intersect for the same set representation. It consumes two sets and
;; produces the set of exactly those elements that occur in both.
;; -----------------------------------------------------------------------------

; renaming Son.R to Son:
	
; A Son is one of: 
; – empty 
; – (cons Number Son)
; 
; Constraint If s is a Son, 
; no number occurs twice in s

;; ------------

; Son
(define es '())
 
; Number Son -> Boolean
; is x in s
(define (in? x s)
  (member? x s))

; Son N -> Son
; remove an x from s
(define (set- x s)
  (remove x s))

; Son N -> Son`
; add x to s
(define (set+ x s)
  (if (member? x s)
      s
      (cons x s)))

;; ------------

; Son Son -> Son
; the union of s1 and s2
#;
(define (set-union s1 s2)
  s1)

(check-expect (set-union '() '()) '())
(check-expect (set-union '(1 2 3) '()) '(1 2 3))
(check-expect (set-union '() '(1 2 3)) '(1 2 3))
(check-expect (set-union '(1 3 90) '(90 1 3)) '(1 3 90))
(check-expect (set-union '(1 2 3) '(1 2 3)) '(1 2 3))
(check-expect (set-union '(1 2 3) '(4 5 6)) '(4 5 6 1 2 3))

#;
(define (set-union s1 s2)
  (cond
    [(empty? s2) ...]
    [else (... (first s2) ... (set-union s1 (rest s2)) ...)]))


(define (set-union s1 s2)
  (cond
    [(empty? s2) s1]
    [else (set+ (first s2) (set-union s1 (rest s2)))]))

; Son Son -> Son
; the intersection of s1 and s2
#;
(define (se-inter s1 s2)
  '())

(check-expect (set-inter '() '()) '())
(check-expect (set-inter '(1 2 3) '()) '())
(check-expect (set-inter '() '(1 2 3)) '())
(check-expect (set-inter '(1 3 90) '(90 1 3)) '(90 1 3))
(check-expect (set-inter '(1 2 3) '(1 2 3)) '(1 2 3))
(check-expect (set-inter '(1 2 3) '(4 5 6)) '())

#;
(define (set-inter s1 s2)
  (cond
    [(empty? s2) ...]
    [else (... (first s2) ... (set-inter s1 (rest s2)) ...)]))


(define (set-inter s1 s2)
  (cond
    [(empty? s2) '()]
    [else (if (in? (first s2) s1)
                   (set+ (first s2) (set-inter s1 (rest s2)))
                   (set-inter s1 (rest s2)))]))

