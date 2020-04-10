;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 280ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 280
;; ------------
;; Calculate the result of the following expressions:
;;
;;  1.  ((lambda (x y) (+ x (* x y)))
;;       1 2)
;;      
;;      
;;  2.  ((lambda (x y)
;;         (+ x
;;            (local ((define z (* y y)))
;;              (+ (* 3 z) (/ 1 x)))))
;;       1 2)
;;      
;;      
;;  3.  ((lambda (x y)
;;         (+ x
;;            ((lambda (z)
;;               (+ (* 3 z) (/ 1 z)))
;;             (* y y))))
;;       1 2)
;;
;; Check your results in DrRacket. 
;; -----------------------------------------------------------------------------


(define ex1
  ((lambda (x y) (+ x (* x y)))
   1 2))


(define ex2
  ((lambda (x y)
     (+ x
        (local ((define z (* y y)))
          (+ (* 3 z) (/ 1 x)))))
   1 2))
 

(define ex3
  ((lambda (x y)
     (+ x
        ((lambda (z)
           (+ (* 3 z) (/ 1 z)))
         (* y y))))
   1 2))



(check-expect ex1 3)
(check-expect ex2 14)
(check-expect ex3 13.25)