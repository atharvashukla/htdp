;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 323ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; ==============================================================================

#|
+-----------------------------------------------------------------------------+
| Exercise 323                                                                |
| ------------                                                                |
| Design search-bt. The function consumes a number n and a BT. If the tree    |
| contains a node structure whose ssn field is n, the function produces the   |
| value of the name field in that node. Otherwise, the function produces      |
| #false.                                                                     |
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

; ---------- tree A ----------

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


; ---------- tree B ----------

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

; layer 1 = root
(define bt1-63 (make-node 63 'd1 bt2-29 bt2-89))


; ==========



; ---------- TEST ----------

; tree A (bst) tests

(check-expect (contains-bt? bst4-10 10) #true)
(check-expect (contains-bt? bst4-10 13) #false)

(check-expect (contains-bt? bst2-89 89) #true)
(check-expect (contains-bt? bst2-89 77) #true)
(check-expect (contains-bt? bst2-89 95) #true)
(check-expect (contains-bt? bst2-89 63) #false)

(check-expect (contains-bt? bst1-63 24) #true)
(check-expect (contains-bt? bst1-63 77) #true)
(check-expect (contains-bt? bst1-63 23) #false)

; tree B (bt) tests

(check-expect (contains-bt? bt4-87 87) #true)
(check-expect (contains-bt? bt4-87 13) #false)

(check-expect (contains-bt? bt2-89 89) #true)
(check-expect (contains-bt? bt2-89 33) #true)
(check-expect (contains-bt? bt2-89 95) #true)
(check-expect (contains-bt? bt2-89 63) #false)

(check-expect (contains-bt? bt1-63 24) #true)
(check-expect (contains-bt? bt1-63 33) #true)
(check-expect (contains-bt? bt1-63 23) #false)

; --------------------------

;; BT Number -> Boolean
;; does num occur as an ssn in bt?

#;; stub
(define (contains-bt? bt num)
  #true)

#;; template
(define (bt-template bt)
  (cond
    [(no-info? bt) ...]
    [else (... (bt-template (node-left bt)) ... (bt-template (node-right bt)) ...)]))


(define (contains-bt? bt num)
  (cond
    [(no-info? bt) #false]
    [else (or (= (node-ssn bt) num) ;; check the ssn of this node
              (contains-bt? (node-left bt) num) ; recur on the left tree
              (contains-bt? (node-right bt) num))])) ; recur on the right tree

; ==========


; ---------- TEST ----------

; tree A (bst) tests

(check-expect (search-bt bst4-10 10) 'd4)
(check-expect (search-bt bst4-10 13) #false)

(check-expect (search-bt bst2-89 89) 'd2)
(check-expect (search-bt bst2-89 77) 'd3)
(check-expect (search-bt bst2-89 95) 'd3)
(check-expect (search-bt bst2-89 63) #false)

(check-expect (search-bt bst1-63 24) 'd4)
(check-expect (search-bt bst1-63 77) 'd3)
(check-expect (search-bt bst1-63 63) 'd1)
(check-expect (search-bt bst1-63 23) #false)

; tree B (bt) tests

(check-expect (search-bt bt4-87 87) 'd4)
(check-expect (search-bt bt4-87 13) #false)

(check-expect (search-bt bt2-89 89) 'd2)
(check-expect (search-bt bt2-89 33) 'd3)
(check-expect (search-bt bt2-89 95) 'd3)
(check-expect (search-bt bt2-89 63) #false)

(check-expect (search-bt bt1-63 24) 'd4)
(check-expect (search-bt bt1-63 33) 'd3)
(check-expect (search-bt bt1-63 63) 'd1)
(check-expect (search-bt bt1-63 23) #false)

; --------------------------

;; BT Number -> {String | False}
;; does num occur as an ssn in bt?
;; name if yes, #false if no.
#;; stub
(define (search-bt bt num)
  #true)

#;; template
(define (bt-template bt)
  (cond
    [(no-info? bt) ...]
    [else (... (bt-template (node-left bt)) ... (bt-template (node-right bt)) ...)]))


(define (search-bt bt num)
  (cond
    [(not (contains-bt? bt num)) #f]
    [(= (node-ssn bt) num) (node-name bt)]
    [else (if (contains-bt? (node-left bt) num)
              (search-bt (node-left bt) num)
              (search-bt (node-right bt) num))]))
