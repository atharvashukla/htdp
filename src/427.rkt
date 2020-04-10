;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 427ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 427
;; ------------
;; While quick-sort< quickly reduces the size of the problem in many cases, it
;; is inappropriately slow for small problems. Hence people use quick-sort< to
;; reduce the size of the problem and switch to a different sort function when
;; the list is small enough.

;; Develop a version of quick-sort< that uses sort< (an appropriately adapted
;; variant of sort> from Auxiliary Functions that Recur) if the length of the
;; input is below some threshold.
;; -----------------------------------------------------------------------------


(define THRESH 5)

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct

(check-expect (quick-sort-faster< (list 55 41 37 49 40 15 74 43 48))
              (list 15 37 40 41 43 48 49 55 74))

(check-expect (quick-sort-faster< (list 55 41 37))
              (list 37  41 55))

(check-expect (quick-sort-faster< (list 41 55 37))
              (list 37 41 55))

(define (quick-sort-faster< alon)
  (if (<= (length alon) THRESH)
      (sort< alon)
      (quick-sort< alon)))

;; -----------------------------------------------------------------------------

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (list pivot)
                    (quick-sort< (largers alon pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))
 
; [List-of Number] Number -> [List-of Number]
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n) 
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))



;; -----------------------------------------------------------------------------



; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort< l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort< (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (<= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))


;; -----------------------------------------------------------------------------