;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 261ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 261
;; ------------
;; Consider the function definition in figure 101. Both clauses in the nested
;; cond expression extract the first item from an-inv and both compute (extract1
;; (rest an-inv)). Use local to name this expression. Does this help increase
;; the speed at which the function computes its result? Significantly? A little
;; bit? Not at all?
;;
;;    ; Inventory -> Inventory
;;    ; creates an Inventory from an-inv for all
;;    ; those items that cost less than a dollar
;;    (define (extract1 an-inv)
;;      (cond
;;        [(empty? an-inv) '()]
;;        [else
;;         (cond
;;           [(<= (ir-price (first an-inv)) 1.0)
;;            (cons (first an-inv) (extract1 (rest an-inv)))]
;;           [else (extract1 (rest an-inv))])]))
;;
;; Figure 101: A function on inventories, see exercise 261
;; 
;; -----------------------------------------------------------------------------


(define-struct ir [name price])
; An IR is a structure:
;   (make-ir String Number)


(define ir-list (list (make-ir "cloth" 1) (make-ir "bread" 0.5)
                      (make-ir "milk" 0.75) (make-ir "speaker" 10)
                      (make-ir "egg" 0.99) (make-ir "powder" 1.04)))

(define ir-list<=1 (list (make-ir "cloth" 1)
                         (make-ir "bread" 0.5)
                         (make-ir "milk" 0.75)
                         (make-ir "egg" 0.99)))

; [X] [List-of X] -> [List-of X]
; appends l onto itself 10 times
(define (app-n-times l n)
  (cond
    [(= 0 n) '()]
    [else (append l (app-n-times l (sub1 n)))]))

(check-expect (app-n-times '(1 2 3) 0) '())
(check-expect (app-n-times '(1 2 3) 1) '(1 2 3))
(check-expect (app-n-times '(1 2 3) 2) '(1 2 3 1 2 3))


; X -> String
; displays a dummy value
(define (display-canonical-result x)
  "done")

(check-expect (display-canonical-result 1) "done")
(check-expect (display-canonical-result 'x) "done")


; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (ir-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))

(check-expect (extract1 ir-list) ir-list<=1)
(display-canonical-result (time (extract1 (app-n-times ir-list 1000))))
;; => cpu time: 11 real time: 10 gc time: 0 

; Inventory -> Inventory
; creates an Inventory from an-inv for all
; those items that cost less than a dollar
(define (extract1.v2 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (local ((define less-than-in-rest (extract1.v2 (rest an-inv))))
       (cond
         [(<= (ir-price (first an-inv)) 1.0)
          (cons (first an-inv) less-than-in-rest)]
         [else (extract1.v2 less-than-in-rest)]))]))

(check-expect (extract1.v2 ir-list) ir-list<=1)
(display-canonical-result (time (extract1.v2 (app-n-times ir-list 1000))))
;; => cpu time: 7929 real time: 8054 gc time: 804


; the local version is slower!