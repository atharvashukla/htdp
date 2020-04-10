;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 369ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 369
;; ------------
;; Design find-attr. The function consumes a list of attributes and a symbol. If
;; the attributes list associates the symbol with a string, the function
;; retrieves this string; otherwise it returns #false. Look up assq and use it
;; to define the function.
;; -----------------------------------------------------------------------------


; [List-of Attribute] -> [String U #false]
; finds the string associated with sym, otherwise #f

(check-expect (find-attr '((name "sam") (age "20") (height "183")) 'name) "sam")
(check-expect (find-attr '((name "dave") (age "28") (height "179")) 'age) "28")

(define (find-attr loa sym)
  (local ((define lookd (assq sym loa)))
    (if (cons? lookd)
        (second lookd)
        lookd)))

