;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 395ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 395
;; ------------
;; Design take. It consumes a list l and a natural number n. It produces the
;; first n items from l or all of l if it is too short.
;;
;; Design drop. It consumes a list l and a natural number n. Its result is l
;; with the first n items removed or just ’() if l is too short.
;; -----------------------------------------------------------------------------


; [X] [List-of X] N -> [List-of X]
; list with first n elements from l
#;
(define (take l n)
  '())

(check-expect (take '(1 2 3) 3) '(1 2 3))
(check-expect (take '(1 2 3) 2) '(1 2))
(check-expect (take '(1 2) 4) '(1 2))
(check-expect (take '() 2) '())
(check-expect (take '() 0) '())
(check-expect (take '(1 2 3) 0) '())
#;
(define (take l n)
  (cond
    [(and (= 0 n) (empty? l)) ...]
    [(and (= 0 n) (cons? l)) (... (first l) ... (rest l) ...)]
    [(and (> 0 n) (empty? l)) (... (sub1 n) ...)]
    [(and (> 0 n) (cons? l)) (... (sub1 n) ... (first l) ... (rest l) ...)]))
#;
(define (take l n)
  (cond
    [(and (= n 0) (empty? l)) '()]
    [(and (= n 0) (cons? l)) '()]
    [(and (> n 0) (empty? l)) '()]
    [(and (> n 0) (cons? l)) (cons (first l) (take (rest l) (sub1 n)))]))

(define (take l n)
  (cond
    [(or (= n 0) (empty? l)) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))


; [X] [List-of X] N -> [List-of X]
; drop the first n elements from l
#;
(define (drop l n)
  '())

(check-expect (drop '(1 2 3) 3) '())
(check-expect (drop '(1 2 3) 2) '(3))
(check-expect (drop '(1 2) 4) '())
(check-expect (drop '() 2) '())
(check-expect (drop '() 0) '())
(check-expect (drop '(1 2 3) 0) '(1 2 3))

#;
(define (drop l n)
  (cond
    [(and (= 0 n) (empty? l)) '()]
    [(and (= 0 n) (cons? l)) l]
    [(and (> n 0) (empty? l)) '()]
    [(and (> n 0) (cons? l)) (drop (rest l) (sub1 n))]))

(define (drop l n)
  (cond
    [(or (empty? l) (= 0 n)) l]
    [else (drop (rest l) (sub1 n))]))
