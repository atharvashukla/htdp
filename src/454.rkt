;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 454ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 454
;; ------------
;; Design create-matrix. The function consumes a number n and a list of n^2
;; numbers. It produces an image matrix, for example:
;;
;;    (check-expect
;;      (create-matrix 2 (list 1 2 3 4))
;;      (list (list 1 2)
;;            (list 3 4)))
;;
;; Make up a second example. 
;; -----------------------------------------------------------------------------


; N [List-of N] -> [List-of [List-of N]]
; creates a matric from l of size n
; ASSUMPTION l has n^2 numbers
#;
(define (create-matrix n l)
'())

(check-expect (create-matrix 0 '()) '())

(check-expect (create-matrix 1 (list 1))
              (list (list 1)))
 
(check-expect (create-matrix 2 (list 1 2 3 4))
              (list (list 1 2)
                    (list 3 4)))

(check-expect (create-matrix 3 (build-list 9 identity))
              (list (list 0 1 2)
                    (list 3 4 5)
                    (list 6 7 8)))


(define (create-matrix n l)
  (cond
    [(empty? l) '()]
    [else (cons (get-first-n n l) (create-matrix n (remove-first-n n l)))]))


;; ---------- Generic helpers ----------


; [X] N [List-of X] -> [List-of X]
; a list of first n elements from l
; ASSUMPTION: the list has at least n elements

(check-expect (get-first-n 0 '()) '())
(check-expect (get-first-n 0 '(1 2 3)) '())
(check-expect (get-first-n 1 '(1 2 3)) '(1))
(check-expect (get-first-n 2 '(1 2 3)) '(1 2))
(check-expect (get-first-n 3 '(1 2 3)) '(1 2 3))

(define (get-first-n n l)
  (cond
    [(= n 0) '()]
    [else (cons (first l) (get-first-n (sub1 n) (rest l)))]))

; [X] N [List-of X] -> [List-of X]
; list l with first n elements removed
; ASSUMPTION: the list has at least n elements

(check-expect (remove-first-n 0 '()) '())
(check-expect (remove-first-n 1 '(1 2 3)) '(2 3))
(check-expect (remove-first-n 2 '(1 2 3)) '(3))
(check-expect (remove-first-n 3 '(1 2 3)) '())

(define (remove-first-n n l)
  (cond
    [(= n 0) l]
    [else (remove-first-n (sub1 n) (rest l))]))
