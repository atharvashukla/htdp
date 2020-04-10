;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 461ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 461
;; ------------
;; Design integrate-adaptive. That is, turn the recursive process description
;; into an ISL+ algorithm. Make sure to adapt the test cases from figure 165 to
;; this use.

;; Do not discuss the termination of integrate-adaptive.

;; Does integrate-adaptive always compute a better answer than either
;; integrate-kepler or integrate-rectangles? Which aspect is integrate-adaptive
;; guaranteed to improve?
;; -----------------------------------------------------------------------------

; tolerance level
(define eps 0.01)
; number of rectangles to divide the curve into 
(define R 1000)
; interval smallness threshold
(define int 0.1)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds. Adapts between kepler or integrate
; 
 
(check-within (integrate-adaptive (lambda (x) 20) 12 22) 200 eps)
(check-within (integrate-adaptive (lambda (x) (* 2 x)) 0 10) 100 eps)
(check-within (integrate-adaptive (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              eps)
(check-within (integrate-adaptive (lambda (x) (* 3 (sqr x))) 0 0.05)
              0.00012499996875
              eps)

; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
(define (integrate-adaptive f a b)
  (local ((define mid (/ (+ a b) 2))
          (define l-area (integrate-kepler f a mid))
          (define r-area (integrate-kepler f mid b))
          (define sum-lr-area (+ l-area r-area))
          (define full-area (integrate-kepler f a b)))
    (if (<= (abs (- full-area sum-lr-area)) (* eps (- b a)))
        full-area
        (integrate f a b))))
 
(define (integrate f a b)
  (local (; Width of one rectangle
          (define W (/ (- b a) R))
          ; Half-width of one rectangle
          (define S (/ W 2))
          ; Number -> Number
          ; area of ith rectangle
          (define (area-rec i)
            (* W (f (+ a (* i W) S))))
          ; Number -> Number
          ; area of all n rectangles
          (define (sum-rectangles n)
            (apply + (build-list n area-rec))))
    (sum-rectangles R)))


; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds. kepler's method.
(define (integrate-kepler f a b)
  (* 1/2 (- b a) (+ (f a) (f b))))

