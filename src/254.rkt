;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 254ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+-----------------------------------------------------------------------------+
| Exercise 254.                                                               |
| -------------                                                               |
| Formulate signatures for the following functions:                           |
|                                                                             |
| sort-n, which consumes a list of numbers and a function that consumes two   |
| numbers (from the list) and produces a Boolean; sort-n produces a sorted    |
| list of numbers.                                                            |
|                                                                             |
| sort-s, which consumes a list of strings and a function that consumes two   |
| strings (from the list) and produces a Boolean; sort-s produces a sorted    |
| list of strings.                                                            |
|                                                                             |
| Then abstract over the two signatures, following the above steps. Also show |
| that the generalized signature can be instantiated to describe the          |
| signature of a sort function for lists of IRs.                              |
+-----------------------------------------------------------------------------+
|#

(define lon1 '(9 6 5 2 4 1 3 8 7))

; [List-of Number] [Number Number -> Boolean] --> [List-of Number]
; sorts the lon by using comp as a comparator

(check-expect (sort-n lon1 <) (sort lon1 <))

(define (sort-n lon comp)
  (cond
    [(empty? lon) '()]
    [else (insert-n (first lon) (sort-n (rest lon) <) comp)]))

; Number [List-of Number] -> [List-of Number]
; insert str into the sorted list los using comp

(check-expect (insert-n 9 (list 1 2 3 4 5 6 7 8) <) (list 1 2 3 4 5 6 7 8 9))

(define (insert-n num lon comp)
  (cond
    [(empty? lon) (list num)]
    [else (if (comp num (first lon))
              (cons num lon)
              (cons (first lon) (insert-n num (rest lon) comp)))]))


(define los1 '("s" "w" "e" "r" "p" "l" "o" "i" "d"))

(check-expect (sort-s los1 string-ci<?) '("d" "e" "i" "l" "o" "p" "r" "s" "w"))

; [List-of String] [String String -> Boolean] --> [List-of String]
; sorts the lon by using comp as a comparator

(define (sort-s los comp)
  (cond
    [(empty? los) '()]
    [else (insert-s (first los) (sort-s (rest los) comp) comp)]))

; String [List-of String] -> [List-of String]
; insert str into the sorted list los using comp

(check-expect (insert-s "s" '("d" "e" "i" "l" "o" "p" "r" "w") string-ci<?)
              '("d" "e" "i" "l" "o" "p" "r" "s" "w"))

(define (insert-s str los comp)
  (cond
    [(empty? los) (list str)]
    [else (if (comp str (first los))
              (cons str los)
              (cons (first los) (insert-s str (rest los) comp)))]))

;; Now, Abstracting ... (my functions were already abstracted)

; [List-of X] [X X -> Boolean] --> [List-of X]
; sorts the lst by using comp as a comparator

(define (my-sort lst comp)
  (cond
    [(empty? lst) '()]
    [else (my-insert (first lst) (my-sort (rest lst) comp) comp)]))

; X [List-of X] -> [List-of X]
; insert elem into the sorted list lst using comp

(define (my-insert elem lst comp)
  (cond
    [(empty? lst) (list elem)]
    [else (if (comp elem (first lst))
              (cons elem lst)
              (cons (first lst) (my-insert elem (rest lstpppp) comp)))]))

; -----

	
(define-struct IR
  [name price])
; An IR is a structure:
;   (make-IR String Number)


; [List-of IR] [IR IR -> Boolean] -> [List-of IR]