;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 390ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 390
;; ------------
;; Design the function tree-pick. The function consumes a tree of symbols and a
;; list of directions:
;;
;;    (define-struct branch [left right])
;;     
;;    ; A TOS is one of:
;;    ; – Symbol
;;    ; – (make-branch TOS TOS)
;;     
;;    ; A Direction is one of:
;;    ; – 'left
;;    ; – 'right
;;     
;;    ; A list of Directions is also called a path. 
;;
;; Clearly a Direction tells the function whether to choose the left or the
;; right branch in a nonsymbolic tree. What is the result of the tree-pick
;; function? Don’t forget to formulate a full signature. The function signals an
;; error when given a symbol and a non-empty path. 
;; -----------------------------------------------------------------------------


(define-struct branch [left right])
 
; A TOS is one of:
; – Symbol
; – (make-branch TOS TOS)
 
; A Direction is one of:
; – 'left
; – 'right
 
; A list of Directions is also called a path.


(define t1 (make-branch 'a 'e))
(define t2 (make-branch 'i 'o))
(define t3 (make-branch t1 t2))

(define t9 (make-branch 'z 'y))
(define t8 (make-branch 'x 'w))
(define t7 (make-branch t9 t8))

(define t5 (make-branch t3 t7))



; TOS [List-of Direction] -> Symbol
; ASSUMPTION: length of lodir is the same as the depth of the tree
#;
(define (tree-pick tree lodir)
  's)


(check-expect (tree-pick t5 '(left left left)) 'a)
(check-expect (tree-pick t5 '(left right right)) 'o)
(check-error (tree-pick t5 '(left left)) "the directions exhausted")
(check-error (tree-pick t5 '(left right right 'left)) "the tree was too small")

#;
(define (tree-pick tree lodir)
  (cond
    [(and (empty? lodir) (symbol? tree)) ...]
    [(and (empty? lodir) (branch? tree)) ...]
    [(and (cons? lodir) (symbol? tree)) ...]
    [(and (cons? lodir) (branch? tree)) ...]))

#;
(define (tree-pick tree lodir)
  (cond
    [(and (empty? lodir) (symbol? tree)) ...]
    [(and (empty? lodir) (branch? tree)) (... (branch-left tree) ... (branch-right tree) ...)]
    [(and (cons? lodir) (symbol? tree))  (... (rest lodir) ...)]
    [(and (cons? lodir) (branch? tree))  (... ... (first lodir) ... (rest lodir) ...
                                              ... (branch-left tree) ... (branch-right tree) ...)]))

(define (tree-pick tree lodir)
  (cond
    [(and (empty? lodir) (symbol? tree)) tree] ; produce the symbol
    [(and (empty? lodir) (branch? tree)) (error "the directions exhausted")]
    [(and (cons? lodir) (symbol? tree))  (error "the tree was too small")]
    [(and (cons? lodir) (branch? tree))  (tree-pick (if (equal? 'left (first lodir))
                                                        (branch-left tree)
                                                        (branch-right tree))
                                                    (rest lodir))]))



