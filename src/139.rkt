;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 139ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 139.
;; -------------
;; Now take a look at this data definition:
;;
;;    ; A List-of-numbers is one of: 
;;    ; – '()
;;    ; – (cons Number List-of-numbers)
;;
;; Some elements of this class of data are appropriate inputs for sum from
;; exercise 138 and some aren’t.
;;
;; Design the function pos?, which consumes a List-of-numbers and determines
;; whether all numbers are positive numbers. In other words, if (pos? l) yields
;; #true, then l is an element of List-of-amounts. Use DrRacket’s stepper to
;; understand how pos? works for (cons 5 '()) and (cons -1 '()).
;;
;; Also design checked-sum. The function consumes a List-of-numbers. It produces
;; their sum if the input also belongs to List-of-amounts; otherwise it signals
;; an error. Hint Recall to use check-error.
;;
;; What does sum compute for an element of List-of-numbers? 
;; -----------------------------------------------------------------------------

; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)


; List-of-numbers -> Boolean
; are all numbers in lon positive?

(check-expect (pos? '()) #true)
(check-expect (pos? (cons 5 '())) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons 5 (cons -1 '()))) #false)

#;
(define (pos? lon)
  #true)

; template
(define (pos?-temp lon)
  (cond
    [(empty? lon) ...]
    [else (... (first lon) ... (pos?-temp (rest lon)) ...)]))


(define (pos? lon)
  (cond
    [(empty? lon) #true]
    [else (and (positive? (first lon))
               (pos? (rest lon)))]))


; -----------------

(pos? (cons 5 '()))
; ==
(cond
  [(empty? (cons 5 '())) #true]
  [else (and (positive? (first (cons 5 '())))
             (pos? (rest (cons 5 '()))))])
; ==
(cond
  [#false #true]
  [else (and (positive? (first (cons 5 '())))
             (pos? (rest (cons 5 '()))))])
; ==
(and (positive? (first (cons 5 '())))
     (pos? (rest (cons 5 '()))))
; ==
(and (positive? 5)
     (pos? (rest (cons 5 '()))))
; ==
(and #true
     (pos? (rest (cons 5 '()))))
; ==
(pos? (rest (cons 5 '())))
; ==
(pos? '())
; ==
(cond
  [(empty? '()) #true]
  [else (and (positive? (first '()))
             (pos? (rest '())))])
; ==
(cond
  [#true #true]
  [else (and (positive? (first '()))
             (pos? (rest '())))])
; ==
#true

; -----------------

(pos? (cons -1 '()))
; ==
(cond
  [(empty? (cons -1 '())) #true]
  [else (and (positive? (first (cons -1 '())))
             (pos? (rest (cons -1 '()))))])
; ==
(cond
  [#false #true]
  [else (and (positive? (first (cons -1 '())))
             (pos? (rest (cons -1 '()))))])
; ==
(and (positive? (first (cons -1 '())))
     (pos? (rest (cons -1 '()))))
; ==
(and (positive? -1)
     (pos? (rest (cons 5 '()))))
; ==
(and #false
     (pos? (rest (cons 5 '()))))
; ==
#false

; -----------------


;; List-of-numbers -> Number
;; computes the sum of all amounts in loa

(check-expect (sum-loa '()) 0)
(check-expect (sum-loa (cons 1 '())) 1)
(check-expect (sum-loa (cons 1 (cons 2 (cons 3 '())))) 6)

(define (sum-loa alos)
  (cond
    [(empty? alos) 0]
    [else (+ (first alos) (sum-loa (rest alos)) )]))



;; List-of-numbers -> Number
;; computes the sum if input belongs to loa

(check-expect (checked-sum (cons 1 (cons 2 '()))) 3)
(check-error (checked-sum (cons -1 (cons 2 '())))
             "list contains a negative number")

(define (checked-sum lon)
  (cond
    [(pos? lon) (sum-loa lon)]
    [else (error "list contains a negative number")]))
