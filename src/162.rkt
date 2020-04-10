;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 162ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 162
;; ------------
;; No employee could possibly work more than 100 hours per week. To protect the
;; company against fraud, the function should check that no item of the input
;; list of wage* exceeds 100. If one of them does, the function should
;; immediately signal an error. How do we have to change the function in figure
;; 64 if we want to perform this basic reality check?
;; -----------------------------------------------------------------------------

(define pay-rate 14)

; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (cond
    [(> h 100) (error "an employee cannot work for more than 100 hours")]
    [else (* pay-rate h)]))

(check-expect (wage 1) (* 1 pay-rate))
(check-expect (wage 9) (* 9 pay-rate))
(check-error (wage 101) "an employee cannot work for more than 100 hours")


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
(check-expect (wage* (cons 1 (cons 2 '()))) (cons (* 1 pay-rate) (cons (* 2 pay-rate) '())))
(check-expect (wage* (cons 1 (cons 2 (cons 1 '())))) (cons (* 1 pay-rate) (cons (* 2 pay-rate) (cons (* 1 pay-rate) '()))))
(check-error (wage* (cons 1 (cons 101 '()))) "an employee cannot work for more than 100 hours")