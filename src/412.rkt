;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 412ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 412
;; ------------
;; Design inex+. The function adds two Inex representations of numbers that have
;; the same exponent. The function must be able to deal with inputs that
;; increase the exponent. Furthermore, it must signal its own error if the
;; result is out of range, not rely on create-inex for error checking.
;;
;; *Challenge* Extend inex+ so that it can deal with inputs whose exponents
;; differ by 1:
;;
;;    (check-expect
;;      (inex+ (create-inex 1 1 0) (create-inex 1 -1 1))
;;      (create-inex 11 -1 1))
;;
;; Do not attempt to deal with larger classes of inputs than that without
;; reading the following subsection. 
;; -----------------------------------------------------------------------------


(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)
; An S is one of:
; – 1
; – -1
; An N99 is an N between 0 and 99 (inclusive).

(define (inex-temp i)
  (... (inex-mantissa i) ... (inex-sign i) ... (inex-exponent i) ...))

; N Number N -> Inex
; makes an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))
 
; Inex -> Number
; converts an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
      10 (* (inex-sign an-inex) (inex-exponent an-inex)))))


; ----------

; Inex Inex -> Inex
; add the two number representations
; ASSUMPTION: i1 and i2 have the same exponent

(check-expect (inex+ (create-inex 1 1 0) (create-inex 2 1 0)) (create-inex 3 1 0))
(check-expect (inex+ (create-inex 55 1 0) (create-inex 55 1 0)) (create-inex 11 1 1))
(check-expect (inex+ (create-inex 56 1 0) (create-inex 56 1 0)) (create-inex 11 1 1))
(check-expect (inex+ (create-inex 99 -1 98) (create-inex 99 -1 98)) (create-inex 20 -1 99))
(check-expect (inex+ (create-inex 99 -1 98) (create-inex 99 -1 98)) (create-inex 20 -1 99))
(check-error (inex+ (create-inex 99 -1 99) (create-inex 99 -1 99)) "the sum is out of range")

(define (inex+ i1 i2)
  (local ((define mantissa+ (+ (inex-mantissa i1) (inex-mantissa i2)))
          (define sign (inex-sign i1))
          (define exponent (inex-exponent i1))
          ; Dummy -> Inex
          (define (good-inex+ _)
            (if (> mantissa+ 99)
                (create-inex (round (/ mantissa+ 10)) sign (+ exponent 1))
                (create-inex mantissa+ sign exponent)))
          ; Inex -> Boolean
          ; is i out of range?
          (define (inex-out-of-range? i)
            (> (+ (inex-exponent i) 1) 99)))
    (if (and (> mantissa+ 99) (inex-out-of-range? i1))
        (error "the sum is out of range")
        (good-inex+ '_))))



