;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 240ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 240
;; ------------
;; Here are two strange but similar data definitions:
;; 
;;    ; An LStr is one of: 
;;    ; – String
;;    ; – (make-layer LStr)
;;        
;;    
;;    ; An LNum is one of: 
;;    ; – Number
;;    ; – (make-layer LNum)
;;
;; Both data definitions rely on this structure-type definition:
;;
;;    (Define-struct layer [stuff])
;;
;; Both define nested forms of data: one is about numbers and the other about
;; trings. Make examples for both. Abstract over the two. Then instantiate the
;; abstract definition to get back the originals. 
;; -----------------------------------------------------------------------------

(define-struct layer [stuff])

; An LStr is one of: 
; – String
; – (make-layer LStr)

(define lstr1 "hello")
(define lstr2 (make-layer lstr1))
(define lstr3 (make-layer lstr2))
    
; An LNum is one of: 
; – Number
; – (make-layer LNum)

(define lnum1 1)
(define lnum2 (make-layer lnum1))
(define lnum3 (make-layer lnum2))

; TODO: 
; 1. make examples
; 2. abstract
; 3. get original again

; --------------------------------------------------

; An LItem is one of:
; - ITEM
; - (make-layer LItem)

(define litem1 "hello")
(define litem2 (make-layer litem1))
(define litem3 (make-layer litem2))

(define litem4 1)
(define litem5 (make-layer litem4))
(define litem6 (make-layer litem5))

; --------------------------------------------------

; TESTS

(check-expect lstr1 litem1)
(check-expect lstr2 litem2)
(check-expect lstr3 litem3)

(check-expect lnum1 litem4)
(check-expect lnum2 litem5)
(check-expect lnum3 litem6)