;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 413ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 413
;; ------------
;; Design inex*. The function multiplies two Inex representations of numbers,
;; including inputs that force an additional increase of the output’s exponent.
;; Like inex+, it must signal its own error if the result is out of range, not
;; rely on create-inex to perform error checking.
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
; multiply the two number representations

(check-expect (inex* (create-inex 2 1 4) (create-inex 8 1 10))
              (create-inex 16 1 14))

(check-expect (inex* (create-inex 20 1 1) (create-inex  5 1 4))
              (create-inex 10 1 6))

(check-expect (inex* (create-inex 27 -1 1) (create-inex  7 1 4))
              (create-inex 19 1 4))

(check-expect (inex* (create-inex 1 -1 2) (create-inex  1 -1 2))
              (create-inex 1 -1 4))

(check-expect (inex* (create-inex 99 -1 2) (create-inex  99 -1 2))
              (create-inex 98 -1 6))

(check-error (inex* (create-inex 99 -1 99) (create-inex  99 -1 99))
             "the product is out of range")


(define (inex* i1 i2)
  (local ((define mantissa* (* (inex-mantissa i1) (inex-mantissa i2)))
          (define exponent+ (+ (* (inex-sign i1) (inex-exponent i1))
                               (* (inex-sign i2) (inex-exponent i2))))
          (define new-sign (if (negative? exponent+) -1 1))
          (define abs-exponent+ (abs exponent+))
          (define carry-val
            (cond
              [(> mantissa* 999) 2]
              [(> mantissa* 99) 1]
              [else 0]))

          ; Dummy -> Inex
          (define (good-inex* i)
            (cond
              [(> mantissa* 999) (create-inex (round (/ mantissa* 100)) new-sign (+ abs-exponent+ carry-val))]
              [(> mantissa* 99) (create-inex (round (/ mantissa* 10)) new-sign (+ abs-exponent+ carry-val))]
              [else (create-inex mantissa* new-sign (+ (abs exponent+) carry-val))]))
          )
    (if (> (+ abs-exponent+ carry-val) 99)
        (error "the product is out of range")
        (good-inex* '_))))

