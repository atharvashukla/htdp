;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 186ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 186.
;; ------------
;;
;; Take a second look at Intermezzo 1: Beginning Student Language, the
;; intermezzo that presents BSL and its ways of formulating tests. One of the
;; latter is check-satisfied, which determines whether an expression satisfies a
;; certain property. Use sorted>? from exercise 145 to reformulate the tests for
;; sort> with check-satisfied.
;;
;; Now consider this function definition:
;;
;;    ; List-of-numbers -> List-of-numbers
;;    ; produces a sorted version of l
;;    (define (sort>/bad l)
;;      (list 9 8 7 6 5 4 3 2 1 0))
;;
;; Can you formulate a test case that shows that sort>/bad is not a sorting
;; function? Can you use check-satisfied to formulate this test case?
;;
;; *Notes*
;; (1) What may surprise you here is that we define a function to create a
;; test. In the real world, this step is common, and, on occasion, you really
;; need to design functions for tests—with their own tests and all.
;; (2) Formulating tests with check-satisfied is occasionally easier than using
;; check-expect (or other forms), and it is also a bit more general. When the
;; predicate completely describes the relationship between all possible input
;; and outputs of a function, computer scientists speak of a specification.
;; Specifying with lambda explains how to specify sort> completely.
;;
;; -----------------------------------------------------------------------------



; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0))

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

; --------------- from exercise 145 -------------------
(define sorted1 (cons 3 (cons 2 (cons 1 '()))))
(define sorted2 (cons 100 (cons 0 (cons -100 '()))))
(define unsorted1 (cons 1 (cons 2 (cons 1 '()))))
(define unsorted2 (cons 0 (cons 0 (cons -100 '()))))

; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

;; NEList-of-temperatures -> Boolean
;; is the ne-l sorted in descending order?

#;
(define (sorted>? ne-l)
  #true)

(check-expect (sorted>? '()) #true)
(check-expect (sorted>? sorted1) #true)
(check-expect (sorted>? sorted2) #true)
(check-expect (sorted>? unsorted1) #false)
(check-expect (sorted>? unsorted2) #false)

(define (sorted>? l)
  (cond
    [(or (empty? l) (empty? (rest l))) #true]
    [else (and (> (first l) (second l))
               (sorted>? (rest l)))]))

; -----------------------------------------------------


(check-satisfied (sort> '(1 2 3)) sorted>?)
(check-satisfied (sort> '(1 3)) sorted>?)
(check-satisfied (sort>/bad '(1 2 3)) sorted>?)
