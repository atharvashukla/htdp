;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 248ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------+
| Exercise 248.                                                         |
| -------------                                                         |
| Evaluate (squared>? 3 10) and (squared>? 4 10) in DrRacket’s stepper. |
+-----------------------------------------------------------------------+
|#


; Number Number -> Boolean
; is the area of a square with side x larger than c
(define (squared>? x c)
  (> (* x x) c))


; (squared>? 3 10)

; ==

(define step11 (> (* 3 3) 10))
(define step12 (> 9 10))
(define step13 #false)


(check-expect (squared>? 3 10) step11)
(check-expect step11 step12)
(check-expect step12 step13)



; (squared>? 4 10)

(define step21 (> (* 4 4) 10))
(define step22 (> 16 10))
(define step23 #true)

(check-expect (squared>? 4 10) step21)
(check-expect step21 step22)
(check-expect step22 step23)