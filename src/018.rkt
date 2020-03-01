;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |018|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Exercise 18.
; ------------
;
; Define the function string-join, which consumes two strings and appends them
; with "_" in between. See exercise 2 for ideas. 
;
; ----------------------------------------------------------------------------


(define (string-join pre-str post-str)
  (string-append pre-str "_" post-str))

(string-join "atharva" "shukla")
; => "atharva_shukla"

(string-join "charvie" "shukla")
; => "charvie_shukla"