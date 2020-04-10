;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 164ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 164
;; ------------
;; Design the function convert-euro, which converts a list of US$ amounts into a
;; list of € amounts. Look up the current exchange rate on the web.
;;
;; Generalize convert-euro to the function convert-euro*, which consumes an
;; exchange rate and a list of US$ amounts and converts the latter into a list
;; of € amounts. 
;; -----------------------------------------------------------------------------

; 1 usd = 0.81 euro
(define conversion-rate 0.81)


; Number -> Number
; converts a usd value to a euro value
(define (convert-euro usd)
  (* usd conversion-rate))

(check-expect (convert-euro 0) 0)
(check-expect (convert-euro 100) 81)
(check-expect (convert-euro 50) 40.5)

; List-of-number -> List-of-number
(define (convert-euro* lousd)
  (cond
    [(empty? lousd) '()]
    [else (cons (convert-euro (first lousd)) (convert-euro* (rest lousd)))]))

(check-expect (convert-euro* '()) '())
(check-expect (convert-euro* (cons 0 '())) (cons 0 '()))
(check-expect (convert-euro* (cons 0 (cons 100 '()))) (cons 0 (cons 81 '())))