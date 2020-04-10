;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 324ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; ==============================================================================

#|
+-----------------------------------------------------------------------------+
| Exercise 324                                                                |
| ------------                                                                |
| Design the function inorder. It consumes a binary tree and produces the     |
| sequence of all the ssn numbers in the tree as they show up from left to    |
| right when looking at a tree drawing.                                       |
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


; --------- tree B ---------

; layer 4
(define bt4-87 (make-node 87 'd4 NONE NONE))
(define bt4-24 (make-node 24 'd4 NONE NONE))
(define bt4-99 (make-node 99 'd4 NONE NONE))

; layer 3
(define bt3-15 (make-node 15 'd3 bt4-87 bt4-24))
(define bt3-33 (make-node 33 'd3 NONE NONE))
(define bt3-95 (make-node 95 'd3 NONE bt4-99))

; layer 2
(define bt2-29 (make-node 29 'd2 bt3-15 NONE))
(define bt2-89 (make-node 89 'd2 bt3-33 bt3-95))

; layer 1 = Root
(define bt1-63 (make-node 63 'd1 bt2-29 bt2-89))



;; BT -> LON
;; ssn of nodes from left to right in BS
#;
(define (inorder bt)
  '())

(check-expect (inorder bst1-63) '(10 15 24 29 63 77 89 95 99))
(check-expect (inorder bt1-63) '(87 15 24 29 63 33 89 95 99))


#;; template
(define (bt-template bt)
  (cond
    [(no-info? bt) ...]
    [else (... (bt-template (node-left bt)) ... (bt-template (node-right bt)) ...)]))


(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else (append (inorder (node-left bt)) (list  (node-ssn bt)) (inorder (node-right bt)))]))