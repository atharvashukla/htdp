;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 136ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 136.
;; ------------
;;
;; Validate with DrRacket’s stepper
;;
;; (our-first (our-cons "a" '())) == "a"
;; (our-rest (our-cons "a" '())) == '()
;;
;; See What Is '(), What Is cons for the definitions of these functions. 
;; -----------------------------------------------------------------------------

(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).


; A ConsOrEmpty is one of: 
; – '()
; – (make-pair Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all lists

; Any Any -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(empty? a-list) (make-pair a-value a-list)]
    [(pair? a-list) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> ConsOrEmpty
; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      (error 'our-rest "...")
      (pair-right a-list)))



(our-first (our-cons "a" '()))

; ==

(our-first
 (cond
   [(empty? '()) (make-pair "a" '())]
   [(pair? '()) (make-pair "a" '())]
   [else (error "cons: second argument ...")]))

; ==

(our-first
 (cond
   [#true (make-pair "a" '())]
   [(pair? '()) (make-pair "a" '())]
   [else (error "cons: second argument ...")]))

; ==

(our-first (make-pair "a" '()))

; ==

(if (empty? (make-pair "a" '()))
    (error (make-pair "a" '()) "...")
    (pair-left (our-cons "a" '())))

; ==

(if #false
    (error (make-pair "a" '()) "...")
    (pair-left (our-cons "a" '())))

; ==

(pair-left (make-pair "a" '()))

; ==

"a"

; ok. verified 


;; --------------------------------


(our-rest (our-cons "a" '()))

; ==

(our-rest
 (cond
   [(empty? '()) (make-pair "a" '())]
   [(pair? '()) (make-pair "a" '())]
   [else (error "cons: second argument ...")]))

; ==

(our-rest
 (cond
   [#true (make-pair "a" '())]
   [(pair? '()) (make-pair "a" '())]
   [else (error "cons: second argument ...")]))

; ==

(our-rest (make-pair "a" '()))

; ==

(if (empty? (make-pair "a" '()))
    (error 'our-rest "...")
    (pair-right (make-pair "a" '())))

; ==

(if #false
    (error 'our-rest "...")
    (pair-right (make-pair "a" '())))

; ==

(pair-right (make-pair "a" '()))

; ==

'()

; ok. verified 