;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 178ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 178.
;; ------------
;; Explain why the template for editor-kh deals with "\t" and "\r" before it
;; checks for strings of length 1.
;; -----------------------------------------------------------------------------

; Because these are strings of length one, but we want to deal with them
; differently

(= (string-length "\t") 1)
; == #true

(= (string-length "\r") 1)
; == #true