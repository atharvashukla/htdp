;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 459ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 459
;; ------------
;; Another simple integration method divides the area into many small
;; rectangles. Each rectangle has a fixed width and is as tall as the function
;; graph in the middle of the rectangle. Adding up the areas of the rectangles
;; produces an estimate of the area under the function’s graph.
;;
;; Let's use
;;
;; R = 10
;;
;; to stand for the number of rectangles to be considered. Hence the width of
;; each rectangle is
;;
;; W = (b-a)/R
;;
;; The height of one of these rectangles is the value of f at its midpoint. The
;; first midpoint is clearly at a plus half of the width of the rectangle,
;;
;; S = width/2
;;
;; which means its area is
;;
;; W*f(a+S)
;;
;; To compute the area of the second rectangle, we must add the width of one
;; rectangle to the first midpoint:
;;
;; W*f(a+W+S),
;;
;; For the third one, we get
;;
;; W*f(a+2*W+S)
;;
;; In general, we can use the following formula for the ith rectangle:
;;
;; W*f(a+i*W+S)
;;
;; The first rectangle has index 0, the last one R - 1.
;;
;; Using these rectangles, we can now determine the area under the graph:
;;
;; Summation from i = 0 to i = R-1 of W*f(a+i*W+S)
;; = W*f(a+0*W+S) + ... + ... W*f(a+(R-1)*W+S)
;;
;; Turn the description of the process into an ISL+ function. Adapt the test
;; cases from figure 165 to this case.
;;
;; The more rectangles the algorithm uses, the closer its estimate is to the
;; actual area. Make R a top-level constant and increase it by factors of 10
;; until the algorithm’s accuracy eliminates problems with an ε value of 0.1.
;;
;; Decrease ε to 0.01 and increase R enough to eliminate any failing test
;; cases again. Compare the result to exercise 458. 
;; -----------------------------------------------------------------------------



; tolerance level
(define eps 0.01)
; number of rectangles to divide the curve into 
(define R 1000)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within (integrate (lambda (x) 20) 12 22) 200 eps)
(check-within (integrate (lambda (x) (* 2 x)) 0 10) 100 eps)
(check-within (integrate (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              eps)
 
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

