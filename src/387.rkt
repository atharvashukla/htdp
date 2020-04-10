;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 387ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 387
;; ------------
;; Design cross. The function consumes a list of symbols and a list of numbers
;; and produces all possible ordered pairs of symbols and numbers. That is, when
;; given '(a b c) and '(1 2), the expected result is
;; '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)).
;; -----------------------------------------------------------------------------

; [List-of Symbol] [List-of Number] -> [List-of (list Symbol Number)]
; creates all possible ordered pairs of syms and nums in los and lon
#;
(define (cross los lon)
  '())

(check-expect (cross '() '()) '())
(check-expect (cross '() '(1 2)) '())
(check-expect (cross '(a b c) '()) '())
(check-expect (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))


#;
(define (cross los lon)
  (cond
    [(empty? los) ...]
    [else (... (first los) ... (cross (rest los) lon))]))

(define (cross los lon)
  (cond
    [(empty? los) '()]
    [else (append (cross-with-sym (first los) lon) (cross (rest los) lon))]))


; Symbol [List-of Number] -> [List-of (list Symbol Number)]
; pairs each number in lon with sym
#;
(define (cross-with-sym sym lon)
  '())

(check-expect (cross-with-sym 's '()) '())
(check-expect (cross-with-sym 's '(1 2 3)) '((s 1) (s 2) (s 3)))

#;
(define (cross-with-sym sym lon)
  (cond
    [(empty? lon) ...]
    [else (... (first lon) ... (cross-with-sym sym (rest lon)) ...)]))


(define (cross-with-sym sym lon)
  (cond
    [(empty? lon) '()]
    [else (cons (list sym (first lon)) (cross-with-sym sym (rest lon)))]))