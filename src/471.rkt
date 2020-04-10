;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 471ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 471
;; ------------
;; Translate one of the above definitions into proper list form using list and
;; proper symbols.
;;
;; The data representation for nodes is straightforward:
;;
;;    ; A Node is a Symbol
;;
;; Formulate a data definition to describe the class of all Graph
;; representations, allowing an arbitrary number of nodes and edges. Only one of
;; the above representations has to belong to Graph.
;;
;; Design the function neighbors. It consumes a Node n and a Graph g and
;; produces the list of immediate neighbors of n in g. 
;; -----------------------------------------------------------------------------

(define sample-graph1
  '((A (B E))
    (B (E F))
    (C (D))
    (D ())
    (E (C F))
    (F (D G))
    (G ())))
(check-expect sample-graph1
(list
 (list 'A (list 'B 'E))
 (list 'B (list 'E 'F))
 (list 'C (list 'D))
 (list 'D '())
 (list 'E (list 'C 'F))
 (list 'F (list 'D 'G))
 (list 'G '())))

(define sample-graph2
  '((A B E)
    (B E F)
    (C D)
    (D)
    (E C F)
    (F D G)
    (G)))

(check-expect sample-graph2
(list
 (list 'A 'B 'E)
 (list 'B 'E 'F)
 (list 'C 'D)
 (list 'D)
 (list 'E 'C 'F)
 (list 'F 'D 'G)
 (list 'G)))


; A Node is a Symbol
; interpretation. representation of a node in a graph

; A NodeNeighbors is a (list Node [List-of Node]]
; interpretation. a node and a list of its neighboring nodes

; A Graph is a [List-of NodeNeighbors]
; intepretation. a graph as a list of nodes and their neighbors

; Node Graph -> [List-of Node]
; immediate neighbors of node n in g

(check-expect (neighbors 'D sample-graph1) '())
(check-expect (neighbors 'F sample-graph1) '(D G))

(define (neighbors n g)
  (second (assoc n g)))