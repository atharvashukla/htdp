;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 469ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 469
;; ------------
;; Design the solve function. It consumes triangular SOEs and produces a
;; solution.
;;
;; *Hint* Use structural recursion for the design. Start with the design of a
;; function that solves a single linear equation in n+1 variables, given a
;; solution for the last n variables. In general, this function plugs in the
;; values for the rest of the left-hand side, subtracts the result from the
;; right-hand side, and divides by the first coefficient. Experiment with this
;; suggestion and the above examples.
;;
;; *Challenge* Use an existing abstraction and lambda to design solve. 
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

; A TM is an [NEList-of Equation]
; such that the Equations are of decreasing length: 
;   n + 1, n, n - 1, ..., 2. 
; interpretation represents a triangular matrix

; TM -> Solution
; solution for the triangular matrix t-soe

(check-expect (solve '((1 2))) '(2))
(check-expect
 (solve (list (list 2 2  3 10)
              (list   3  9 21)
              (list      1  2)))
 '(1 1 2))

#;
(define (solve t-soe)
  (cond
    [(empty? t-soe) '()]
    [else (local ((define rst-sol (solve (rest t-soe))))
            (cons (solve-eq (first t-soe) rst-sol) rst-sol))]))

; Challenge (using an existing abstraction)
(define (solve t-soe)
  (foldr (λ (e a) (cons (solve-eq e a) a)) '() t-soe))

; [NEList-of Number] [NEList-of Number] -> Number
; solves the equation e of na vars, assuming the
; values of last n-1 vars are in vl

(check-expect (solve-eq '(2 2 3 10) '(1 2)) 1)
(check-expect (solve-eq '(1 2) '()) 2)

(define (solve-eq e vals)
  (local ((define vars (remove-last (rest e)))
          (define substituted (apply + (map * vars vals))))
    (/ (- (last e) substituted) (first e))))


; [X] [NE-List X] -> [NEList X]
; removes the last element of the ne-list l
(define (remove-last l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (first l) (remove-last (rest l)))]))


; [X] [NE-List X] -> X
; last element of l
(define (last l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (last (rest l))]))


