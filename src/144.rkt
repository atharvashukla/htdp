;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 144ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 144.
;; -------------
;; Will sum and how-many work for NEList-of-temperatures even though they are
;; designed for inputs from List-of-temperatures? If you think they don’t work,
;; provide counter-examples. If you think they would, explain why.
;; -----------------------------------------------------------------------------

;; sum and how-many will work for NEList-of-temperatures even though they
;; are designed for List-of-temperatures because

;; NEList-of-temperatures is a subset of List-of-temperatures.