;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 435ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 435
;; ------------
;; When you worked on exercise 430 or exercise 428, you may have produced
;; looping solutions. Similarly, exercise 434 actually reveals how brittle the
;; termination argument is for quick-sort<. In all cases, the argument relies on
;; the idea that smallers and largers produce lists that are maximally as long
;; as the given list, and on our understanding that neither includes the given
;; pivot in the result.
;;
;; Based on this explanation, modify the definition of quick-sort< so that both
;; functions receive lists that are shorter than the given one. 
;; -----------------------------------------------------------------------------


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
                            (define left (quick-sort-l (filter (λ (x) (c x pivot)) (rest l))))
                            (define same (filter (λ (x) (equal? x pivot)) (rest l)))
                            (define right (quick-sort-l (filter (λ (x) (and (not (equal? x pivot))
                                                                            (not (c x pivot)))) (rest l)))))
                      (append left (cons pivot same) right))])))
    (quick-sort-l l)))

; Changed all list args to filters from l to (rest l)