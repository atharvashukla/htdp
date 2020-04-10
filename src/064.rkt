;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 64ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 64.
;; ------------
;; The Manhattan distance of a point to the origin considers a path that follows
;; the rectangular grid of streets found in Manhattan. Here are two examples:
;; 
;;    <manhattan-1>
;;    <manhattan-2>
;;
;; The left one shows a “direct” strategy, going as far left as needed, followed
;; by as many upward steps as needed. In comparison, the right one shows a
;; “random walk” strategy, going some blocks leftward, some upward, and so on
;; until the destination—here, the origin—is reached.
;;
;; Stop! Does it matter which strategy you follow?
;;
;; Design the function manhattan-distance, which measures the Manhattan distance
;; of the given posn to the origin. 
;; -----------------------------------------------------------------------------

;; Both strategies are equivalent. 


; Posn -> Nat
; manhattan distance between p and the origin
#;
(define (manhattan-distance p)
  0)

(check-expect (manhattan-distance (make-posn 1 2)) (+ 1 2))
(check-expect (manhattan-distance (make-posn 0 0)) 0)
(check-expect (manhattan-distance (make-posn 4 5)) (+ 4 5))

#;
(define (manhattan-distance p)
  (... (posn-x p) ... (posn-y p) ...))

(define (manhattan-distance p)
  (+ (posn-x p) (posn-y p)))
