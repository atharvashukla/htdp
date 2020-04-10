;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 293ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 293
;; ------------
;; Develop found?, a specification for the find function:
;; 
;;    ; X [List-of X] -> [Maybe [List-of X]]
;;    ; returns the first sublist of l that starts
;;    ; with x, #false otherwise
;;    (define (find x l)
;;      (cond
;;        [(empty? l) #false]
;;        [else
;;         (if (equal? (first l) x) l (find x (rest l)))]))
;;
;; Use found? to formulate a check-satisfied test for find. 
;; -----------------------------------------------------------------------------


; X [List-of X] -> [Maybe [List-of X]]
; returns the first sublist of l that starts
; with x, #false otherwise
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))


(define (found? x l)
  (λ (x-or-f)
     (if (list? x-or-f)
         (equal? (first x-or-f) x)
         (andmap (λ (i) (not (equal? x i))) l))))

(check-satisfied (find 3 '(1 2 3 4)) (found? 3 '(1 2 3 4)))
(check-satisfied (find 3 '()) (found? 3 '()))