;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 456ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 456
;; ------------
;; Design root-of-tangent, a function that maps f and r1 to the root of the
;; tangent through (r1,(f r1)).
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


; [Number -> Number] Number -> Number
; root of tangent on f at r

(check-within (λ (x) (/ 1 x)) 0.85 0.0001)

(define (root-of-tangent f r)
  (- r (/ (f r) (slope f r))))