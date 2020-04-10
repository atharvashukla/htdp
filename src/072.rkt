;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 72ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 72.
;; ------------
;; Formulate a data definition for the above phone structure type definition
;; that accommodates the given examples.
;;
;; Next formulate a data definition for phone numbers using this structure type
;; definition:
;; 
;;    (define-struct phone# [area switch num])
;;
;; Historically, the first three digits make up the area code, the next three
;; the code for the phone switch (exchange) of your neighborhood, and the last
;; four the phone with respect to the neighborhood. Describe the content of the
;; three fields as precisely as possible with intervals.
;; -----------------------------------------------------------------------------


(define-struct phone [area number])
; A Phone is a structure
;   (make-phone Number String)
; *interpretation*
; `area` is a Number  [000, 999]
; `number` is a String with the rest of the number with the format "XXX-XXXX"

(define-struct phone# [area switch num])
; A Phone# is a structure
;   (make-phone# Number Number Number)
; *interpretation* phone number
; `area` is a Number [000, 999]
; switch is a Number [000, 9999]
; `num` is a Number [0000, 9999]