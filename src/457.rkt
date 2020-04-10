;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 457ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 457
;; ------------
;; Design the function double-amount, which computes how many months it takes to
;; double a given amount of money when a savings account pays interest at a
;; fixed rate on a monthly basis.
;;
;; *Domain Knowledge* With a minor algebraic manipulation, you can show that the
;; given amount is irrelevant. Only the interest rate matters. Also domain
;; experts know that doubling occurs after roughly 72/r month as long as the
;; interest rate r is “small.” 
;; -----------------------------------------------------------------------------

; Number Number -> Number
; how many months to double a at interest of i
(define (double-amount amt int)
  (local ((define (double-amount-h a)
            (if (<= (* amt 2) a)
                0
                (+ 1 (double-amount-h (next-month-amt a int))))))
    (double-amount-h amt)))


; Number Number -> Number
; the updated amount
(define (next-month-amt a i)
  (+ a (* a i)))



(double-amount 100 0.01)