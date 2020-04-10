;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 283ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 283
;; ------------
;; Confirm that DrRacket’s stepper can deal with lambda. Use it to step through
;; the third example and also to determine how DrRacket evaluates the following
;; expressions:
;; 
;;    (map (lambda (x) (* 10 x))
;;         '(1 2 3))
;;     
;;    (foldl (lambda (name rst)
;;             (string-append name ", " rst))
;;           "etc."
;;           '("Matthew" "Robby"))
;;     
;;    (filter (lambda (ir) (<= (ir-price ir) th))
;;            (list (make-ir "bear" 10)
;;                  (make-ir "doll" 33)))
;; 
;; -----------------------------------------------------------------------------

(define-struct ir [name price])
; An IR is a structure:
;   (make-ir String Number)

(define th 15)


((lambda (ir) (<= (ir-price ir) th))
 (make-ir "bear" 10))
; ==
(<=
 (ir-price (make-ir "bear" 10))
 th)
; ==
(<= 10 th)
; ==
(<= 10 15)
; ==
#true

; ----------------

(map (lambda (x) (* 10 x))
     '(1 2 3))

; (... (* 10 1) ...)
; (... (* 10 2) ...)
; (... (* 10 3) ...)

; (list 10 20 30)

(foldl (lambda (name rst)
         (string-append name ", " rst))
       "etc."
       '("Matthew" "Robby"))

; (... "Matthew, etc." ...)
; (... "Robby, Matthew, etc." ...)

; "Robby, Matthew, etc."


(filter (lambda (ir) (<= (ir-price ir) th))
        (list (make-ir "bear" 10)
              (make-ir "doll" 33)))

; (...
;  (<=
;   (ir-price (make-ir "bear" 10))
;   th)
;  ...)
; 
; (... (<= 10 th) ...)
; 
; (... (<= 10 15) ...)
; 
; (... #true ...)
; 
;; ---
; 
; (...
;  (<=
;   (ir-price (make-ir "doll" 33))
;   th)
;  ...)
; 
; (... (<= 33 th) ...)
; 
; (... (<= 33 15) ...)
; 
; #false

; (list (make-ir "bear" 10))