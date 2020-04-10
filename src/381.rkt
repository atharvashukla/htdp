;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 381ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 381
;; ------------
;; The definitions of XMachine and X1T use quote, which is highly inappropriate
;; for novice program designers. Rewrite them first to use list and then cons.
;; -----------------------------------------------------------------------------


; An XMachine is a nested list of this shape:
;   (list machine (list (list initial FSM-State)) [List-of X1T])
; An X1T is a nested list of this shape:
;   (list action (list (list state FSM-State) (list next FSM-State)))
