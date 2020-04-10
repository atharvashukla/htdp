;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 161ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
;; Exercise 161
;; ------------
;; Translate the examples into tests and make sure they all succeed. Then change
;; the function in figure 64 so that everyone gets $14 per hour. Now revise the
;; entire program so that changing the wage for everyone is a single change to
;; the entire program and not several.
;; -----------------------------------------------------------------------------
|#

(define PAY-RATE 14)

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* PAY-RATE h))

(check-expect (wage 1) (* 1 PAY-RATE))
(check-expect (wage 9) (* 9 PAY-RATE))


; List-of-numbers -> List-of-numbers
; computes the weekly wages for the weekly hours
#;
(define (wage* whrs)
  '())

#;
(define (wage* whrs)
  (cond
    [(empty? whrs) ...]
    [else (... (first whrs) ...
           ... (wage* (rest whrs)) ...)]))

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))

(check-expect (wage* '()) '())
(check-expect (wage* (cons 1 (cons 2 '()))) (cons (* 1 PAY-RATE) (cons (* 2 PAY-RATE) '())))
(check-expect (wage* (cons 1 (cons 2 (cons 1 '())))) (cons (* 1 PAY-RATE) (cons (* 2 PAY-RATE) (cons (* 1 PAY-RATE) '()))))