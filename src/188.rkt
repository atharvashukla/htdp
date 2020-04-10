;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |188ex [nc]|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 188 
;; ------------
;;  Design a program that sorts lists of emails by date:
;; 
;;    (define-struct email [from date message])
;;    ; An Email Message is a structure: 
;;    ;   (make-email String Number String)
;;    ; interpretation (make-email f d m) represents text m 
;;    ; sent by f, d seconds after the beginning of time
;;
;; Also develop a program that sorts lists of email messages by name. To compare
;; two strings alphabetically, use the string<? primitive.
;; -----------------------------------------------------------------------------

(define-struct email [from date message])
; An EmailMessage is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time

(define em1 (make-email "author" 18901212 "ok"))
(define em2 (make-email "arthur" 19990101 "ok+"))
(define em3 (make-email "arthoor" 20180423 "ok++"))

; List-of-GP -> List-of-GP
; produces a sorted version of l

(check-expect (sort-em< '()) '())
(check-expect (sort-em< (list em3 em2 em1)) (list em1 em2 em3))
(check-expect (sort-em< (list em2 em3 em1)) (list em1 em2 em3))

(define (sort-em< lo-em)
  (cond
    [(empty? lo-em) '()]
    [(cons? lo-em)
     (insert-em (first lo-em)
                (sort-em< (rest lo-em)))]))
 
; GP List-of-GP -> List-of-GP
; inserts gp into the sorted list of numbers l

(check-expect (insert-em em1 '()) (list em1))
(check-expect (insert-em em2 (list em1 em3)) (list em1 em2 em3))

(define (insert-em em lo-em)
  (cond
    [(empty? lo-em) (cons em '())]
    [else (if (is-smaller-em em (first lo-em))
              (cons em lo-em)
              (cons (first lo-em) (insert-em em (rest lo-em))))]))

; --------------------------------------------------------------------------------

;; EmailMessage -> Boolean
;; is the score of gp1 greater than the score of gp2?

(check-expect (is-smaller-em em1 em2) #true)
(check-expect (is-smaller-em em2 em1) #false)

(define (is-smaller-em em1 em2)
  (< (email-date em1) (email-date em2)))

