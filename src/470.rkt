;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 470ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 470
;; ------------
;; Define gauss, which combines the triangulate function from exercise 468 and
;; the solve function from exercise 469.
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

(define M ; an SOE 
  (list (list 2 2  3 10) ; an Equation 
        (list 2 5 12 31)
        (list 4 1 -2  1)))
 
(define S '(1 1 2)) ; a Solution

(define m0
  '((2 2 2 6)
    (2 2 4 8)
    (2 2 1 2)))

(define m1
  '((2  3  3 8)
    (2  3 -2 3)
    (4 -2  2 4)))

(define m1-tri
  '((2  3  3   8)
    (  -8 -4 -12)
    (     -5  -5)))

(define m2
  '((2 2  3 10)
    (2 5 12 31)
    (4 1 -2 1)))

(define m2-tri
  '((2 2  3 10)
    (  3  9 21)
    (     1  2)))

(define m3
  '(( 3  9   21)
    (-3 -8  -19)))

(define m3-tri
  '((3  9 21)
    (   1  2)))


; SOE -> Solution
; solution for soe using gaussian elimination

(check-expect (gauss M) S)
(check-expect (gauss m1) '(1 1 1))
(check-expect (gauss m2) '(1 1 2))
(check-expect (gauss m3) '(1 2))

(define (gauss m)
  (solve (triangulate m)))


; SOE -> TM
; triangulates the given system of equations

(check-error (triangulate m0) "so solution")
(check-expect (triangulate m1) m1-tri)
(check-expect (triangulate m2) m2-tri)
(check-expect (triangulate m3) m3-tri)

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


