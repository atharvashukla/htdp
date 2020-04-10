;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 318ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; ==============================================================================

#|
+--------------------------------------------------------------------------+
| Exercise 318.                                                            |
| ------------                                                             |
| Design depth. The function consumes an S-expression and determines its   |
| depth. An Atom has a depth of 1. The depth of a list of S-expressions is |
| the maximum depth of its items plus 1.                                   |
+--------------------------------------------------------------------------+
|#


;; templates:

#;
(define (func sexp)
(cond
[(atom? sexp) (func-atom sexp)]
[else (func-sl sexp)]))

#;
(define (func-sl sl)
(cond
[(empty? sl) ...]
[else (... (func (first sl)) ... (func-sl (rest sl)) ...)]))
          
#;
(define (func-atom at)
(cond
[(number? at) ...]
[(string? at) ...]
[(symbol? at) ...]))


(define (atom? x)
  (not (list? x)))


(check-expect (depth 'sym) 1)
(check-expect (depth "str") 1)
(check-expect (depth 123) 1)
(check-expect (depth '(1 2 3)) 4)
(check-expect (depth '((1) (2) (3))) 7)


;; S-exp -> Number
;; calculates the depth of s-exp
(define (depth sexp)
  (local
    (
     ;; S-exp -> Number
     ;; the depth of this atom at
     (define (depth-atom at)
       (cond
         [(number? at) 1]
         [(string? at) 1]
         [(symbol? at) 1]))
     ;; S-exp -> Number
     ;; the depth of this s-list
     (define (depth-sl sl)
       (cond
         [(empty? sl) 1]
         [else (+ (depth (first sl))
                  (depth (rest sl)))]))
     ;; S-exp -> Number
     ;; the depth of s expression sexp
     (define (depth-sexp sexp)
       (cond
         [(atom? sexp) (depth-atom sexp)]
         [else (depth-sl sexp)])))
    (depth-sexp sexp)))



