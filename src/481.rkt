;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 481ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 481
;; ------------
;; The tests in figure 175 are awful. No real-world programmer ever spells out
;; all these possible outcomes.

;; One solution is to use property testing again. Design the n-queens-solution?
;; function, which consumes a natural number n and produces a predicate on queen
;; placements that determines whether a given placement is a solution to an n
;; queens puzzle:
;;
;; - A solution for an n queens puzzle must have length n.
;; - A QP on such a list may not threaten any other, distinct QP.
;;
;; Once you have tested this predicate, use it and check-satisfied to formulate
;; the tests for n-queens.
;;
;; An alternative solution is to understand the lists of QPs as sets. If two
;; lists contain the same QPs in different order, they are equivalent as the
;; figure suggests. Hence you could formulate the test for n-queens as
;;
;;    ; [List-of QP] -> Boolean
;;    ; is the result equal [as a set] to one of two lists
;;    (define (is-queens-result? x)
;;      (or (set=? 4QUEEN-SOLUTION-1 x)
;;          (set=? 4QUEEN-SOLUTION-2 x)))
;;
;; Design the function set=?. It consumes two lists and determines whether they
;; contain the same items—regardless of order. 
;; -----------------------------------------------------------------------------


(define QUEENS 8)
; A QP is a structure:
;   (make-posn CI CI)
; A CI is an N in [0,QUEENS).
; interpretation (make-posn r c) denotes the square at 
; the r-th row and c-th column


; N -> [Maybe [List-of QP]]
; finds a solution to the n queens problem 
 
; data example: [List-of QP]
(define 4QUEEN-SOLUTION-2
  (list  (make-posn 0 2) (make-posn 1 0)
         (make-posn 2 3) (make-posn 3 1)))
 

; N -> [Maybe [List-of QP]]
; finds a solution to the n queens problem 
 
(define 0-1 (make-posn 0 1))
(define 1-3 (make-posn 1 3))
(define 2-0 (make-posn 2 0))
(define 3-2 (make-posn 3 2))


; [List-of X] -> [List-of [List-of X]]
; creates a list of all rearrangements of the items in w
; TERMINATION: base case terminates. The call to arrangements in the
; recursive call is on a smaller list (with the item removed from w)
(define (arrangements w)
  (cond
    [(empty? w) '(())]
    [else
     (foldr (lambda (item others)
              (local ((define without-item (arrangements (remove item w)))
                      (define add-item-to-front (map (lambda (a) (cons item a)) without-item)))
                (append add-item-to-front others)))
            '()
            w)]))


; some order of the queens
#;
(check-expect (member? (n-queens 4) (arrangements (list 0-1 1-3 2-0 3-2))) #true)

 
(define (n-queens n)
  #false)


; Board N -> [Maybe [List-of QP]]
; places n queens on board; otherwise, returns #false
(define (place-queens a-board n)
  #false)


; -------------------------------------- Spec

; N -> [[List-of QP]-> Boolean]

(check-expect ((n-queens-solution? 4) 4QUEEN-SOLUTION-2) #true)
(check-expect ((n-queens-solution? 4) (list (make-posn 2 2) 1-3 2-0 3-2)) #false)

(define (n-queens-solution? n)
  (λ (qps-or-false)
    (if (and (<= n 3) (equal? #false qps-or-false))
        #true
        (and (cons? qps-or-false)
             (equal? n (length qps-or-false))
             (not (any-queen-threatening? qps-or-false))))))

; [List-of QP] -> Boolean
; any threatening any other queen in qps
(define (any-queen-threatening? qps)
  (cond
    [(empty? qps) #false]
    [else (or (ormap (λ (x) (threatening? (first qps) x)) (rest qps))
              (any-queen-threatening? (rest qps)))]))

(check-satisfied (n-queens 3) (n-queens-solution? 3))

#;
(check-satisfied (n-queens 4) (n-queens-solution? 4))


; ----------------------------------- Exercise 479: threatening?

; QP QP -> Boolean
; do the two qps threaten each other?

(check-expect (threatening? (make-posn 0 1) (make-posn 3 2)) #false)
(check-expect (threatening? (make-posn 0 1) (make-posn 1 3)) #false)
(check-expect (threatening? (make-posn 3 1) (make-posn 1 2)) #false)

(check-expect (threatening? (make-posn 0 1) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 0 1)) #true)

(check-expect (threatening? (make-posn 1 3) (make-posn 3 1)) #true)
(check-expect (threatening? (make-posn 3 1) (make-posn 1 3)) #true)

(check-expect (threatening? (make-posn 2 0) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 2 0)) #true)

(check-expect (threatening? (make-posn 1 0) (make-posn 3 0)) #true)
(check-expect (threatening? (make-posn 3 0) (make-posn 1 0)) #true)

(define (threatening? qp1 qp2)
  (local ((define r1 (posn-x qp1))
          (define r2 (posn-x qp2))
          (define c1 (posn-y qp1))
          (define c2 (posn-y qp2)))
    (or (= r1 r2)
        (= c1 c2)
        (= (+ c1 r1) (+ c2 r2))
        (= (- c1 r1) (- c2 r2)))))


;; ----------------------------------------------------------------------


(define 4QUEEN-SOLUTION-1
  (list  (make-posn 1 0) (make-posn 0 2)
         (make-posn 3 1) (make-posn 2 3)))


; [List-of QP] -> Boolean
; is the result equal [as a set] to one of two lists
(define (is-queens-result? x)
  (or (set=? 4QUEEN-SOLUTION-1 x)
      (set=? 4QUEEN-SOLUTION-2 x)))


; [X] [List-of X] [List-of X] -> Booelan
; set equality between s1 and s2

(check-expect (set=? '(1 2 3) '(3 2 1)) #true)
(check-expect (set=? '(1) '(1 1)) #true)
(check-expect (set=? '(2) '(2 3)) #false)
(check-expect (set=? '(0 0) '()) #false)
(check-expect (set=? '(2 2 1) '()) #false)
(check-expect (set=? '(2 2 3 6 1) '(6 6 1 2 2 3 6 6)) #true)

(define (set=? s1 s2)
  (local (; [List-of X] [List-of X] -> Boolean 
          ; are all items in list k members of list l
          (define (contains? l k)
            (andmap (lambda (in-k) (member? in-k l)) k)))
    (and (contains? s1 s2)
         (contains? s2 s1))))
