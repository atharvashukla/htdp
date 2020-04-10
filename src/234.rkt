;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 234ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 234
;; ------------
;; Create the function make-ranking, which consumes a list of ranked song titles
;; and produces a list representation of an HTML table. Consider this example:
;;
;;    (define one-list
;;      '("Asia: Heat of the Moment"
;;        "U2: One"
;;        "The White Stripes: Seven Nation Army"))
;;
;; If you apply make-ranking to one-list and display the resulting web page in a
;; 'browser, you see something like the screen shot in figure 85.
;;
;; <web-page-image.png>
;; Figure 85: A web page generated with BSL+
;;
;; *Hint* Although you could design a function that determines the rankings from
;; a list of strings, we wish you to focus on the creation of tables instead.
;; Thus we supply the following functions:
;;
;;    (define (ranking los)
;;      (reverse (add-ranks (reverse los))))
;;     
;;    (define (add-ranks los)
;;      (cond
;;        [(empty? los) '()]
;;        [else (cons (list (length los) (first los))
;;                    (add-ranks (rest los)))]))
;;
;; Before you use these functions, equip them with signatures and purpose
;; statements. Then explore their workings with interactions in DrRacket.
;; Accumulators expands the design recipe with a way to create simpler functions
;; for computing rankings than ranking and add-ranks. 
;; -----------------------------------------------------------------------------

(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))

; Rank is a (list Number String)
; a songs and its rank

; List-of-strings -> List-of-rank

(check-expect (ranking '()) '())
(check-expect (ranking '("a")) '((1 "a")))
(check-expect (ranking '("a" "b")) '((1 "a") (2 "b")))
(check-expect (ranking '("a" "b" "c")) '((1 "a") (2 "b") (3 "c")))

(define (ranking los)
  (reverse (add-ranks (reverse los))))


; List-of-strings -> List-of-ranks

(check-expect (add-ranks '()) '())
(check-expect (add-ranks '("a")) '((1 "a")))
(check-expect (add-ranks '("a" "b")) '((2 "a") (1 "b")))
(check-expect (add-ranks '("a" "b" "c")) '((3 "a") (2 "b") (1 "c")))

(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))


; List-of-rank -> ... nested list ...
; creates a row for an HTML table from l

(check-expect (make-all-rows '()) '())
(check-expect (make-all-rows `((1 "a") (2 "b") (3 "c")))
              `((tr (td "1") (td "a")) (tr (td "2") (td "b")) (tr (td "3") (td "c"))))
            
(define (make-all-rows l)
  (cond
    [(empty? l) '()]
    [else (cons (make-one-row (first l))
                (make-all-rows (rest l)))]))



; Rank -> ... nested list ...
; creates a cell for an HTML table from a Rank

(check-expect (make-one-row (list 1 "a")) `(tr (td "1") (td "a")))

(define (make-one-row rs)
  `(tr (td ,(number->string (first rs))) (td ,(second rs))))


; List-of-string -> ... nested list ...
; creates an HTML table from the list of songs

(check-expect
 (make-table one-list)
 `(table ((border "1"))
         (tr (td "1") (td "Asia: Heat of the Moment"))
         (tr (td "2") (td "U2: One"))
         (tr (td "3") (td "The White Stripes: Seven Nation Army"))))

(define (make-table l)
  `(table ((border "1")) ,@(make-all-rows (ranking l))))


; creates a list of table rows
; (define (lo-tr ))

(require 2htdp/web-io)

#;; renders fine :)
(show-in-browser
 `(table ((border "1"))
         (tr (td "1") (td "Asia: Heat of the Moment"))
         (tr (td "2") (td "U2: One"))
         (tr (td "3") (td "The White Stripes: Seven Nation Army"))))

