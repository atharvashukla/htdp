;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 187ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 187
;; ------------
;; Design a program that sorts lists of game players by score:
;;
;;    (define-struct gp [name score])
;;    ; A GamePlayer is a structure: 
;;    ;    (make-gp String Number)
;;    ; interpretation (make-gp p s) represents player p who 
;;    ; scored a maximum of s points 
;;
;; Hint Formulate a function that compares two elements of GamePlayer. 
;; -----------------------------------------------------------------------------

(define-struct gp [name score])
; A GamePlayer (GP) is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points 

; --------------------------------------------------------------------------------

(define game-player1 (make-gp "a" 100))
(define game-player2 (make-gp "k" 101))
(define game-player3 (make-gp "a" 22))
(define game-player4 (make-gp "h" 99))

(define gp-list1 (cons game-player1 '()))
(define gp-list2 (cons game-player2 gp-list1))
(define gp-list3 (cons game-player3 gp-list2))
(define gp-list4 (cons game-player4 gp-list3))

(define gp-list1-sorted (list game-player1))
(define gp-list2-sorted (list game-player1 game-player2))
(define gp-list3-sorted (list game-player3 game-player1 game-player2))
(define gp-list4-sorted (list game-player3 game-player4 game-player1 game-player2))

(check-expect (sortgp< gp-list1) gp-list1-sorted)
(check-expect (sortgp< gp-list2) gp-list2-sorted)
(check-expect (sortgp< gp-list3) gp-list3-sorted)
(check-expect (sortgp< gp-list4) gp-list4-sorted)


; --------------------------------------------------------------------------------

; List-of-GP -> List-of-GP
; produces a sorted version of l
(define (sortgp< logp)
  (cond
    [(empty? logp) '()]
    [(cons? logp) (insert-gp (first logp) (sortgp< (rest logp)))]))
 
; GP List-of-GP -> List-of-GP
; inserts gp into the sorted list of numbers l 
(define (insert-gp gp logp)
  (cond
    [(empty? logp) (cons gp '())]
    [else (if (isgreater-gp gp (first logp))
              (cons (first logp) (insert-gp gp (rest logp)))
              (cons gp logp))]))

; --------------------------------------------------------------------------------

;; GamePlayer -> Boolean
;; is the score of gp1 greater than the score of gp2?
(define (isgreater-gp gp1 gp2)
  (> (gp-score gp1) (gp-score gp2)))


