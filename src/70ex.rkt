;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 70ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 70.
;; ------------
;;
;; Spell out the laws for these structure type definitions:
;;
;;    (define-struct centry [name home office cell])
;;    (define-struct phone [area number])
;;
;; Use DrRacket’s stepper to confirm 101 as the value of this expression:
;;
;;    (phone-area
;;     (centry-office
;;      (make-centry "Shriram Fisler"
;;        (make-phone 207 "363-2421")
;;        (make-phone 101 "776-1099")
;;        (make-phone 208 "112-9981"))))
;;
;; -----------------------------------------------------------------------------

(define-struct vel [deltax deltay])

(define-struct ball [position velocity])

(define ball1
  (make-ball (make-posn 30 40) (make-vel -10 5)))


(define-struct ballf [x y deltax deltay])

(define ballf1 (make-ballf 30 40 -10 5))


(define-struct centry [name home office cell])
(define-struct phone [area number])

(phone-area
 (centry-office
  (make-centry "Shriram Fisler"
    (make-phone 207 "363-2421")
    (make-phone 101 "776-1099")
    (make-phone 208 "112-9981"))))
;; == { centry law }
(phone-area
 (make-phone 101 "776-1099"))
;; == { phone law }
101