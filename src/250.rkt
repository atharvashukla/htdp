;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 250ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 250.
;; ------------
;;
;; Design tabulate, which is the abstraction of the two functions in figure 92.
;; When tabulate is properly designed, use it to define a tabulation function
;; for sqr and tan. 
;;
;;    ; Number -> [List-of Number]
;;    ; tabulates sin between n 
;;    ; and 0 (incl.) in a list
;;    (define (tab-sin n)
;;      (cond
;;        [(= n 0) (list (sin 0))]
;;        [else (cons (sin n) (tab-sin (sub1 n)))]))
;;
;;
;;    ; Number -> [List-of Number]
;;    ; tabulates sqrt between n 
;;    ; and 0 (incl.) in a list
;;    (define (tab-sqrt n)
;;      (cond
;;        [(= n 0) (list (sqrt 0))]
;;        [else (cons (sqrt n) (tab-sqrt (sub1 n)))]))
;;
;; Figure 92: The similar functions for exercise 250
;;
;; -----------------------------------------------------------------------------

;; The two fuunctions from figure 92:

; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (incl.) in a list
(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else (cons (sin n) (tab-sin (sub1 n)))]))
  

; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (incl.) in a list
(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else (cons (sqrt n) (tab-sqrt (sub1 n)))]))

;; adding tests
(check-within (tab-sin 2) (list (sin 2) (sin 1) (sin 0)) 0.0001)
(check-within (tab-sqrt 2) (list (sqrt 2) (sqrt 1) (sqrt 0)) 0.0001)

; Number -> [List-of Number]
; tabulates f between n and
; 0 (incl.) in a list

(check-within (tabulate 2 sin) (tab-sin 2) 0.0001)
(check-within (tabulate 2 sqrt) (tab-sqrt 2) 0.0001)

(define (tabulate n f)
  (cond
    [(= n 0) (list (f 0))]
    [else (cons (f n) (tabulate (sub1 n) f))]))

; -------

(check-within (tab-sqr 2) (list (sqr 2) (sqr 1) (sqr 0)) 0.0001)

(define (tab-sqr n)
  (tabulate n sqr))

(check-within (tab-tan 2) (list (tan 2) (tan 1) (tan 0)) 0.0001)

(define (tab-tan n)
  (tabulate n tan))

