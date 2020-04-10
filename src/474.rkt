;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 474ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 474
;; ------------
;; Redesign the find-path program as a single function.
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


; Node Node Graph -> [Maybe Path]
; finds a path from origination to destination in G
; if there is no path, the function produces #false
(define (find-path orig dest G)
  (local (; [List-of Node] Node Graph -> [Maybe Path]
          ; finds a path from some node on lo-Os to D
          ; if there is no path, the function produces #false
          (define (find-path/list lo-Os D)
            (cond
              [(empty? lo-Os) #false]
              [else (local ((define candidate
                              (find-path-h (first lo-Os) D)))
                      (cond
                        [(boolean? candidate)
                         (find-path/list (rest lo-Os) D)]
                        [else candidate]))]))
          ; Node Node -> [Maybe Path]
          ; finds a path from origination to destination in G
          ; if there is no path, the function produces #false
          (define (find-path-h origination destination)
            (cond
              [(symbol=? origination destination) (list destination)]
              [else (local ((define next (neighbors origination G))
                            (define candidate
                              (find-path/list next destination)))
                      (cond
                        [(boolean? candidate) #false]
                        [else (cons origination candidate)]))])))
    (find-path-h orig dest)))
 

