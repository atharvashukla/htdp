;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 148ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 148.
;; -------------
;; Compare the function definitions from this section (sum, how-many, all-true,
;; one-true) with the corresponding function definitions from the preceding
;; sections. Is it better to work with data definitions that accommodate empty
;; lists as opposed to definitions for non-empty lists? Why? Why not?
;; -----------------------------------------------------------------------------


;; It's easier to work with data definitions that work with Non-empty lists
;; The domain of the function is clear. 