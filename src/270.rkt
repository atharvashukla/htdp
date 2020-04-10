;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 270ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 270 
;; ------------
;; Use build-list to define a function that
;; 
;; 1. creates the list (list 0 ... (- n 1)) for any natural number n;
;;
;; 2. creates the list (list 1 ... n) for any natural number n;
;; 
;; 3. creates the list (list 1 1/2 ... 1/n) for any natural number n;
;; 
;; 4. creates the list of the first n even numbers; and
;; 
;; 5. creates a diagonal square of 0s and 1s; see exercise 262.
;; 
;; Finally, define tabulate from exercise 250 using build-list.
;; -----------------------------------------------------------------------------

; Nat -> [List-of Nat]
; creates a list from 0 to n-1

(check-expect (zero-to-n 0) '())
(check-expect (zero-to-n 1) '(0))
(check-expect (zero-to-n 7) '(0 1 2 3 4 5 6))

(define (zero-to-n n)
  (build-list n identity))

; Nat -> [List-of Nat]
; creates a list from 1 to n-1

(check-expect (one-to-n 0) '())
(check-expect (one-to-n 1) '(1))
(check-expect (one-to-n 5) '(1 2 3 4 5))

(define (one-to-n n)
  (build-list n add1))

; Nat -> [List-of Rational]
; reciprocates a list from 1 to n-1

(check-expect (enum-recip 0) '())
(check-expect (enum-recip 1) '(1))
(check-expect (enum-recip 4) '(1 1/2 1/3 1/4))

(define (enum-recip n)
  (local (;; Number -> Rational
          ;; reciprocal of num + 1
          (define (recipr num)
            (/ 1 (+ num 1))))
    (build-list n recipr)))


(check-expect (enum-even 1) '(0))
(check-expect (enum-even 2) '(0 2))
(check-expect (enum-even 4) '(0 2 4 6))

(define (enum-even n)
  (local ((define (double-num num)
            (* 2 num)))
    (build-list n double-num)))

; Nat -> [List-of [List-of Nat]]
; creates an identity matrix of dimension n

(check-expect (id-mat 0) '())
(check-expect (id-mat 1) (list (list 1)))
(check-expect (id-mat 2) (list (list 1 0) (list 0 1)))
(check-expect (id-mat 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))

(define (id-mat n)
  (local ((define dimension n)
          ;; Nat -> [List -of Nat]
          ;; creates rows of the identity matrix given a row number
          (define (row-creation n)
            (local (;; storing the row-number as a var
                    (define to-be-declared-1 n)
                    ;; using var to reason about 1s and 0s
                    (define (element-creation n)
                      (if (= n to-be-declared-1) 1 0)))
              ;; creating every element of the row with build-list
              (build-list dimension element-creation)))
          ;; creating n rows using build-list
          (define identity-matrix (build-list n row-creation)))
    identity-matrix))


; Number [Number -> Number] -> [List-of Number]
; tabulates f between n and 0 (incl.) in a list

(check-within (tabulate 2 sin) (list (sin 2) (sin 1) (sin 0)) 0.0001)
(check-within (tabulate 2 sqrt) (list (sqrt 2) (sqrt 1) (sqrt 0)) 0.0001)

(define (tabulate n f)
  (local (; NUmber -> Number
          ; helps building the list from n to 0
          ; (instead of from 0 to n) and applies
          ; f on each #
          (define (helper x)
            (f (- n x))))
    (build-list (+ n 1) helper)))

