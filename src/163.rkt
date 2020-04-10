;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 163ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 163
;; ------------
;; Design convertFC. The function converts a list of measurements in Fahrenheit
;; to a list of Celsius measurements.
;; -----------------------------------------------------------------------------

; Lit-of-numbers -> List-of-numbers
; converts a list of fahrenheit to a list of celsius
(define (convertFC lof)
  (cond
    [(empty? lof) '()]
    [else (cons (convertFCOne (first lof)) (convertFC (rest lof)))]))

; c = (f-32)* (5/9)

(check-expect (convertFC '()) '())
(check-expect (convertFC (cons -4 (cons 32 '())))
              (cons -20 (cons 0 '())))
(check-expect (convertFC (cons 50 (cons 104 '())))
              (cons 10 (cons 40 '())))

; Number -> Number
; converts a fahrenheit value to a celsius value
(define (convertFCOne f)
  (* (- f 32) 5/9))

(check-expect (convertFCOne -4) -20)
(check-expect (convertFCOne 32) 0)
(check-expect (convertFCOne 50) 10)
(check-expect (convertFCOne 104) 40)





