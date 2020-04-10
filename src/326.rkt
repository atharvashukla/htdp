;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 326ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; ==============================================================================

#|
+-----------------------------------------------------------------------------+
| Exercise 326                                                                |
| ------------                                                                |
| Design the function create-bst. It consumes a BST B, a number N, and a      |
| symbol S. It produces a BST that is just like B and that in place of one    |
| NONE subtree contains the node structure                                    |
|                                                                             |
| (make-node N S NONE NONE)                                                   |
|                                                                             |
| Once the design is completed, use the function on tree A from figure 119.   |
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


;; insert 42:
;; new tree 2

;; the new node:
(define bst3-42 (make-node 42 'd NONE NONE))

(define bst2-29-2 (make-node 29 'd2 bst3-15 bst3-42))

;; the new tree root
(define bst1-63-2 (make-node 63 'd1 bst2-29-2 bst2-89))

;; BST Number -> BST
#;
(define (create-bst bst n)
  NONE)

(check-expect (create-bst bst1-63 42) bst1-63-2)


#;; template
(define (bt-template bt n)
  (cond
    [(no-info? bt) ...]
    [else (... (bt-template (node-left bt)) ... (bt-template (node-right bt)) ...)]))

(define (create-bst bst n)
    (cond
      [(no-info? bst) (make-node n 'd NONE NONE)]
      [else (if (< (node-ssn bst) n)
                (make-node (node-ssn bst) (node-name bst) (node-left bst) (create-bst (node-right bst) n))
                (make-node (node-ssn bst) (node-name bst) (create-bst (node-left bst) n) (node-right bst)))]))
 