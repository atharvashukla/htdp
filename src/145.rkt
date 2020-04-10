;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 145ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 145.
;; -------------
;; Design the sorted>? predicate, which consumes a NEList-of-temperatures and
;; produces #true if the temperatures are sorted in descending order. That is,
;; if the second is smaller than the first, the third smaller than the second,
;; and so on. Otherwise it produces #false.
;; -----------------------------------------------------------------------------

#| Figure 58: A table for sorted>?
| l                              | (first l) | (rest l)              | (sorted>? (rest l)) | (sorted>? l) |
|--------------------------------+-----------+-----------------------+---------------------+--------------|
| (cons 1 (cons 2 '()))          |         1 | ???                   | #true               | #false       |
| (cons 3 (cons 2 '()))          |         3 | (cons 2 '())          | ???                 | #true        |
| (cons 0 (cons 3 (cons 2 '()))) |         0 | (cons 3 (cons 2 '())) | ???                 | ???          |
|#

; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

;; NEList-of-temperatures -> Boolean
;; is the ne-l sorted in descending order?

(define sorted1 (cons 3 (cons 2 (cons 1 '()))))
(define sorted2 (cons 100 (cons 0 (cons -100 '()))))
(define unsorted1 (cons 1 (cons 2 (cons 1 '()))))
(define unsorted2 (cons 0 (cons 0 (cons -100 '()))))

#;
(define (sorted>? ne-l)
  #true)

(check-expect (sorted>? sorted1) #true)
(check-expect (sorted>? sorted2) #true)
(check-expect (sorted>? unsorted1) #false)
(check-expect (sorted>? unsorted2) #false)

#| Completed table
| l                              | (first l) | (second l) | (rest l)              | (sorted>? (rest l)) | (sorted>? l) |
|--------------------------------+-----------+------------+-----------------------+---------------------+--------------|
| (cons 1 (cons 2 '()))          |         1 |          2 | '()                   | #true               | #false       |
| (cons 3 (cons 2 '()))          |         3 |          2 | (cons 2 '())          | #true               | #true        |
| (cons 0 (cons 3 (cons 2 '()))) |         0 |          3 | (cons 3 (cons 2 '())) | #true               | #false       |
|#

(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (and (> (first ne-l) (second ne-l))
               (sorted>? (rest ne-l)))]))

