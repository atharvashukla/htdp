;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 207ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 207
;; ------------
;; Design total-time/list, which consumes an LLists and produces the total
;; amount of play time. *Hint* Solve exercise 206 first.
;;
;; Once you have completed the design, compute the total play time of your
;; iTunes collection. Compare this result with the time that the total-time
;; function from exercise 200 computes. Why is there a difference? 
;; -----------------------------------------------------------------------------


(require "206ex.rkt")
; provides
; find-association : String LAssoc Any -> (U Any Association)
; the association whose first item is key or default if
; no such association exists


; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
 
; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
; 
; An Association is a list of two items: 
;   (cons String (cons BSDN '()))



(define lassoc1
  (list
   (list "Name" "Call It Stormy Monday (Live)")
   (list "Artist" "Albert King 38 Stevie Ray Vaughan")
   (list "Album Artist" "Albert King 38 Stevie Ray Vaughan")
   (list "Album" "In Session (Live)")
   (list "Total Time" 540167)))

(define lassoc2
  (list
   (list "Name" "Brianstorm")
   (list "Artist" "Arctic Monkeys")
   (list "Album Artist" "Arctic Monkeys")
   (list "Album" "Favourite Worst Nightmare")
   (list "Total Time" 172253)))

(define llist1 (list lassoc1))
(define llist2 (list lassoc1 lassoc2))


; LList -> Number
; total play time in llist
#;
(define (total-time/list llist)
  0)

#;
(define (total-time/list llist)
  (cond
    [(empty? llist) ...]
    [else (... (first llist) ... (total-time/list (rest llist)) ...)]))

(check-expect (total-time/list llist1) 540167)
(check-expect (total-time/list llist2) (+ 172253 540167))
(check-expect (total-time/list '()) 0)


(define (total-time/list llist)
  (cond
    [(empty? llist) 0]
    [else (+ (second (find-association "Total Time" (first llist) 0)) ; second of asscoc
             (total-time/list (rest llist)))]))