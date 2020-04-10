;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 451ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 451
;; ------------
;; A table is a structure of two fields: the natural number VL and a function
;; array, which consumes natural numbers and, for those between 0 and VL
;; (exclusive), produces answers:
;;
;;    (define-struct table [length array])
;;    ; A Table is a structure:
;;    ;   (make-table N [N -> Number])
;;
;; Since this data structure is somewhat unusual, it is critical to illustrate
;; it with examples:
;;
;;    (define table1 (make-table 3 (lambda (i) i)))
;;     
;;    ; N -> Number
;;    (define (a2 i)
;;      (if (= i 0)
;;          pi
;;          (error "table2 is not defined for i =!= 0")))
;;     
;;    (define table2 (make-table 1 a2))
;;
;; Here table1’s array function is defined for more inputs than its length field
;; allows; table2 is defined for just one input, namely 0. Finally, we also
;; define a useful function for looking up values in tables:
;;
;;    ; Table N -> Number
;;    ; looks up the ith value in array of t
;;    (define (table-ref t i)
;;      ((table-array t) i))
;;
;; The root of a table t is a number in (table-array t) that is close to 0. A
;; root index is a natural number i such that (table-ref t i) is a root of table
;; t. A table t is monotonically increasing if (table-ref t 0) is less than
;; (table-ref t 1), (table-ref t 1) is less than (table-ref t 2), and so on.
;;
;; Design find-linear. The function consumes a monotonically increasing table
;; and finds the smallest index for a root of the table. Use the structural
;; recipe for N, proceeding from 0 through 1, 2, and so on to the array-length
;; of the given table. This kind of root-finding process is often called a
;; linear search.
;;
;; Design find-binary, which also finds the smallest index for the root of a
;; monotonically increasing table but uses generative recursion to do so. Like
;; ordinary binary search, the algorithm narrows an interval down to the
;; smallest possible size and then chooses the index. Don’t forget to formulate
;; a termination argument.
;;
;; Hint The key problem is that a table index is a natural number, not a plain
;; number. Hence the interval boundary arguments for find must be natural
;; numbers. Consider how this observation changes (1) the nature of trivially
;; solvable problem instances, (2) the midpoint computation, (3) and the
;; decision as to which interval to generate next. To make this concrete,
;; imagine a table with 1024 slots and the root at 1023. How many calls to find
;; are needed in find-linear and find-binary, respectively? 
;;
;; -----------------------------------------------------------------------------


; ----- Data Definition -----

(define-struct table [length array])
; A Table is a structure:
;   (make-table N [N -> Number])

; ----- Examples -----

(define table1 (make-table 3 (lambda (i) i)))
 
; N -> Number
(define (a2 i)
  (if (= i 0)
      pi
      (error "table2 is not defined for i =!= 0")))
 
(define table2 (make-table 1 a2))

(define table3 (make-table 8 (λ (n) (list-ref '(-102 -34 -2 0 1 45 77 90) n))))

; ---

; Table N -> Number
; looks up the ith value in array of t

(check-expect (table-ref table1 2) 2)
(check-within (table-ref table2 0) pi 0.001)

(define (table-ref t i)
  ((table-array t) i))

; ---


; Table -> N
; root index of t using linear search

(check-expect (find-linear table1) 0)
(check-error (find-linear table2) "root doesn't exist")
(check-expect (find-linear table3) 3)

(define (find-linear t)
  (local ((define last-index (sub1 (table-length t)))
          ; N -> N
          ; finds the nth index such that (table-ref t n) is 0
          (define (find-linear-n n)
            (cond
              [(= n last-index) (if (equal? (table-ref t 0) 0)
                                    last-index
                                    (error "root doesn't exist"))]
              [else (if (equal? (table-ref t n) 0)
                        n
                        (find-linear-n (add1 n)))])))
    (find-linear-n 0)))


; Table -> N
; root index of t using binary-search

(check-expect (find-binary table1) 0)
(check-error (find-binary table2) "root doesn't exist")
(check-expect (find-binary table3) 3)

(define (find-binary t)
  (local ((define last-index (sub1 (table-length t)))

          (define (l-or-r l r)
            (cond [(equal? (table-ref t l) 0) l]
                  [(equal? (table-ref t r) 0) r]
                  [else (error "root doesn't exist")]))
          
          (define (find-binary-h l r)
            (cond
              [(<= (- r l) 1) (l-or-r l r)]
              [else (local ((define m (floor (/ (+ l r) 2))))
                      (if (<= (table-ref t l) 0 (table-ref t m))
                          (find-binary-h l m)
                          (find-binary-h m r)))])))
    (find-binary-h 0 last-index)))


; How many calls to find are needed in find-linear and find-binary, respectively?
; find-linear: 1023 calls
; find-binary log_[2][1024] = 10 calls


