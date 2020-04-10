;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 181ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 181
;; ------------
;;
;; Use list to construct the equivalent of these lists
;;
;;    1. (cons "a" (cons "b" (cons "c" (cons "d" '()))))
;;    
;;    2. (cons (cons 1 (cons 2 '())) '())
;;    
;;    3. (cons "a" (cons (cons 1 '()) (cons #false '())))
;;    
;;    4. (cons (cons "a" (cons 2 '())) (cons "hello" '()))
;;
;; Also try your hand at this one:
;;
;;    (cons (cons 1 (cons 2 '()))
;;          (cons (cons 2 '())
;;                '()))
;;
;; Start by determining how many items each list and each nested list contains.
;; Use check-expect to express your answers; this ensures that your
;; abbreviations are really the same as the long-hand.
;; 
;; -----------------------------------------------------------------------------

; Cons form
(define one-cons (cons "a" (cons "b" (cons "c" (cons "d" '())))))

(define two-cons (cons (cons 1 (cons 2 '())) '()))

(define three-cons (cons "a" (cons (cons 1 '()) (cons #false '()))))

(define four-cons (cons (cons "a" (cons 2 '())) (cons "hello" '())))

(define five-cons (cons (cons 1 (cons 2 '()))
                        (cons (cons 2 '())
                              '())))


; List form
(define one-list (list "a" "b" "c" "d"))

(define two-list (list (list 1 2)))

(define three-list (list "a" (list 1) #false))

(define four-list (list (list "a" 2) "hello"))

(define five-list (list (list 1 2) (list 2)))


; Tests
(check-expect one-cons one-list)
  
(check-expect two-cons two-list)

(check-expect three-cons three-list)

(check-expect four-cons four-list)

(check-expect five-cons five-list)