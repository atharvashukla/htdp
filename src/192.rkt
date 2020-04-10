;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 192ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 192
;; ------------
;; Argue why it is acceptable to use last on Polygons. Also argue why you may
;; adapt the template for connect-dots to last:
;;
;;    (define (last p)
;;      (cond
;;        [(empty? (rest p)) (... (first p) ...)]
;;        [else (... (first p) ... (last (rest p)) ...)]))
;;
;; Finally, develop examples for last, turn them into tests, and ensure that the
;; definition of last in figure 73 works on your examples. 
;; -----------------------------------------------------------------------------


; It is acceptable to use last on Polygons becuase the list is never empty
; and we need to connect the last and the first dots.


; we can adapt the template for connect-dots to last because connect-dots
; and Polygon, both are non-empty lists, and last will do similar things in both.
; Just the base case predicate will change (to (empty? (rest p)) when adapting for NELoP.

; NELoP -> Posn
; extracts the last item from p
#;
(define (last p)
  (first p))


#;
(define (last p)
  (cond
    [(empty? (rest p)) (... (first p) ...)]
    [else (... (first p) ... (last (rest p)) ...)]))


(define p1 (make-posn 1 2))
(define p2 (make-posn 2 1))
(define p3 (make-posn 0 0))
(define p4 (make-posn 1 1))

(check-expect (last (list p1 p2 p3 p4)) p4)
(check-expect (last (list p1 p3 p2)) p2)
; the last for NELoP would allow (list p1) as a possible test


; Polygon -> Posn
; extracts the last item from p
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))
