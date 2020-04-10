;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 135ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 135.
;; -------------
;;
;; Use DrRacket’s stepper to check the calculation for
;;
;;    (contains-flatt? (cons "Flatt" (cons "C" '())))
;;
;; Also use the stepper to determine the value of
;;
;;    (contains-flatt?
;;      (cons "A" (cons "Flatt" (cons "C" '()))))
;;
;; What happens when "Flatt" is replaced with "B"?
;; 
;; -----------------------------------------------------------------------------

; List-of-names -> Boolean
; determines whether "Flatt" is on a-list-of-names
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (or (string=? (first alon) "Flatt")
         (contains-flatt? (rest alon)))]))


(contains-flatt? (cons "Flatt" (cons "C" '())))
; ==
(cond
  [(empty? (cons "Flatt" (cons "C" '()))) #false]
  [(cons? (cons "Flatt" (cons "C" '())))
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [#false #false]
  [(cons? (cons "Flatt" (cons "C" '())))
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [(cons? (cons "Flatt" (cons "C" '())))
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [#true
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
; ==
(or (string=? "Flatt" "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
; ==
(or #true
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
; ==
#true

;; ---------------------------------------------------------


(contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
; ==
(cond
  [(empty? (cons "A" (cons "Flatt" (cons "C" '())))) #false]
  [(cons? (cons "A" (cons "Flatt" (cons "C" '()))))
   (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
       (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))])
; ==
(cond
  [#false #false]
  [(cons? (cons "A" (cons "Flatt" (cons "C" '()))))
   (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
       (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))])
; ==
(cond
  [(cons? (cons "A" (cons "Flatt" (cons "C" '()))))
   (or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
       (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))])
; ==
(or (string=? (first (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt")
    (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))
; ==
(or (string=? "A" "Flatt")
    (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))
; ==
(or #false
    (contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '()))))))
; ==
(contains-flatt? (rest (cons "A" (cons "Flatt" (cons "C" '())))))
; ==
(contains-flatt? (cons "Flatt" (cons "C" '())))
; ==
(cond
  [(empty? (cons "Flatt" (cons "C" '()))) #false]
  [(cons? (cons "Flatt" (cons "C" '())))
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [#false #false]
  [(cons? (cons "Flatt" (cons "C" '())))
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [(cons? (cons "Flatt" (cons "C" '())))
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [#true
   (or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))])
; ==
(or (string=? (first (cons "Flatt" (cons "C" '()))) "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
; ==
(or (string=? "Flatt" "Flatt")
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
; ==
(or #true
    (contains-flatt? (rest (cons "Flatt" (cons "C" '())))))
; ==
#true

;; ---------------------------------------------------------

(contains-flatt? (cons "A" (cons "B" (cons "C" '()))))
; ==
(cond
  [(empty? (cons "A" (cons "B" (cons "C" '())))) #false]
  [(cons? (cons "A" (cons "B" (cons "C" '()))))
   (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
       (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))])
; ==
(cond
  [#false #false]
  [(cons? (cons "A" (cons "B" (cons "C" '()))))
   (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
       (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))])
; ==
(cond
  [(cons? (cons "A" (cons "B" (cons "C" '()))))
   (or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
       (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))])
; ==
(or (string=? (first (cons "A" (cons "B" (cons "C" '())))) "Flatt")
    (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))
; ==
(or (string=? "A" "Flatt")
    (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))
; ==
(or #false
    (contains-flatt? (rest (cons "A" (cons "B" (cons "C" '()))))))
; ==
(contains-flatt? (rest (cons "A" (cons "B" (cons "C" '())))))
; ==
(contains-flatt? (cons "B" (cons "C" '())))
; ==
(cond
  [(empty? (cons "B" (cons "C" '()))) #false]
  [(cons? (cons "B" (cons "C" '())))
   (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "B" (cons "C" '())))))])
; ==
(cond
  [#false #false]
  [(cons? (cons "B" (cons "C" '())))
   (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "B" (cons "C" '())))))])
; ==
(cond
  [(cons? (cons "B" (cons "C" '())))
   (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "B" (cons "C" '())))))])
; ==
(cond
  [#true
   (or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
       (contains-flatt? (rest (cons "B" (cons "C" '())))))])
; ==
(or (string=? (first (cons "B" (cons "C" '()))) "Flatt")
    (contains-flatt? (rest (cons "B" (cons "C" '())))))
; ==
(or (string=? "B" "Flatt")
    (contains-flatt? (rest (cons "B" (cons "C" '())))))
; ==
(or #false
    (contains-flatt? (rest (cons "B" (cons "C" '())))))
; ==
(contains-flatt? (cons "C" '()))
; ==
(cond
  [(empty? (cons "C" '())) #false]
  [(cons? (cons "C" '()))
   (or (string=? (first (cons "C" '())) "Flatt")
       (contains-flatt? (rest (cons "C" '()))))])
; ==
(cond
  [#false #false]
  [(cons? (cons "C" '()))
   (or (string=? (first (cons "C" '())) "Flatt")
       (contains-flatt? (rest (cons "C" '()))))])
; ==
(cond
  [(cons? (cons "C" '()))
   (or (string=? (first (cons "C" '())) "Flatt")
       (contains-flatt? (rest (cons "C" '()))))])
; ==
(cond
  [#true
   (or (string=? (first (cons "C" '())) "Flatt")
       (contains-flatt? (rest (cons "C" '()))))])
; ==
(or (string=? (first (cons "C" '())) "Flatt")
    (contains-flatt? (rest (cons "C" '()))))
; ==
(or (string=? "C" "Flatt")
    (contains-flatt? (rest (cons "C" '()))))
; ==
(or #false
    (contains-flatt? (rest (cons "C" '()))))
; ==
(contains-flatt? (rest (cons "C" '())))
; ==
(contains-flatt? '())
; ==
(cond
  [(empty? '()) #false]
  [(cons? '())
   (or (string=? (first '()) "Flatt")
       (contains-flatt? (rest '())))])
; ==
(cond
  [#true #false]
  [(cons? '())
   (or (string=? (first '()) "Flatt")
       (contains-flatt? (rest '())))])
; ==
#false