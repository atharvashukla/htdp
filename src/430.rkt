;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 430ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 430
;; ------------
;; Develop a variant of quick-sort< that uses only one comparison function,
;; say, <. Its partitioning step divides the given list alon into a list that
;; contains the items of alon smaller than the pivot and another one with those
;; that are not smaller.
;; 
;; Use local to package up the program as a single function. Abstract this
;; function so that it consumes a list and a comparison function.
;; -----------------------------------------------------------------------------

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct

(check-expect (quick-sort<.v1 '()) '())
(check-expect (quick-sort<.v1 '(8 8 8 8 8 8)) '(8 8 8 8 8 8))
(check-expect (quick-sort<.v1 '(1 4 2 0 8 7 3)) (list 0 1 2 3 4 7 8))
(check-expect (quick-sort<.v1 '(1 3 3 5 2 2 5 2)) (list 1 2 2 2 3 3 5 5))

(define (quick-sort<.v1 alon)
  (local (; [List-of Number] Number -> [List-of Number]
          ; filters lon by applying op to every element and n
          (define (apply-with-num alon n op)
            (filter (λ (x) (op x n)) alon)))
    (cond
      [(empty? alon) '()]
      [else (local ((define pivot (first alon)))
              (append (quick-sort<.v1 (apply-with-num alon pivot <))
                      (apply-with-num alon pivot =)
                      (quick-sort<.v1 (apply-with-num alon pivot >))))])))



;; ----- generalized version with a comparator arg -----

; [List-of X] [X X -> Boolean]-> [List-of X]
; produces a sorted version of l according to comp

(check-expect (quick-sort '()  <) '())
(check-expect (quick-sort '(8 8 8 8 8 8)  <) '(8 8 8 8 8 8))
(check-expect (quick-sort '(1 4 2 0 8 7 3) >) (list 8 7 4 3 2 1 0))
(check-expect (quick-sort '(1 3 3 5 2 2 5 2) >) (list 5 5 3 3 2 2 2 1))
(check-expect (quick-sort '("v" "d" "a")  string<?) '("a" "d" "v"))

(define (quick-sort l c)
  (local (; [List-of X] [X X -> Boolean]-> [List-of X]
          ; produces a sorted version of l according to c
          (define (quick-sort-l l)
            (cond
              [(empty? l) '()]
              [else (local ((define pivot (first l))
                            (define left (quick-sort-l (filter (λ (x) (c x pivot)) l)))
                            (define same (filter (λ (x) (equal? x pivot)) l))
                            (define right (quick-sort-l (filter (λ (x) (and (not (equal? x pivot))
                                                                            (not (c x pivot)))) l))))
                      (append left same right))])))
    (quick-sort-l l)))



