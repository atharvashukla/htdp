;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 349ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 349.                                                               |
| -------------                                                               |
| Create tests for parse until DrRacket tells you that every element in the   |
| definitions area is covered during the test run.                            |
+-----------------------------------------------------------------------------+
|#

(define-struct add [left right])
; An Add is a Structure:
;  (make-add BSL-expr BSL-expr)
; interpretation. (make-add BSL-expr BSL-expr) shows
; the addition of two BSL-expr

(define-struct mul [left right])
; A Mul is a structure:
;  (make-mul BSL-expr BSL-expr)
; interpretation (make-mul BSL-expr BSL-expr) shows
; the multiplication of two BSL-expr

;; BSL-expr is one of
;; - Number
;; - (make-add BSL-expr BSL-expr)
;; - (make-mul BSL-expr BSL-expr)
;; interpretation. represents an addition/multiplication
;; of two numbers in Beginning Student Language


;; Any -> Boolean
;; is the x an atom?
(define (atom? x)
  (not (list? x)))

(define WRONG "WRONG")

(check-error (parse '(+ 1)))
(check-error (parse '(+ 1 2 2)))
(check-error (parse '(+ 1 2 2)))
(check-error (parse "foobar"))
(check-error (parse 'foobar))
(check-expect (parse '(+ 3 2)) (make-add 3 2))
(check-expect (parse '(* 3 2)) (make-mul 3 2))
(check-error (parse '(/ 3 1)))
(check-expect (parse 1) 1)


; S-expr -> BSL-expr
(define (parse s)
  (cond
    [(atom? s) (parse-atom s)]
    [else (parse-sl s)]))
 
; SL -> BSL-expr 
(define (parse-sl s)
  (local ((define L (length s)))
    (cond
      [(< L 3) (error WRONG)]
      [(and (= L 3) (symbol? (first s)))
       (cond
         [(symbol=? (first s) '+)
          (make-add (parse (second s)) (parse (third s)))]
         [(symbol=? (first s) '*)
          (make-mul (parse (second s)) (parse (third s)))]
         [else (error WRONG)])]
      [else (error WRONG)])))
 
; Atom -> BSL-expr 
(define (parse-atom s)
  (cond
    [(number? s) s]
    [(string? s) (error WRONG)]
    [(symbol? s) (error WRONG)]))

