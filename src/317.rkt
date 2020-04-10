;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 317ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; ==============================================================================

#|
+-----------------------------------------------------------------------------+
| Exercise 317.                                                               |
| +-----------+                                                               |
| A program that consists of three connected functions ought to express this  |
| relationship with a local expression.                                       |
|                                                                             |
| Copy and reorganize the program from figure 117 into a single function      |
| using local. Validate the revised code with the test suite for count.       |
|                                                                             |
| The second argument to the local functions, sy, never changes. It is always |
| the same as the original symbol. Hence you can eliminate it from the local  |
| function definitions to tell the reader that sy is a constant across the    |
| traversal process.                                                          |
+-----------------------------------------------------------------------------+
|#

; An S-expr is one of: 
; – Atom
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)
          

; An Atom is one of: 
; – Number
; – String
; – Symbol 


(check-expect (count 'sym 'sym) 1)
(check-expect (count 'wer 'sym) 0)
(check-expect (count "apple" 'sym) 0)
(check-expect (count 1232 'sym) 0)
(check-expect (count '(sym) 'sym) 1)
(check-expect (count '("apple") 'sym) 0)
(check-expect (count '(1232) 'sym) 0)
(check-expect (count '(apple (sym sym)) 'sym) 2)
(check-expect (count '(((sym)) sym) 'sym) 2)
(check-expect (count '(sym sym sym) 'sym) 3)

; S-exp -> Boolean
;; counts all occurrences of sy in s-exp
(define (count s-exp sy)
  (local (;; Any -> Boolean
          ;; is the x an atom?
          (define (atom? x)
            (not (list? x)))

          ; S-expr Symbol -> N 
          ; counts all occurrences of sy in sexp 
          (define (count-l sexp)
            (cond
              [(atom? sexp) (count-atom sexp)]
              [else (count-sl sexp)]))
 
          ; SL Symbol -> N 
          ; counts all occurrences of sy in sl 
          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else
               (+ (count-l (first sl)) (count-sl (rest sl)))]))
 
          ; Atom Symbol -> N 
          ; counts all occurrences of sy in at 
          (define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)])))

    (count-l s-exp)))