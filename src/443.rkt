;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 443ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 443
;; ------------
;; Given the header material for gcd-structural, a naive use of the design
;; recipe might use the following template or some variant:
;;
;;    (define (gcd-structural n m)
;;      (cond
;;        [(and (= n 1) (= m 1)) ...]
;;        [(and (> n 1) (= m 1)) ...]
;;        [(and (= n 1) (> m 1)) ...]
;;        [else
;;         (... (gcd-structural (sub1 n) (sub1 m)) ...
;;          ... (gcd-structural (sub1 n) m) ...
;;          ... (gcd-structural n (sub1 m)) ...)]))
;;
;; Why is it impossible to find a divisor with this strategy? 
;; -----------------------------------------------------------------------------


; 1. we need to count down from the smaller number
; 2. we need to access both m and n each recursive call


; I don't think it's impossible to make gcd-structural from that template.
; I think it can evolve to the solution given in Figure 154.
