;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 325ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; ==============================================================================

#|
+-----------------------------------------------------------------------------+
| Exercise 325                                                                |
| ------------                                                                |
| Design search-bst. The function consumes a number n and a BST. If the tree  |
| contains a node whose ssn field is n, the function produces the value of    |
| the name field in that node. Otherwise, the function produces NONE. The     |
| function organization must exploit the BST invariant so that the function   |
| performs as few comparisons as necessary.                                   |
|                                                                             |
| See exercise 189 for searching in sorted lists. Compare!                    |
+-----------------------------------------------------------------------------+
|#

(define-struct no-info [])
(define NONE (make-no-info))
 
(define-struct node [ssn name left right])
; A BT (short for BinaryTree) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

(define bt1 NONE)
(define bt2 (make-node 15 'd NONE (make-node 24 'i NONE NONE)))
(define bt3 (make-node 15 'd (make-node 87 'h NONE NONE) NONE))

; --------- tree A ---------

; layer 4
(define bst4-10 (make-node 10 'd4 NONE NONE))
(define bst4-24 (make-node 24 'd4 NONE NONE))
(define bst4-99 (make-node 99 'd4 NONE NONE))

; layer 3
(define bst3-15 (make-node 15 'd3 bst4-10 bst4-24))
(define bst3-77 (make-node 77 'd3 NONE NONE))
(define bst3-95 (make-node 95 'd3 NONE bst4-99))

; layer 2
(define bst2-29 (make-node 29 'd2 bst3-15 NONE))
(define bst2-89 (make-node 89 'd2 bst3-77 bst3-95))

; layer 1 = Root
(define bst1-63 (make-node 63 'd1 bst2-29 bst2-89))


; ---------------------------

;; BST -> {String | NONE}
;; produces the name of node w/ ssn n, otherwise NONE
#;
(define (search-bst bt n)
  NONE)


(check-expect (search-bst bst4-10 10) 'd4)
(check-expect (search-bst bst4-10 13) NONE)
(check-expect (search-bst bst2-89 89) 'd2)
(check-expect (search-bst bst2-89 77) 'd3)
(check-expect (search-bst bst2-89 95) 'd3)
(check-expect (search-bst bst2-89 63) NONE)
(check-expect (search-bst bst1-63 24) 'd4)
(check-expect (search-bst bst1-63 77) 'd3)
(check-expect (search-bst bst1-63 23) NONE)


#;; template
(define (bt-template bt n)
  (cond
    [(no-info? bt) ...]
    [else (... (bt-template (node-left bt)) ... (bt-template (node-right bt)) ...)]))


(define (search-bst bt n)
  (cond
    [(equal? bt NONE) NONE]
    [(= (node-ssn bt) n) (node-name bt)]
    [else (if (< n (node-ssn bt))
              (search-bst (node-left bt) n)
              (search-bst (node-right bt) n))]))