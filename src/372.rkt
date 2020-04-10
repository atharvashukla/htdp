;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 372ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 372
;; ------------
;; Before you read on, equip the definition of render-item1 with tests. Make
;; sure to formulate these tests in such a way that they don’t depend on the BT
;; constant. Then explain how the function works; keep in mind that the purpose
;; statement explains what it does.
;; -----------------------------------------------------------------------------

(require 2htdp/image)

; An Xexpr is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; An XWord is '(word ((text String))).

; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons Attributes [List-of XItem.v1]))
; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons Attributes (cons XWord '())))

(define sq (square 15 "solid" "white"))
(define BT (overlay (circle 2 "solid" "black")
                    sq))


(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

(define e0-rendered
  (above/align
   'left
   (beside/align 'center BT (text "one" 12 'black))
   (beside/align 'center BT (text "two" 12 'black))))

; XItem.v1 -> Image 
; renders an item as a "word" prefixed by a bullet

(check-expect (render-item1 '(li (word ((text "one")))))
              (beside/align 'center BT (text "one" 12 'black)))

(define (render-item1 i) ; steps:
  (local ((define content (xexpr-content i)) ; extracts the Body of the Xexpr
          (define element (first content)) ; extracts the first Xexpr in body
          (define a-word (word-text element)) ; extracts the string of the word
          (define item (text a-word 12 'black))) ; make a text from the string
    (beside/align 'center BT item))) ; put the text beside a bullet

; How can I make the tests not depend on the BT constant?
;; -----------------------------------------------------------------------------
;; From Exercise 366

(define a0 '((initial "X")))
 
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

; Xexpr.v2 -> Symbol
; the tag of the element representation

(check-expect (xexpr-name e1) 'machine)

(define (xexpr-name x)
  (first x))

; Xexpr.v2 -> [List-of Content]
; list of content elements

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


;; -----------------------------------------------------------------------------
;; From Exercise 370

(define w1 '(word ((text "indore"))))

; XWord -> String
; extracts the text of the word w

(check-expect (word-text w1) "indore")

(define (word-text w)
  (second (first (second w))))
