;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 438ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 438
;; ------------
;; In your words: how does greatest-divisor-<= work? Use the design recipe to
;; find the right words. Why does the locally defined greatest-divisor-<= recur
;; on (min n m)?
;; -----------------------------------------------------------------------------


(check-expect (gcd-structural 24 18) 6)
(check-expect (gcd-structural 24 1) 1)

(define (gcd-structural n m)
  (local (; N -> N
          ; determines the gcd of n and m less than i
          (define (greatest-divisor-<= i)
            (cond
              [(= i 1) 1]
              [else
               (if (= (remainder n i) (remainder m i) 0)
                   i
                   (greatest-divisor-<= (- i 1)))])))
    (greatest-divisor-<= (min n m))))


; Design
; ------
; The data definition of natural numbers call for an analogous template

; Base case: the gcd of 1 is 1
; Recursive case:
; - Is the current consideration a divisor of both numbers? if yes, it is the gcd
; - Otherwise we try the function on one less

; Q. Why does the locally defined greatest-divisor-<= recur on (min n m)?
; A. a divisor cannot be greater than the number itself

