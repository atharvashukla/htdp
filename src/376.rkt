;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 376ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 376
;; ------------
;; Design a program that counts all "hello"s in an instance of XEnum.
;; -----------------------------------------------------------------------------

; An Xexpr is a list: 
; – (cons Symbol Body)
; – (cons Symbol (cons [List-of Attribute] Body))
; where Body is short for [List-of Xexpr]
; An Attribute is a list of two items:
;   (cons Symbol (cons String '()))

; An XWord is '(word ((text String)))

; An XItem is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
; – (cons 'li (cons XEnum '()))
; – (cons 'li (cons [List-of Attribute] (cons XEnum '())))
; 
; An XEnum is one of:
; – (cons 'ul [List-of XItem])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem]))

;; -----------------------------------------------------------

;; selectors, predicates:

; word? : Any -> Boolean
; word-text : XWord -> String
; xexpr-name : Xexpr -> Symbol
; xexpr-content : Xexpr -> [List-of Content]
; xexpr-attr : [List-of Attribute]
; list-of-attributes? : [List-of Attribute] or Xexpr -> Boolean


; XEnum -> ???
; ...
(define (xenum-temp xe)
  (... ... (xexpr-name xe) ... ; 'ul
       ... (loxi-temp (xexpr-content xe)) ...
       ... (loa-temp (xexpr-attr xe)) ...))

; XWord or XEnum -> ???
; ...
(define (xw-or-xe-temp xw-or-xe)
  (cond
    [(word? xw-or-xe) (xword-temp xw-or-xe )]
    [else (xenum-temp xw-or-xe)]))

; XWord -> ???
; ...
(define (xword-temp xw)
  (... (xexpr-name xw) ... (xword-textr xw) ...))

; XItem -> ???
; ...
(define (xitem-temp xi)
  (... ... (xexpr-name xe) ... ; 'li
       ... (xw-or-xe-temp (first (xexpr-content xe))) ...
       ... (loa-temp (xexpr-attr xe)) ...))

; Attribute -> ???
; ...
(define (attr-temp a)
  (... (first a) ... (second a) ...))


; [List-of Attribute] -> ???
; ...
(define (loa-temp loa)
  (cond
    [(empty? loa) ...]
    [else (... (attr-temp (first loa)) ... (loa-temp (rest loa)))]))


; [List-of XItem] -> ???
; ...
(define (loxi-temp loxi)
  (cond
    [(empty? loxi) ...]
    [else (... (xitem-temp (first loxi)) ... (loxi-temp (rest loxi)) ...)]))

;; -----------------------------------------------------------------------------


(define ex1
  `(ul
    (li (word ((text "hello"))))
    (li (word ((text "gello"))))))

(define ex2
  `(ul
    (li ,ex1)
    (li ,ex1)))


;; design decision: ignore the "hello"s in
;; the string associated with an Attribute



; XEnum -> Number
; count "hello"s in an XEnum

(check-expect (xenum-count-hello ex1) 1)
(check-expect (xenum-count-hello ex2) 2)

(define (xenum-count-hello xe)
  (loxi-count-hello (xexpr-content xe)))

; XWord or XEnum -> Number
; count "hello"s in an  XWord orXEnum 
(define (xw-or-xe-count-hello xw-or-xe)
  (cond
    [(word? xw-or-xe) (xword-count-hello xw-or-xe)]
    [else (xenum-count-hello xw-or-xe)]))

; XWord -> Number
; count "hello"s in an XWord 
(define (xword-count-hello xw)
  (if (string=? (word-text xw) "hello")
      1
      0))

; XItem -> Number
; count "hello"s in an XItem 
(define (xitem-count-hello xi)
  (xw-or-xe-count-hello (first (xexpr-content xi))))

; [List-of XItem] -> Number
; count "hello"s in an  [List-ofXItem] 
(define (loxi-count-hello loxi)
  (cond
    [(empty? loxi) 0]
    [else (+ (xitem-count-hello (first loxi)) (loxi-count-hello (rest loxi)))]))



;; -----------------------------------------------------------------------------

; Any -> Boolean
; a recognizer fo XWords

(check-expect (word? '(word ((text "2")))) #true)
(check-expect (word? '(word ((text "2") (text "more")))) #false)

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


;; -----------------------------------------------------------------------------


(define a0 '((initial "X")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

; Xexpr -> Symbol
; the tag of the element representation
(check-expect (xexpr-name e0) 'machine)
(check-expect (xexpr-name e1) 'machine)
(define (xexpr-name x)
  (first x))

; Xexpr -> [List-of Content]
; list of content elements

(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) (list (list 'action)))
(check-expect (xexpr-content e3) (list (list 'action)))
(check-expect (xexpr-content e4) (list (list 'action) (list 'action)))

(define (xexpr-content xe)
  (local ((define optional-loa+content
            (rest xe) ; : [[List-of Xexpr] U (cons [List-of Attribute] [List-of Xexpr])]
            ))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content) ; : [Xexpr U [List-of Attribute]
                 ))
         (if (list-of-attributes? loa-or-x)
             (rest optional-loa+content)
             optional-loa+content))])))

(check-expect (xexpr-attr e0) '())
(check-expect (xexpr-attr e1) '((initial "X")))
(check-expect (xexpr-attr e2) '())
(check-expect (xexpr-attr e3) '())
(check-expect (xexpr-attr e4) '((initial "X")))

; [List-of Attribute] or Xexpr -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attr xe)
  (local ((define optional-loa+content
            (rest xe) ; : [[List-of Xexpr] U (cons [List-of Attribute] [List-of Xexpr])]
            ))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content) ; : [Xexpr U [List-of Attribute]
                 ))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()
             ))])))

; [List-of Attribute] or Xexpr -> Boolean
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