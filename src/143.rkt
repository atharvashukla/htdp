;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 143ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 143.
;; -------------
;; Determine how average behaves in DrRacket when applied to the empty list.
;; Then design checked-average, a function that produces an informative error
;; message when it is applied to '().
;; -----------------------------------------------------------------------------

; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)
 
; A CTemperature is a Number greater than -273.

; List-of-temperatures -> Number
; computes the average temperature 
#;
(define (average alot)
  0)

#;
(define (average alot)
  (cond
    [(empty? alot) ...]
    [(cons? alot)
     (... (first alot) ...
      ... (average (rest alot)) ...)]))

;; ^ unnatural

;-------------------------------------------------------

; List-of-temperatures -> Number
; computes the average temperature

(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-expect (average (cons 1 (cons 1 (cons 1 '())))) 1)

(define (average alot)
  (/ (sum alot) (how-many alot)))
 
; List-of-temperatures -> Number 
; adds up the temperatures on the given list

(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(check-expect (sum (cons 1 (cons 1 (cons 1 '())))) 3)

(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

 
; List-of-temperatures -> Number 
; counts the temperatures on the given list

(check-expect (how-many (cons 1 (cons 2 (cons 3 '())))) 3)
(check-expect (how-many (cons 1 (cons 1 (cons 1 '())))) 3)

(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ 1 (how-many (rest alot)))]))


; > (average '())
; /: division by zero


(check-error (checked-average '()) "can't take the average of 0 values")
(check-expect (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-expect (checked-average (cons 1 (cons 1 (cons 1 '())))) 1)

(define (checked-average alot)
  (cond
    [(= (how-many alot) 0) (error "can't take the average of 0 values")]
    [else (/ (sum alot) (how-many alot))]))

