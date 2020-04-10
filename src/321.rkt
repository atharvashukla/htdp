;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 321ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; =============================================================================

#|
+----------------------------------------------------------------------------+
| Exercise 321                                                               |
| ------------                                                               |
| Abstract the data definitions for S-expr and SL so that they abstract over |
| the kinds of Atoms that may appear.                                        |
+----------------------------------------------------------------------------+
|#


; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)
          

; An Atom is one of: 
; – Any
