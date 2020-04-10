;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 295ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 295
;; ------------
;; Develop n-inside-playground?, a specification of the random-posns function
;; below. The function generates a predicate that ensures that the length of the
;; given list is some given count and that all Posns in this list are within a
;; WIDTH by HEIGHT rectangle:
;;
;;    ; distances in terms of pixels 
;;    (define WIDTH 300)
;;    (define HEIGHT 300)
;;     
;;    ; N -> [List-of Posn]
;;    ; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
;;    (check-satisfied (random-posns 3)
;;                     (n-inside-playground? 3))
;;    (define (random-posns n)
;;      (build-list
;;        n
;;        (lambda (i)
;;          (make-posn (random WIDTH) (random HEIGHT)))))
;;
;; Define random-posns/bad that satisfies n-inside-playground? and does not live
;; up to the expectations implied by the above purpose statement. Note This
;; specification is incomplete. Although the word “partial” might come to mind,
;; computer scientists reserve the phrase “partial specification” for a
;; different purpose. 
;; -----------------------------------------------------------------------------


(require 2htdp/image)

; distances in terms of pixels 
(define WIDTH 300)
(define HEIGHT 300)
 
; N -> [List-of Posn]
; generates n random Posns in [0,WIDTH) by [0,HEIGHT)
(check-satisfied (random-posns 3)
                 (n-inside-playground? 3))

(define (random-posns n)
  (build-list
    n
    (lambda (i)
      (make-posn (random WIDTH) (random HEIGHT)))))


(define (n-inside-playground? n)
  (λ (l)
    (and (= (length l) n)
         (andmap (λ (i) (and (<= 0 (posn-x i) (sub1 WIDTH))
                             (<= 0 (posn-y i) (sub1 HEIGHT))))
                 l))))


; N -> [List-of Posn]
; satisfies n-inside-playground? and does not live up to the
; expectations implied by the above purpose statement

(define (random-posns/bad n)
  (build-list n (λ (i) (make-posn 0 0))))

(check-satisfied (random-posns/bad 3)
                 (n-inside-playground? 3))