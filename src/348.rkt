;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 348ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 348                                                                |
| ------------                                                                |
| Develop a data representation for Boolean BSL expressions constructed from  |
| #true, #false, and, or, and not. Then design eval-bool-expression, which    |
| consumes (representations of) Boolean BSL expressions and computes their    |
| values. What kind of values do these Boolean expressions yield?             |
+-----------------------------------------------------------------------------+
|#

;; A Bool-exp is one of
;; - #true
;; - #false
;; - (list 'and Bool-exp Bool-exp)
;; - (list 'or Bool-exp Bool-exp)
;; - (list 'not Bool-exp Bool-exp)

;; Bool-exp -> Boolean
;; computes the value of b-exp

(check-expect (eval-bool-expression #true) #true)
(check-expect (eval-bool-expression #false) #false)

(check-expect (eval-bool-expression '(or #true #true)) #true)
(check-expect (eval-bool-expression '(or #true #false)) #true)
(check-expect (eval-bool-expression '(or #false #true)) #true)
(check-expect (eval-bool-expression '(or #false #false)) #false)

(check-expect (eval-bool-expression '(not #true)) #false)
(check-expect (eval-bool-expression '(not #false)) #true)

(check-expect (eval-bool-expression '(and #true #true)) #true)
(check-expect (eval-bool-expression '(and #true #false)) #false)
(check-expect (eval-bool-expression '(and #false #true)) #false)
(check-expect (eval-bool-expression '(and #false #false)) #false)

(check-expect (eval-bool-expression '(and (or #false #true) (or #true #false))) #true)
(check-expect (eval-bool-expression '(or (and #true #false) (and #true #true))) #true)
(check-expect (eval-bool-expression '(not (and (not #false) #false))) #true)


(define (eval-bool-expression b-exp)
  (cond
    [(boolean? b-exp) b-exp]
    [(symbol=? 'or (first b-exp)) (or (eval-bool-expression (second b-exp)) (eval-bool-expression (third b-exp)))]
    [(symbol=? 'not (first b-exp)) (not (eval-bool-expression (second b-exp)))]
    [(symbol=? 'and (first b-exp)) (and (eval-bool-expression (second b-exp)) (eval-bool-expression (third b-exp)))]))

; as the signature showb, boolean expressions yield only boolean values