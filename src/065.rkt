;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 65ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 65.
;; ------------
;;
;; Take a look at the following structure type definitions:
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
;; Write down the names of the functions (constructors, selectors, and
;; predicates) that each introduces.
;;
;; -----------------------------------------------------------------------------

(define-struct movie [title producer year])
;; constructor: make-movie
;; selectors: movie-title, movie-producer, movie-year
;; predicate: movie?

(define-struct person [name hair eyes phone])
;; constructor: make-person
;; selectors: person-name, person-hair, person-eyes, person-phone
;; predicate: person?

(define-struct pet [name number])
;; constructor: make-pet
;; selectors: pet-name, pet-number
;; predicate: pet?

(define-struct CD [artist title price])
;; constructor: make-CD
;; selectors: CD-artist, CD-title, CD-price
;; predicate: CD?

(define-struct sweater [material size producer])
;; constructor: make-sweater
;; selectors: sweater-material, sweater-size, sweater-producer
;; predicate: sweater?

