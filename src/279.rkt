;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 279ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 279
;; ------------
;; Decide which of the following phrases are legal lambda expressions:
;;
;;  1. (lambda (x y) (x y y))
;;
;;  2. (lambda () 10)
;;
;;  3. (lambda (x) x)
;;
;;  4. (lambda (x y) x)
;;
;;  5. (lambda x 10)
;;
;; Explain why they are legal or illegal. If in doubt, experiment in the
;; interactions area of DrRacket. 
;; -----------------------------------------------------------------------------

; (lambda (x y) (x y y)) is legal
((lambda (x y) (x y y)) + 2)

; (lambda () 10) is illegal - should have atleast 1 argument


; (lambda (x) x) is legal
((lambda (x) x) 1)

; (lambda (x y) x) is legal
((lambda (x y) x) 2 3)


; (lambda x 10) is illegal - missing brackets around arguments