;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 320ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
 
; =============================================================================

#|
+----------------------------------------------------------------------------+
| Exercise 320                                                               |
| ------------                                                               |
| Reformulate the data definition for S-expr so that the first clause is     |
| expanded into the three clauses of Atom and the second clause uses the     |
| List-of abstraction. Redesign the count function for this data definition. |
+----------------------------------------------------------------------------+
|#

;; Any -> Boolean
;; is the x an atom?
(define (atom? x)
  (not (list? x)))

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

;; templates:


(define (func-sexp-v0 sexp)
  (cond
    [(atom? sexp) (func-atom-v0 sexp)]
    [else (func-sl-v0 sexp)]))


(define (func-sl-v0 sl)
  (cond
    [(empty? sl) ...]
    [else (... (func-sexp-v0 (first sl)) ... (func-sl-v0 (rest sl)) ...)]))
          

(define (func-atom-v0 at)
  (cond
    [(number? at) ...]
    [(string? at) ...]
    [(symbol? at) ...]))

;  |
;  |
;  v

; An S-expr is one of: 
; – Number
; – String
; – Symbol
; – SL
 
; An SL is one of: 
; – '()
; – (cons S-expr SL)


;; templates:


(define (func-sexp-v1 sexp)
  (cond
    [(atom? sexp) (func-atom-v1 sexp)]
    [else (func-sl-v1 sexp)]))


(define (func-sl-v1 sl)
  (cond
    [(empty? sl) ...]
    [else (... (func-sexp-v1 (first sl)) ... (func-sl-v1 (rest sl)) ...)]))
          

(define (func-atom-v1 at)
  (cond
    [(number? at) ...]
    [(string? at) ...]
    [(symbol? at) ...]))


;; implementing count:

(check-expect (count-v1 'sym 'sym) 1)
(check-expect (count-v1 'wer 'sym) 0)
(check-expect (count-v1 "apple" 'sym) 0)
(check-expect (count-v1 1232 'sym) 0)
(check-expect (count-v1 '(sym) 'sym) 1)
(check-expect (count-v1 '("apple") 'sym) 0)
(check-expect (count-v1 '(1232) 'sym) 0)
(check-expect (count-v1 '(apple (sym sym)) 'sym) 2)
(check-expect (count-v1 '(((sym)) sym) 'sym) 2)
(check-expect (count-v1 '(sym sym sym) 'sym) 3)

(define (count-v1 sexp sy)
  (local (
          (define (count-sexp-v1 sexp)
            (cond
              [(atom? sexp) (count-atom-v1 sexp)]
              [else (count-sl-v1 sexp)]))
          
          (define (count-sl-v1 sl)
            (cond
              [(empty? sl) 0]
              [else (+ (count-sexp-v1 (first sl)) (count-sl-v1 (rest sl)) )]))

          (define (count-atom-v1 at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)])))
    (count-sexp-v1 sexp)))

          
  

;------------------------------

;  |
;  |
;  v

; An S-expr is one of:
; – Number
; – String
; – Symbol
; - [List-of S-expr]

(check-expect (count-v2 'sym 'sym) 1)
(check-expect (count-v2 'wer 'sym) 0)
(check-expect (count-v2 "apple" 'sym) 0)
(check-expect (count-v2 1232 'sym) 0)
(check-expect (count-v2 '(sym) 'sym) 1)
(check-expect (count-v2 '("apple") 'sym) 0)
(check-expect (count-v2 '(1232) 'sym) 0)
(check-expect (count-v2 '(apple (sym sym)) 'sym) 2)
(check-expect (count-v2 '(((sym)) sym) 'sym) 2)
(check-expect (count-v2 '(sym sym sym) 'sym) 3)


(define (count-v2 s-exp sy)
  (cond
    [(empty? s-exp)  0]
    [(string? s-exp) 0]
    [(number? s-exp) 0]
    [(symbol? s-exp) (if (symbol=? s-exp sy) 1 0)]
    [else (+ (count-v2 (first s-exp) sy) (count-v2 (rest s-exp) sy))]))
