;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 327ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; ==============================================================================

#|
+-----------------------------------------------------------------------------+
| Exercise 327                                                                |
| ------------                                                                |
| Design the function create-bst-from-list. It consumes a list of numbers     |
| and names and produces a BST by repeatedly applying create-bst. Here is     |
| the signature:                                                              |
|                                                                             |
| ; [List-of [List Number Symbol]] -> BST                                     |
|                                                                             |
| Use the complete function to create a BST from this sample input:           |
| '((99 o)                                                                    |
|   (77 l)                                                                    |
|   (24 i)                                                                    |
|   (10 h)                                                                    |
|   (95 g)                                                                    |
|   (15 d)                                                                    |
|   (89 c)                                                                    |
|   (29 b)                                                                    |
|   (63 a))                                                                   |
|                                                                             |
| The result is tree A in figure 119, if you follow the structural design     |
| recipe. If you use an existing abstraction, you may still get this tree     |
| but you may also get an “inverted” one. Why?                                |
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
(define bst4-10 (make-node 10 'h NONE NONE))
(define bst4-24 (make-node 24 'i NONE NONE))
(define bst4-99 (make-node 99 'o NONE NONE))

; layer 3
(define bst3-15 (make-node 15 'd bst4-10 bst4-24))
(define bst3-77 (make-node 77 'l NONE NONE))
(define bst3-95 (make-node 95 'g NONE bst4-99))

; layer 2
(define bst2-29 (make-node 29 'b bst3-15 NONE))
(define bst2-89 (make-node 89 'c bst3-77 bst3-95))

; layer 1 = Root
(define bst1-63 (make-node 63 'a bst2-29 bst2-89))




;; '(Number Symbol) -> BT
;; converts the number and symbol to a one node binary tree
(define (create-node pair)
  (make-node (first pair) (second pair) NONE NONE))

(define lst'((99 o)                                                                    
             (77 l)                                                                    
             (24 i)                                                                    
             (10 h)                                                                    
             (95 g)                                                                    
             (15 d)                                                                    
             (89 c)                                                                    
             (29 b)                                                                    
             (63 a)))

;; BST Node -> BST
;; adds the node n to the bst
(define (create-bst-2 bst n)
  (cond
    [(no-info? bst) n]
    [else (if (< (node-ssn bst) (node-ssn n))
              (make-node (node-ssn bst) (node-name bst) (node-left bst) (create-bst-2 (node-right bst) n))
              (make-node (node-ssn bst) (node-name bst) (create-bst-2 (node-left bst) n) (node-right bst)))]))

;; [List-of [List Number Symbol]] -> BST
;; use the data in the list to create a bst

(check-expect (create-bst-from-list lst) bst1-63)

(define (create-bst-from-list lst)
  (cond
    [(empty? lst) NONE]
    [else (create-bst-2 (create-bst-from-list (rest lst))
                        (create-node (first lst)))]))