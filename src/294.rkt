;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 294ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 294
;; ------------
;; Develop is-index?, a specification for index:
;;
;;    ; X [List-of X] -> [Maybe N]
;;    ; determine the index of the first occurrence
;;    ; of x in l, #false otherwise
;;    (define (index x l)
;;      (cond
;;        [(empty? l) #false]
;;        [else (if (equal? (first l) x)
;;                  0
;;                  (local ((define i (index x (rest l))))
;;                    (if (boolean? i) i (+ i 1))))]))
;;
;; Use is-index? to formulate a check-satisfied test for index.
;; -----------------------------------------------------------------------------


; X [List-of X] -> [Maybe N]
; determine the index of the first occurrence
; of x in l, #false otherwise
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

(check-satisfied (index 'x '(q e x e w)) (is-index? 'x '(q e x e w)))
(check-satisfied (index 'x '(q e w)) (is-index? 'x '(q e w)))

(define (is-index? x l)
  (λ (num-or-f)
    (if (number? num-or-f)
        (<= 0 num-or-f (sub1 (length l))) 
        (not (member? x l)))))