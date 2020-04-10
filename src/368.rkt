;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 368ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 368
;; ------------
;; Formulate a data definition that replaces the informal “or” signature for the
;; definition of the list-of-attributes? function.
;; -----------------------------------------------------------------------------


; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


; list-of-attributes? : [List-of Attribute] or Xexpr.v2 -> Boolean

; LoAttrOrXexpr is one of:
; - [List-of Attribute]
; - Xexpr.v2

; list-of-attributes? : LoAttrOrXexpr -> Boolean

