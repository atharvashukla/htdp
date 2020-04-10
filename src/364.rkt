;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 364ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 364
;; ------------
;; Represent this XML data as elements of Xexpr.v2:
;;
;; 1. <transition from="seen-e" to="seen-f" />
;; 2. <ul><li><word /><word /></li><li><word /></li></ul>
;;
; Which one could be represented in Xexpr.v0 or Xexpr.v1?
;; -----------------------------------------------------------------------------

; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


; <transition from="seen-e" to="seen-f" />

(define attribute-from (cons 'from (cons "seen-e" '())))
(define attribute-to (cons 'to (cons "seen-f" '())))
(define attribute-list-1 (list attribute-from attribute-to))
(define xexpr-1 (cons 'transition attribute-list-1))


;  <ul>
;    <li>
;      <word />
;      <word />
;    </li>
;    <li>
;      <word />
;    </li>
;  </ul>

(define xexpr-2 '(ul (li (word) (word)) (li (word))))

;; -----------------------------------------------------------------------------

; An Xexpr.v0 (short for X-expression) is a one-item list:
;   (cons Symbol '())

; An Xexpr.v1 is a list:
;   (cons Symbol [List-of Xexpr.v1])


; `xexpr-2` could be represented using Xexpr.v1
; it's sub-xexpr - '(word) - could be represented using Xexpr.v0
; `xexpr-1` cannot be represented using either because it has an
; attribute list.