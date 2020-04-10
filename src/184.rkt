;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 184ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 184
;; ------------
;;
;;    1. (list (string=? "a" "b") #false)
;;    
;;    2. (list (+ 10 20) (* 10 20) (/ 10 20))
;;    
;;    3. (list "dana" "jane" "mary" "laura")
;;
;; Use check-expect to express your answers.
;;
;; -----------------------------------------------------------------------------

; Expressions
(define one-exp (list (string=? "a" "b") #false))

(define two-exp (list (+ 10 20) (* 10 20) (/ 10 20)))

(define three-exp (list "dana" "jane" "mary" "laura"))

; Evaluated
(define one-eval (list #false #false))

(define two-eval (list 30 200 1/2))

(define three-eval (list "dana" "jane" "mary" "laura"))


; Tests
(check-expect one-exp one-eval)

(check-expect two-exp two-eval)

(check-expect three-exp three-eval)