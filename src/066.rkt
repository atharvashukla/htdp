;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 66ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 66.
;; ------------
;; Revisit the structure type definitions of exercise 65. Make sensible guesses
;; as to what kind of values go with which fields. Then create at least one
;; instance per structure type definition. 
;; -----------------------------------------------------------------------------

(define-struct movie [title producer year])

; constructor >>
(define movie-ex (make-movie "Dangal" "Aamir Khan" 2016))
; predicate >>
(movie? movie-ex)
; selectors >>
(movie-title movie-ex)
(movie-producer movie-ex)
(movie-year movie-ex)


(define-struct person [name hair eyes phone])

; constructor >>
(define person-ex (make-person "Atharva" "Black" "Brown" 9111111111))
; predicate >>
(person? person-ex)
; selectors >>
(person-name person-ex)
(person-hair person-ex)
(person-eyes person-ex)
(person-phone person-ex)


(define-struct pet [name number])

; constructor >>
(define pet-ex (make-pet "nero" 1))
; predicate >>
(pet? pet-ex)
; selectors >>
(pet-name pet-ex)
(pet-number pet-ex)


(define-struct CD [artist title price])

; constructor >>
(define CD-ex (make-CD "Pink Floyd" "Animals" 19.99))
; predicate >>
(CD? CD-ex)
; selectors >>
(CD-artist CD-ex)
(CD-title CD-ex)
(CD-price CD-ex)

(define-struct sweater [material size producer])

; constructor >>
(define sweater-ex (make-sweater "Wool" "L" "Lacoste"))
; predicate >>
(sweater? sweater-ex)
; selectors >>
(sweater-material sweater-ex)
(sweater-size sweater-ex)
(sweater-producer sweater-ex)