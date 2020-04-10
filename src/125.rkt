;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 125ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 125.
;; -------------
;; Discriminate the legal from the illegal sentences:
;; 
;;    1. (define-struct oops [])
;;
;;    2. (define-struct child [parents dob date])
;; 
;;    3. (define-struct (child person) [dob date])
;;
;; Explain why the sentences are legal or illegal. 
;;
;; -----------------------------------------------------------------------------



; definition = ...
;            | (define-struct name [name ...])


; 1. i legal because there can be 0 or more names within []
(define-struct oops [])

; 2. is legal according to the grammar
(define-struct child [parents dob date])

; 3. is illegal according to the grammar. There is a set of parenthesis
;    in the place of the struct name.
#;
(define-struct (child person) [dob date])