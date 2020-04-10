;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 464ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 464
;; ------------
;; Check that the following system of equations
;;
;; 2*x + 2*y + 3*z = 10
;;       3*y + 9*z = 21    (++)
;;     - 3*y - 8*z = -19
;;
;; has the same solution as the one labeled with (image). Again do so by hand
;; and with check-solution from exercise 462. 
;; -----------------------------------------------------------------------------

; A Row is a [List-if Number]
; A Matrix is a [List-if Row]
; constraint all rows in matrix are of the same length

; An SOE is a non-empty Matrix.
; constraint for (list r1 ... rn), (length ri) is (+ n 1)
; interpretation represents a system of linear equations
 
; An Equation is a [List-of Number].
; constraint an Equation contains at least two numbers. 
; interpretation if (list a1 ... an b) is an Equation, 
; a1, ..., an are the left-hand-side variable coefficients 
; and b is the right-hand side
 
; A Solution is a [List-of Number]
 
(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))
 
(define S '(1 1 2)) ; a Solution


; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(check-expect (lhs (first M)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))
 
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(check-expect (rhs (first M)) 10)
(define (rhs e)
  (first (reverse e)))

; SOE Solution -> Boolean
; is sol the solution of soe?

(check-expect (check-solution M S) #true)
(check-expect (check-solution M '(2 2 2)) #false)

(define (check-solution soe sol)
  (equal? (foldr (λ (e a) (cons (plug-in (lhs e) sol) a)) '() soe)
          (map rhs soe)))

; [List-of Number] -> [List-of Number] -> Boolean
; plug in the sol into the lhs and evaluate
; ASSUMPTION. length of sol and lhs are equal

(check-expect (plug-in '(1 2 3) '(-1 1 -1)) -2)

(define (plug-in lhs sol)
  (apply + (map * lhs sol)))


(define M-sub
  (list (list 2 2  3 10)
        (list 0 3 9 21)
        (list 0 -3 -8 -19)))

(check-expect (check-solution M '(1 1 2)) #true)
(check-expect (check-solution M-sub '(1 1 2)) #true)


;; 2*x + 2*y + 3*z = 10
;;       3*y + 9*z = 21    (++)
;;     - 3*y - 8*z = -19
;; 
;; 2*1 + 2*1 + 3*2 = 10
;;       3*1 + 9*2 = 21
;;     - 3*1 - 8*2 = -19
;;
;; 2 + 2 + 6 = 10
;;     3 + 18 = 21
;;    -3 - 16 = -19
;; 
;; 10 = 10
;; 21 = 21
;; -19 = -19