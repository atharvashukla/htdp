;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 128ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 128.
;; -------------
;; Copy the following tests into DrRacket’s definitions area:
;;
;;    (check-member-of "green" "red" "yellow" "grey")
;;    (check-within (make-posn #i1.0 #i1.1)
;;                  (make-posn #i0.9 #i1.2)  0.01)
;;    (check-range #i0.9 #i0.6 #i0.8)
;;    (check-random (make-posn (random 3) (random 9))
;;                  (make-posn (random 9) (random 3)))
;;    (check-satisfied 4 odd?)
;; 
;; Validate that all of them fail and explain why. 
;; -----------------------------------------------------------------------------


(check-member-of "green" "red" "yellow" "grey")
; "green" differs from "red", "yellow" and "grey"

(check-within (make-posn #i1.0 #i1.1)
              (make-posn #i0.9 #i1.2)  0.01)
; #i1.0 is not within 0.01 of #i0.9. So the epsilon check fails

(check-range #i0.9 #i0.6 #i0.8)
; #i0.9is not between #i0.6 and #i0.8

(check-random (make-posn (random 3) (random 9))
              (make-posn (random 9) (random 3)))
; the random seed given to corresponding arguments differn

(check-satisfied 4 odd?)
; 4 is not odd