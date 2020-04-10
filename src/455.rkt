;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 455ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 455
;; ------------
;; Translate this mathematical formula into the ISL+ function slope, which maps
;; function f and a number r1 to the slope of f at r1. Assume that ε is a global
;; constant. For your examples, use functions whose exact slope you can figure
;; out, say, horizontal lines, linear functions, and perhaps polynomials if you
;; know some calculus.
;; -----------------------------------------------------------------------------

(define ep 0.000001)

; [Number -> Number] Number -> Number
; slope of f at point r

(check-expect (slope (λ (x) (* 2 x)) 04) 2)
(check-expect (slope (λ (x) 3) 21) 0)
; f = x^3. f' = 3x^2. f'(2) = 12
(check-within (slope (λ (x) (expt x 3)) 2) 12 0.0001)

(define (slope f r)
  (/ (- (f (+ r ep)) (f (- r ep)))
     (- (+ r ep) (- r ep))))



