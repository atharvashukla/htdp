;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 367ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 367
;; ------------
;; The design recipe calls for a self-reference in the template for xexpr-attr.
;; Add this self-reference to the template and then explain why the finished
;; parsing function does not contain it.
;; -----------------------------------------------------------------------------


; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))


(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) ...]
      [else (... (first optional-loa+content)
             ... (rest optional-loa+content) ...)])))


; we don't know if the "(rest optional-loa+content)" is a Body or a
; (cons [List-of Attribute] Body), so we don't put a self-reference yet.
; moreover, the job of xexpr-attr is to extract the list of attribute
; not traverse the whole structure. 