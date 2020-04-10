;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 371ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 371
;; ------------
;; Refine the definition of Xexpr so that you can represent XML elements,
;; including items in enumerations, that are plain strings.
;; -----------------------------------------------------------------------------

; An Xexpr is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; An XWord is '(word ((text String)))



; Xexpr
; == {2nd clause of the def of Xexpr}
; (cons Symbol (cons [List-of Attribute] Body))
; == {Def body}
; (cons Symbol (cons [List-of Attribute] [List-of Xexpr])
; == {assuming the body is empty}
; (cons Symbol (cons [List-of Attribute] '()) 
; == {rewriting cons as list}
; (cons Symbol (list [List-of Attribute])
; == {def Attribtue}
; (cons Symbol (list [List-of (cons Symbol (cons String '()))])
; == {assuming the attribute list has only 1 attribute}
; (cons Symbol (list (list (cons Symbol (cons String '()))))
; == {rewriting cons as list}
; (cons Symbol (list (list (list Symbol String))))
; == {rewriting cons as list}
; (list Symbol (list (list Symbol String)))
; == {rewriting list as quote}
; '(Symbol ((Symbol String)))
; == {substituting word for the first symbol and text for the next}
; '(word ((text String)))
; == {def Xword}
; XWord

; Therefore XWord is an Xexpr. QED.


; So I don't see what refinement is needed in the data
; definition of Xexpr since XWord is already a member of it.
