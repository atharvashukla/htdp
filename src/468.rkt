;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 468ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 468
;; ------------
;; Modify triangulate from exercise 467 so that it signals an error if it
;; encounters an SOE whose leading coefficients are all 0. 
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

(define m0
  '((2 2 2 6)
    (2 2 4 8)
    (2 2 1 2)))

(define m1
  '((2  3  3 8)
    (2  3 -2 3)
    (4 -2  2 4)))

(define m1-sol
  '((2  3  3   8)
    (  -8 -4 -12)
    (     -5  -5)))

(define m2
  '((2 2  3 10)
    (2 5 12 31)
    (4 1 -2 1)))

(define m2-sol
  '((2 2  3 10)
    (  3  9 21)
    (     1  2)))

(define m3
  '(( 3  9   21)
    (-3 -8  -19)))

(define m3-sol
  '((3  9 21)
    (   1  2)))

; SOE -> TM
; triangulates the given system of equations

(check-error (triangulate m0) "so solution")
(check-expect (triangulate m1) m1-sol)
(check-expect (triangulate m2) m2-sol)
(check-expect (triangulate m3) m3-sol)

(define (triangulate m)
  (local ((define (triangulate-h M)
            (cond [(<= (length (first M)) 2) M]
                  [else (local ((define mat (if (= (first (first M)) 0) (rotate M) M)))
                          (cons (first mat) (triangulate (map-subtract mat))))])))
    (if (andmap zero? (map first m)) (error "so solution") (triangulate-h m))))

; SOE -> SOE
; subtracts first eq from all others
(define (map-subtract m)
  (local ((define f (first m))
          (define r (rest m)))
    (map (λ (x) (subtract f x)) r)))

; Equation Equation -> Equation
; subtracts a multiple of e2 from e1 so e1 has
; 0 in the first position. returns the rest of the list of e2

(check-expect (subtract '(2 3 9) '(4 16 27))  '(10 9))
(check-expect (subtract '(2 3 9) '(-4 16 27)) '(22 45))
(check-expect (subtract '(3 3 6) '(4 24 21))  '(20 13))

(define (subtract e1 e2)
  (local ((define c-e1 (first e1))
          (define c-e2 (first e2))
          (define e-to-subtract (map (λ (c) (* c (/ c-e2 c-e1))) e1))
          (define new-e2 (map - e2 e-to-subtract)))
    (rest new-e2)))


; [NEList-of X] -> [NEList-of X]
; rotates the list counter-clockwise

(check-expect (rotate '(a b c)) '(b c a))

(define (rotate l)
  (append (rest l) (list (first l))))
