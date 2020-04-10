;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 138ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 138.
;; -------------
;; Here is a data definition for representing sequences of amounts of money:
;;
;;    ; A List-of-amounts is one of: 
;;    ; – '()
;;    ; – (cons PositiveNumber List-of-amounts)
;;
;; Create some examples to make sure you understand the data definition. Also
;; add an arrow for the self-reference.
;;
;; Design the sum function, which consumes a List-of-amounts and computes the
;; sum of the amounts. Use DrRacket’s stepper to see how (sum l) works for a
;; short list l in List-of-amounts. 
;; -----------------------------------------------------------------------------

; A List-of-amounts is one of: 
; – '()
; – (cons Number List-of-amounts)


(define ex-a-1 '())
(define ex-a-2 (cons 1 '()))
(define ex-a-3 (cons 4 (cons 6 '())))


;; List-of-amounts -> Number
;; computes the sum of all amounts in loa

#;
(define (sum-loa loa)
  0)

(check-expect (sum-loa ex-a-1) 0)
(check-expect (sum-loa ex-a-2) 1)
(check-expect (sum-loa (cons 1 (cons 2 (cons 3 '())))) 6)

(define (sum-loa alos)
  (cond
    [(empty? alos) 0]
    [else (+ (first alos) (sum-loa (rest alos)) )]))
