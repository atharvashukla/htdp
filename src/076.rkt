;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 76ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 76.
;; ------------
;;
;;  Formulate data definitions for the following structure type definitions:
;;
;;    (define-struct movie [title producer year])
;;    
;;    (define-struct person [name hair eyes phone])
;;    
;;    (define-struct pet [name number])
;;    
;;    (define-struct CD [artist title price])
;;    
;;    (define-struct sweater [material size producer])
;;
;; Make sensible assumptions as to what kind of values go into each field.
;;
;; -----------------------------------------------------------------------------


(define-struct movie [title producer year])
; A Movie is a structure
;  (make-movie String String Number)
; *interpretation* (make-movie title producer year)
; is a movie of name 'title' produced by 'producer'
; and was released on the year, 'year'

(define-struct person [name hair eyes phone])
; A Person is a structure
;  (make-person String String String Number)
; *interpretation* a person is comoposed of a 
; name, hair color, eye color and phone number

(define-struct pet [name number])
; A Per is a structure
;  (make-per String Number)
; *interpretation* a pet with name and
; its ID

(define-struct CD [artist title price])
; A CD is a structure
;  (make-CD String String Number)
; *interpretation*: a music CD's artist name
; title name and price in usd

(define sweater [material size producer])
; A Sweater is a structure
;  (make-sweater String Number String)
; *interpretation*: a description of a sweater w/
; its material, size number and producer's name