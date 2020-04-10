;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 439ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 439
;; ------------
;; Copy gcd-structural into DrRacket and evaluate
;; 
;;    (time (gcd-structural 101135853 45014640))
;;
;; in the interactions area.
;; -----------------------------------------------------------------------------


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


(time (gcd-structural 101135853 45014640))
; => 
;; cpu time: 8606 real time: 8765 gc time: 128
;; 177