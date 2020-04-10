;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 458ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 458
;; ------------
;; Kepler suggested a simple integration method. To compute an estimate of the
;; area under f between a and b, proceed as follows:
;;
;; 1. divide the interval into half at mid = (a + b) / 2;
;;
;; 2. compute the areas of these two trapezoids:
;;    - [(a,0),(a,f(a)),(mid,0),(mid,f(mid))]
;;    - [(mid,0),(mid,f(mid)),(b,0),(b,f(b))];
;;
;; 3. then add the two areas
;;
;; *Domain Knowledge* Let’s take a look at these trapezoids. Here are the two
;; possible shapes, with minimal annotations to reduce clutter:
;;
;; <ex-458-1.png> <ex-458-2.png>
;;
;; The left shape assumes f(L) > f(R) while the right one shows the case where
;; f(L) < f (R). Despite the asymmetry, it is still possible to calculate the
;; area of these trapezoids with a single formula:
;;
;; [(R-L)*f(R)]+[(1/2)*(R-L)*(f(L)-f(R))]
;;
;; Stop! Convince yourself that this formula adds the area of the triangle to
;; the area of the lower rectangle for the left trapezoid, while it subtracts
;; the triangle from the area of the large rectangle for the right one.
;; 
;; Also show that the above formula is equal to
;;
;; (1/2)*(R-L)*(f(L)+f(R))
;;
;; This is a mathematical validation of the asymmetry of the formula.
;;
;; Design the function integrate-kepler. That is, turn the mathematical
;; knowledge into an ISL+ function. Adapt the test cases from figure 165 to this
;; use. Which of the three tests fails and by how much? 
;; -----------------------------------------------------------------------------



(define eps 0.1)
 
; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds 
 
(check-within (integrate (lambda (x) 20) 12 22) 200 eps)
(check-within (integrate (lambda (x) (* 2 x)) 0 10) 100 eps)

#;; this test fails because the trapezoid does not approximate the curve well
(check-within (integrate (lambda (x) (* 3 (sqr x))) 0 10)
              1000
              eps)
 
(define (integrate f a b)
  (* 1/2 (- b a) (+ (f a) (f b))))

