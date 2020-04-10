;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 365ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 365
;; ------------
;; Interpret the following elements of Xexpr.v2 as XML data:
;;
;; 1. '(server ((name "example.org")))
;;
;; 2. '(carcas (board (grass)) (player ((name "sam"))))
;;
;; 3. '(start)
;;
;; Which ones are elements of Xexpr.v0 or Xexpr.v1?
;; -----------------------------------------------------------------------------

; An Xexpr.v0 (short for X-expression) is a one-item list:
;   (cons Symbol '())


; An Xexpr.v1 is a list:
;   (cons Symbol [List-of Xexpr.v1])


; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

;; -----------------------------------------------------------------------------


; 1. '(server ((name "example.org")))
; 
; <server name = "example.org"/> 

; can only be represented only using Xexpr.v2

; 2. '(carcas (board (grass)) (player ((name "sam"))))
; 
; <carcas>
;   <board>
;     <grass />
;   </board>
;   <player name = "sam" />
; <carcas />

; can only be represented using Xexpr.v2


; 3. '(start)
; 
; <start />

; can represent this using Xexpr.v0 and Xexpr.v1