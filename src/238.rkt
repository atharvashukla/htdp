;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 238ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 238
;; ------------
;; Abstract the two functions in figure 89 into a single function. Both consume
;; non-empty lists of numbers (Nelon) and produce a single number. The left one
;; produces the smallest number in the list, and the right one the largest.
;;
;;    ; Nelon -> Number
;;    ; determines the smallest 
;;    ; number on l
;;    (define (inf l)
;;      (cond
;;        [(empty? (rest l)) (first l)]
;;        [else (if (< (first l) (inf (rest l)))
;;                  (first l)
;;                  (inf (rest l)))]))
;;    
;;    
;;    ; Nelon -> Number
;;    ; determines the largest 
;;    ; number on l
;;    (define (sup l)
;;      (cond [(empty? (rest l)) (first l)]
;;            [else (if (> (first l) (sup (rest l)))
;;                      (first l)
;;                      (sup (rest l)))]))
;;
;; Figure 89: Finding the inf and sup in a list of numbers
;;
;; Define inf-1 and sup-1 in terms of the abstract function. Test them with
;; these two lists:
;;
;;    (list 25 24 23 22 21 20 19 18 17 16 15 14 13
;;          12 11 10 9 8 7 6 5 4 3 2 1)
;;     
;;    (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
;;          17 18 19 20 21 22 23 24 25)
;;
;; Why are these functions slow on some of the long lists?
;;
;; Modify the original functions with the use of max, which picks the larger of
;; two numbers, and min, which picks the smaller one. Then abstract again,
;; define inf-2 and sup-2, and test them with the same inputs again. Why are
;; these versions so much faster?
;;
;; For another answer to these questions, see Local Definitions. 
;; -----------------------------------------------------------------------------

; Nelon -> Number
; determines the smallest 
; number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (< (first l) (inf (rest l)))
              (first l)
              (inf (rest l)))]))

; slow
; (check-expect (inf list1) 1)
; (check-expect (inf list2) 1)

(check-expect (inf '(1 2 3 4 5)) 1)
(check-expect (inf '(5 4 3 2 1)) 1)

; Nelon -> Number
; determines the largest 
; number on l
(define (sup l)
  (cond [(empty? (rest l)) (first l)]
        [else (if (> (first l) (sup (rest l)))
                  (first l)
                  (sup (rest l)))]))

; slow
; (check-expect (sup list1) 25)
; (check-expect (sup list2) 25)

(check-expect (sup '(1 2 3 4 5)) 5)
(check-expect (sup '(5 4 3 2 1)) 5)


(define list1
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13
        12 11 10 9 8 7 6 5 4 3 2 1))

(define list2
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
        17 18 19 20 21 22 23 24 25))

; ------------------------------------------------

; ABSTRACTING
; Func Lon -> Number
; get the number that satisfies
; t to the greatest extent
(define (get t l)
  (cond [(empty? (rest l)) (first l)]
        [else (if (t (first l) (get t (rest l)))
                  (first l)
                  (get t (rest l)))]))

; > for the largest number in l
; < for the smallest number in l
(check-expect (get > '(1 2 3 4 5)) 5)
(check-expect (get > '(5 4 3 2 1)) 5)
(check-expect (get < '(1 2 3 4 5)) 1)
(check-expect (get < '(5 4 3 2 1)) 1)

; ------------------------------------------------

; USING MAX AND MIN IN ORIG FUNC


; Nelon -> Number
; determines the smallest 
; number on l
(define (inf.v2 l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (min (first l) (inf.v2 (rest l)))]))

; fast
(check-expect (inf.v2 list1) 1)
(check-expect (inf.v2 list2) 1)

(check-expect (inf.v2 '(1 2 3 4 5)) 1)
(check-expect (inf.v2 '(5 4 3 2 1)) 1)

; Nelon -> Number
; determines the largest 
; number on l
(define (sup.v2 l)
  (cond [(empty? (rest l)) (first l)]
        [else (max (first l) (sup.v2 (rest l)))]))

; fast
(check-expect (sup.v2 list1) 25)
(check-expect (sup.v2 list2) 25)

(check-expect (sup.v2 '(1 2 3 4 5)) 5)
(check-expect (sup.v2 '(5 4 3 2 1)) 5)

; ------------------------------------------------

; ABSTRACTING AGAIN

; Func Nelon -> Nelon
; gets the element that satisfies f
; to the greatest extent
(define (get.v2 f l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (f (first l) (get.v2 f (rest l)))]))

(check-expect (get.v2 max '(1 2 3 4 5)) 5)
(check-expect (get.v2 max '(5 4 3 2 1)) 5)
(check-expect (get.v2 min '(1 2 3 4 5)) 1)
(check-expect (get.v2 min '(5 4 3 2 1)) 1)

; sup, inf, and get were slow because we recur down the list
; for each condition and then again if the condition is not
; satisfied, this is done at most (length l) times. 

; sup.v2, inf.v2 and get.v2 are faster because they only recur
; down the list once, and simply apply the function onto the result
; and the (first l)
