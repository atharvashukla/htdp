;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 484ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 484
;; ------------
;; While a list sorted in descending order is clearly the worst possible input
;; for inf, the analysis of inf’s abstract running time explains why the rewrite
;; of inf with local reduces the running time. For convenience, we replicate
;; this version here:
;;
;;    (define (infL l)
;;      (cond
;;        [(empty? (rest l)) (first l)]
;;        [else (local ((define s (infL (rest l))))
;;                (if (< (first l) s) (first l) s))]))
;; 
;; Hand-evaluate (infL (list 3 2 1 0)). Then argue that infL uses on the “order
;; of n steps” in the best and the worst case. You may now wish to revisit
;; exercise 261, which asks you to explore a similar problem. 
;; -----------------------------------------------------------------------------



(define (infL l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (local ((define s (infL (rest l))))
            (if (< (first l) s) (first l) s))]))

(infL (list 3 2 1 0))

; ==
#;
(cond
  [(empty? (rest (list 3 2 1 0))) (first (list 3 2 1 0))]
  [else (local ((define s (infL (rest (list 3 2 1 0)))))
          (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))])

; ==
#;
(cond
  [#false (first (list 3 2 1 0))]
  [else (local ((define s (infL (rest (list 3 2 1 0)))))
          (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))])

; ==
#;
(local ((define s (infL (rest (list 3 2 1 0)))))
  (if (< (first (list 3 2 1 0)) s) (first (list 3 2 1 0)) s))

; ==

#;
(define s_0 (infL (rest (list 3 2 1 0))))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;
(define s_0 (infL (list 2 1 0)))
#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;
(define s_0
  (cond
    [(empty? (rest (list 2 1 0))) (first (list 2 1 0))]
    [else (local ((define s (infL (rest (list 2 1 0)))))
            (if (< (first (list 2 1 0)) s) (first (list 2 1 0)) s))]))
#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;
(define s_0
  (local ((define s (infL (rest (list 2 1 0)))))
    (if (< (first (list 2 1 0)) s) (first (list 2 1 0)) s)))
#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;(define s_1 (infL (rest (list 2 1 0))))

#;(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==


#;(define s_1 (infL (list 1 0)))

#;(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;(define s_1
    (cond
      [(empty? (rest (list 1 0))) (first (list 1 0))]
      [else (local ((define s (infL (rest (list 1 0)))))
              (if (< (first (list 1 0)) s) (first (list 1 0)) s))]))

#;(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)


; ==

#;(define s_1
    (cond
      [#false (first (list 1 0))]
      [else (local ((define s (infL (rest (list 1 0)))))
              (if (< (first (list 1 0)) s) (first (list 1 0)) s))]))

#;(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)



; ==


#;
(define s_1
  (local ((define s (infL (rest (list 1 0)))))
    (if (< (first (list 1 0)) s) (first (list 1 0)) s)))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))
#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;
(define s_2 (infL (rest (list 1 0))))

#;
(define s_1 (if (< (first (list 1 0)) s_2) (first (list 1 0)) s_2))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)


; ==

#;
(define s_2 (infL (list 0)))

#;
(define s_1 (if (< (first (list 1 0)) s_2) (first (list 1 0)) s_2))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)


; ==

#;
(define s_2
  (cond
    [(empty? (rest (list 0))) (first (list 0))]
    [else (local ((define s (infL (rest (list 0)))))
            (if (< (first (list 0)) s) (first (list 0)) s))]))
#;
(define s_1 (if (< (first (list 1 0)) s_2) (first (list 1 0)) s_2))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==


#;
(define s_2
  (cond
    [#true (first (list 0))]
    [else (local ((define s (infL (rest (list 0)))))
            (if (< (first (list 0)) s) (first (list 0)) s))]))
#;
(define s_1 (if (< (first (list 1 0)) s_2) (first (list 1 0)) s_2))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;
(define s_2 0)

#;
(define s_1 (if (< (first (list 1 0)) s_2) (first (list 1 0)) s_2))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==


#;
(define s_2 0)

#;
(define s_1 (if (< (first (list 1 0)) s_2) (first (list 1 0)) s_2))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;
(define s_2 0)

#;
(define s_1 (if (< 1 s_2) 1 s_2))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)


; ==

#;
(define s_2 0)

#;
(define s_1 (if (< 1 0) 1 0))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==


#;
(define s_2 0)

#;
(define s_1 (if #false 1 0))

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==

#;
(define s_2 0)

#;
(define s_1 0)

#;
(define s_0 (if (< (first (list 2 1 0)) s_1) (first (list 2 1 0)) s_1))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==


#;
(define s_2 0)

#;
(define s_1 0)

#;
(define s_0 (if (< 2 0) 2 0))

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==


#;
(define s_2 0)

#;
(define s_1 0)

#;
(define s_0 0)

#;
(if (< (first (list 3 2 1 0)) s_0) (first (list 3 2 1 0)) s_0)

; ==


#;
(define s_2 0)

#;
(define s_1 0)

#;
(define s_0 0)

#;
(if (< 3 0) 3 0)




(define s_2 0)
(define s_1 0)
(define s_0 0)
0




; Note that there is one expansion of a local leading to one definition
; per element in the list. One recursive call per step with constant amount
; of work in each body. Therefore it's on the order of n.