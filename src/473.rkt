;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 473ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 473
;; ------------
;; Test find-path on 'B, 'C, and the graph in figure 170. Also use
;; test-on-all-nodes from exercise 472 on this graph. 
;; -----------------------------------------------------------------------------

; A Node is a Symbol
; interpretation. representation of a node in a graph

; A NodeNeighbors is a (list Node [List-of Node]]
; interpretation. a node and a list of its neighboring nodes

; A Graph is a [List-of NodeNeighbors]
; intepretation. a graph as a list of nodes and their neighbors

(define sample-graph
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

(define sample-graph-cyclic
  '((A (B E))
    (B (E F))
    (C (D B))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))

; Node Graph -> [List-of Node]
; immediate neighbors of node n in g

(check-expect (neighbors 'D sample-graph) '())
(check-expect (neighbors 'F sample-graph) '(D G))

(define (neighbors n g)
  (second (assoc n g)))

; A Path is a [List-of Node].
; interpretation The list of nodes specifies a sequence
; of immediate neighbors that leads from the first 
; Node on the list to the last one. 
 
; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
 
(check-expect (find-path 'C 'D sample-graph)
              '(C D))
(check-member-of (find-path 'E 'D sample-graph)
                 '(E F D) '(E C D))
(check-expect (find-path 'C 'G sample-graph)
              #false)
 
#;
(define (find-path origination destination G)
  #false)

; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-originations to
; destination; otherwise, it produces #false
#;
(define (find-path/list lo-originations destination G)
  #false)

#;
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination)
     (list destination)]
    [else
     (... origination ...
      ...(find-path/list (neighbors origination G)
                         destination G) ...)]))

#;
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination)
     (list destination)]
    [else
     (local ((define next (neighbors origination G))
             (define candidate
               (find-path/list next destination G)))
       (cond
         [(boolean? candidate) ...]
         [(cons? candidate) ...]))]))

; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define next (neighbors origination G))
                  (define candidate
                    (find-path/list next destination G)))
            (cond
              [(boolean? candidate) #false]
              [else (cons origination candidate)]))]))
 
; [List-of Node] Node Graph -> [Maybe Path]
; finds a path from some node on lo-Os to D
; if there is no path, the function produces #false
(define (find-path/list lo-Os D G)
  (cond
    [(empty? lo-Os) #false]
    [else (local ((define candidate
                    (find-path (first lo-Os) D G)))
            (cond
              [(boolean? candidate)
               (find-path/list (rest lo-Os) D G)]
              [else candidate]))]))


; [X] [List-of X] -> [List-of [List-of X]]
; all  possible pairs in l

(check-expect (all-pairs '()) '())
(check-expect (all-pairs '(a)) '())
(check-expect (all-pairs '(a b)) '((a b)))
(check-expect (all-pairs '(a b c d e))
              '((a b) (a c) (a d) (a e)
                      (b c) (b d) (b e)
                      (c d) (c e)
                      (d e)))

(define (all-pairs l)
  (cond
    [(empty? l) '()]
    [else (append (map (λ (x) (list (first l) x)) (rest l))
                  (all-pairs (rest l)))]))

; Graph -> Boolean
; do any two nodes in g have a path?

(check-expect (test-on-all-nodes sample-graph) #true)
(check-expect (test-on-all-nodes '((A ()) (B ()) (C ()) (D ()))) #false)

(define (test-on-all-nodes g)
  (local ((define possible-node-pairs (all-pairs (map first g))))
    (ormap (λ (p) (list? (find-path (first p) (second p) g)))
           possible-node-pairs)))


; -------------------------------------------------- This Exercise:

(check-expect (find-path 'B 'C sample-graph-cyclic) (list 'B 'E 'C))

(test-on-all-nodes sample-graph-cyclic)
; terminates. But not all possible graphs can be computed
; ormap inherits its laziness from or, so once it finds a #true,
; it short circuits. if we simply mapped find-path on all-pairs of
; sample-graph-cyclic, it would not terminate.


