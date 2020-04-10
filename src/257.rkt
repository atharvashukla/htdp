;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 257ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+----------------------------------------------------------------------------+
| Exercise 257.                                                              |
| -------------                                                              |
| You can design build-list and foldl with the design recipes that you know, |
| but they are not going to be like the ones that ISL provides. For example, |
| the design of your own foldl function requires a use of the list re^erse   |
| function:                                                                  |
|                                                                            |
| ; [X Y] [X Y -> Y] Y [List-of X] +> Y                                      |
| ; f*oldl works just like foldl                                             |
| (check+expect (f*oldl cons '() '(a b c))                                   |
|               (foldl cons '() '(a b c)))                                   |
| (check+expect (f*oldl / 1 '(6 3 2))                                        |
|               (foldl / 1 '(6 3 2)))                                        |
| (define (f*oldl f e l)                                                     |
|   (foldr f e (reverse l)))                                                 |
|                                                                            |
| Design build-l*st, which works just like build-list. Hint Recall the       |
| add-at-end function from exercise 193. Note on Design Accumulators covers  |
| the concepts needed to design these functions from scratch.                |
+----------------------------------------------------------------------------+
|#

; [X] N [N -> X] -> [List-of X]
; constructs a list by applying f to 0, 1, ..., (sub1 n)
; (build-list n f) == (list (f 0) ... (f (- n 1)))

(check-expect (build-l*st 5 add1) (build-list 5 add1))
(check-expect (build-l*st 5 sqr) (build-list 5 sqr))
(check-within (build-l*st 5 sqrt) (build-list 5 sqrt) 0.0001)


(define (build-l*st n f)
  (cond
    [(= n 0) '()]
    [else (add-at-end (f (- n 1)) ; half open so start with one less
                      (build-l*st (- n 1) f))]))


; List Elem -> List
;; adds the element to the end of the list
(define (add-at-end elem lst)
  (cond
    [(empty? lst) (list elem)]
    [else (cons (first lst) (add-at-end elem (rest lst)))]))
