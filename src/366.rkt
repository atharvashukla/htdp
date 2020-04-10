;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 366ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 366
;; ------------
;; Design xexpr-name and xexpr-content.
;; ----------------------------------------------------------------------------- 

; An Xexpr.v2 is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr.v2]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

(define a0 '((initial "X")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

; Xexpr.v2 -> Symbol
; the tag of the element representation
(check-expect (xexpr-name e0) 'machine)
(check-expect (xexpr-name e1) 'machine)
(define (xexpr-name x)
  (first x))

; Xexpr.v2 -> [List-of Content]
; list of content elements

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) (list (list 'action)))
(check-expect (xexpr-content e3) (list (list 'action)))
(check-expect (xexpr-content e4) (list (list 'action) (list 'action)))

(define (xexpr-content xe)
  (local ((define optional-loa+content
            (rest xe) ; : [[List-of Xexpr.v2] U (cons [List-of Attribute] [List-of Xexpr.v2])]
            ))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content) ; : [Xexpr.v2 U [List-of Attribute]
                 ))
         (if (list-of-attributes? loa-or-x)
             (rest optional-loa+content)
             optional-loa+content))])))

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is x a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute
               (first x) ; : [Symbol U (cons Symbol (cons String '()))]
               ))
       (cons? possible-attribute))]))
