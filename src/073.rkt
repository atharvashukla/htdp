;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 73ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 73.
;; ------------
;; Design the function posn-up-x, which consumes a Posn p and a Number n. It
;; produces a Posn like p with n in the x field.
;; -----------------------------------------------------------------------------


; Posn -> Posn
; places in in x field of p
#;
(define (posn-up-x p n)
  (make-posn 0 0))

(check-expect (posn-up-x (make-posn 3 3) 5) (make-posn 5 3))
(check-expect (posn-up-x (make-posn 0 0) 0) (make-posn 0 0))

#;
(define (posn-up-x p n)
  (... (posn-x p) ... (posn-y p) ...))


(define (posn-up-x p n)
  (make-posn n (posn-y p)))