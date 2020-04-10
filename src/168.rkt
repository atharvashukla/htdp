;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 168ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 168
;; ------------
;; Design the function translate. It consumes and produces lists of Posns. For
;; each (make-posn x y) in the former, the latter contains
;; (make-posn x (+ y 1)). We borrow the word “translate” from geometry, where
;; the movement of a point by a constant distance along a straight line is
;; called a translation.
;; -----------------------------------------------------------------------------

; List-of-posn -> List-of-posn
; translates the y pos by 1 for every posn in lop

#;
(define (translate lop)
  (make-posn 0 0))

; examples before translation
(define lop1 (cons (make-posn 1 2) '()))
(define lop2 (cons (make-posn 3 0) lop1))
(define lop3 (cons (make-posn -1 5) lop2))

; examples after translation
(define lop1t (cons (make-posn 1 3) '()))
(define lop2t (cons (make-posn 3 1) lop1t))
(define lop3t (cons (make-posn -1 6) lop2t))

(check-expect (translate '()) '())
(check-expect (translate lop1) lop1t)
(check-expect (translate lop2) lop2t)
(check-expect (translate lop3) lop3t)

(define (translate lop)
  (cond
    [(empty? lop) '()]
    [else (cons (translate1 (first lop)) (translate (rest lop)))]))

;-------

; Posn -> Posn
; translates the y posn by 1

(check-expect (translate1 (make-posn 1 2)) (make-posn 1 3))
(check-expect (translate1 (make-posn 3 0)) (make-posn 3 1))
(check-expect (translate1 (make-posn -1 5)) (make-posn -1 6))

(define (translate1 pos)
  (make-posn (posn-x pos)
             (+ (posn-y pos) 1)))