;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 487ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 487
;; ------------
;; Consider the functions f(n) = 2n and g(n) = 1000 n. Show that g belongs to
;; O(f), which means that f is, abstractly speaking, more (or at least equally)
;; expensive than g. If the input size is guaranteed to be between 3 and 12,
;; which function is better?
;; -----------------------------------------------------------------------------