;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 383ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 383
;; ------------
;; Run the code in figure 130 with the BW Machine configuration from exercise
;; 382. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

; An FSM is a [List-of 1Transition]
; A 1Transition is a list of two items:
;   (cons FSM-State (cons FSM-State '())
; An FSM-State is a String that specifies a color
 
; data examples 
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))
 
; FSM FSM-State -> FSM-State 
; matches the keys pressed by a player with the given FSM 
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw
     (lambda (current)
       (overlay (text current 24 "gray")
                (square 100 "solid" current)))]
    [on-key
     (lambda (current key-event)
       (find transitions current))]))
 
; [X Y] [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in alist

(check-expect (find fsm-traffic "red") "green")
(check-error (find fsm-traffic "purple"))

(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))

;; -----------------------------------------------------------------------------

(define xm0
  '(machine ((initial "red"))
            (action ((state "red") (next "green")))
            (action ((state "green") (next "yellow")))
            (action ((state "yellow") (next "red")))))


; XMachine -> FSM-State 
; interprets the given configuration as a state machine 
(define (simulate-xmachine xm)
  (simulate (xm-state0 xm) (xm->transitions xm)))
 
; XMachine -> FSM-State 
; extracts and translates the transition table from xm0
 
(check-expect (xm-state0 xm0) "red")
 
(define (xm-state0 xm0)
  (find-attr (xexpr-attr xm0) 'initial))
 
; XMachine -> [List-of 1Transition]
; extracts the transition table from xm
 
(check-expect (xm->transitions xm0) fsm-traffic)
 
(define (xm->transitions xm)
  (local (; X1T -> 1Transition
          (define (xaction->action xa)
            (list (find-attr (xexpr-attr xa) 'state)
                  (find-attr (xexpr-attr xa) 'next))))
    (map xaction->action (xexpr-content xm))))


; Figure 130: Interpreting a DSL program


;; -----------------------------------------------------------------------------

; [List-of Attributes] Attribute -> Attribute
(define (find-attr atl attr-sym)
  (second (first (filter (λ (attr) (equal? (first attr) attr-sym))
                         atl))))

; [List-of Attribute] or Xexpr.v2 -> [List-of Attribtue]
; extracts the attr list of the xexpr
(define (xexpr-attr xe)
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
             loa-or-x
             '()
             ))])))

; Xexpr.v2 -> [List-of Content]
; list of content elements
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

(define xm1
  '(machine ((initial "black"))
            (action ((state "black") (next "white")))
            (action ((state "white") (next "black")))))

(simulate-xmachine xm1)