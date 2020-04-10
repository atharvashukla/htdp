;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 414ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 414
;; ------------
;; As this section illustrates, gaps in the data representation lead to
;; round-off errors when numbers are mapped to Inexes. The problem is, suc
;; round-off errors accumulate across computations.
;; 
;; Design add, a function that adds up n copies of #i1/185. For your examples,
;; use 0 and 1; for the latter, use a tolerance of 0.0001. What is the result
;; for (add 185)? What would you expect? What happens if you multiply the result
;; with a large number?

;; Design sub. The function counts how often 1/185 can be subtracted from the
;; argument until it is 0. Use 0 and 1/185 for your examples. What are the
;; expected results? What are the results for (sub 1) and (sub #i1.0)? What
;; happens in the second case? Why?
;; -----------------------------------------------------------------------------


; Number -> Number
; add n copies of #i1/185

(check-within (add 0) 0 0.0001)
(check-within (add 1) #i1/185 0.0001)

(define (add n)
  (cond
    [(= n 0) 0]
    [else (+ #i1/185 (add (sub1 n)))]))


(add 185)
; => #i0.9999999999999949
; I would expect 1!


; (expt 2 55) should be equal to  (* (expt 2 55) (add 185))
; but
;   (expt 2 55)               =    36028797018963968
; - (* (expt 2 55) (add 185)) = - #i36028797018963784.0
; -----------------------------------------------------
; #i184.0
; -----------------------------------------------------


; Number -> Number
; number of times #i1/185 be subtracted from n to reach 0

(check-expect (sub 0) 0)
(check-expect (sub #i1/185) 1)

(define (sub n)
  (cond
    [(<= n 0) 0]
    [else (+ 1 (sub (- n #i1/185)))]))


(sub 1)
; => 186
(sub #i1.0)
; => 186
