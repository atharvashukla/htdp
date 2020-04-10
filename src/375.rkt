;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 375ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 375
;; ------------
;; The wrapping of cond with
;;
;;    (beside/align 'center BT ...)
;;
;; may surprise you. Edit the function definition so that the wrap-around
;; appears once in each clause. Why are you confident that your change works?
;; Which version do you prefer?
;; -----------------------------------------------------------------------------

; An Xexpr is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; An XWord is '(word ((text String)))

; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (list XWord)))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (list XEnum.v2)))
; 
; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))

;; -----------------------------------------------------------

(require 2htdp/image)

(define SIZE 12) ; font size 
(define COLOR "black") ; font color 
(define BT ; a graphical constant 
  (beside (circle 1 'solid 'black) (text " " SIZE COLOR)))

(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

(define e0-nested
  `(ul
    (li ,e0)
    (li ,e0)))

(define e0-rendered
  (above/align
   'left
   (beside/align 'center BT (text "one" 12 'black))
   (beside/align 'center BT (text "two" 12 'black))))
 
; Image -> Image
; marks item with bullet

(check-expect (bulletize (text "hello" 12 "black"))
              (beside BT (text "hello" 12 "black") ))

(define (bulletize item)
  (beside/align 'center BT item))
 
; XEnum.v2 -> Image
; renders an XEnum.v2 as an image

(check-expect (render-enum e0) e0-rendered)

(check-expect (render-enum e0-nested)
              (local ((define a (bulletize (above/align 'left e0-rendered empty-image)))
                      (define b (bulletize (above/align 'left e0-rendered empty-image))))
                (above/align 'left a b)))

(define (render-enum xe)
  (local ((define content (xexpr-content xe))
          ; XItem.v2 Image -> Image 
          (define (deal-with-one item so-far)
            (above/align 'left (render-item item) so-far)))
    (foldr deal-with-one empty-image content)))
 
; XItem.v2 -> Image
; renders one XItem.v2 as an image 
(define (render-item an-item)
  (local ((define content (first (xexpr-content an-item))))
    (cond
      [(word? content)
       (bulletize (text (word-text content) SIZE 'black))]
      [else (bulletize (render-enum content))])))

;; -----------------------------------------------------------------------------


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

; Any -> Boolean
; a recognizer fo XWords

(check-expect (word? #false) #false)
(check-expect (word? "hello") #false)
(check-expect (word? 'sym) #false)
(check-expect (word? '()) #false)
(check-expect (word? '(1 2 3)) #false)
(check-expect (word? '(word word word)) #false)
(check-expect (word? '(word 2)) #false)
(check-expect (word? '(word ())) #false)
(check-expect (word? '(word (1 2))) #false)
(check-expect (word? '(word ((1 2)))) #false)
(check-expect (word? '(word ((text 2)))) #false)
(check-expect (word? '(word ((text "2")))) #true)
(check-expect (word? '(word ((text "2") (text "more")))) #false)
(check-expect (word? '(word ((text "2")))) #true)

(define (word? a)
  (and (list? a)
       (= (length a) 2)
       (equal? 'word (first a))
       (list? (second a))
       (= (length (second a)) 1)
       (list? (first (second a)))
       (= 2 (length (first (second a))))
       (equal? 'text (first (first (second a))))
       (string? (second (first (second a))))))

; XWord -> String
; extracts the text of the word w

(check-expect (word-text '(word ((text "indore")))) "indore")

(define (word-text w)
  (second (first (second w))))


;; I'm confident that my change will work because there is not recursice call
;; to the same function, so the result remains the same on each call