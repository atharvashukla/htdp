;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 319ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

; =============================================================================

#|
+---------------------------------------------------------------------------+
| Exercise 319                                                              |
| ------------                                                              |
| Design substitute. It consumes an S-expression s and two symbols, old and |
| new. The result is like s with all occurrences of old replaced by new.    |
+---------------------------------------------------------------------------+
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

;; Any -> Boolean
;; is the x an atom?
(define (atom? x)
  (not (list? x)))


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

(check-expect (substitute '((((1)))) 1 2) '((((2)))))


(define (substitute sexp old new)
  (local
    (;; S-exp -> S-exp
     ;; substitutes the old with new in at
     (define (subs-atom at old new)
       (if  (equal? old at)
           new
           old))


     ;; S-exp -> S-exp
     ;; substitutes the old with new in sl
     (define (subs-sl sl old new)
       (cond
         [(empty? sl) sl]
         [else (cons (subs-sexp (first sl) old new)
                     (subs-sexp (rest sl) old new))]))

     ;; S-exp -> S-exp
     ;; substitutes the old with new in sexp
     (define (subs-sexp sexp old new)
       (cond
         [(atom? sexp) (subs-atom sexp old new)]
         [else (subs-sl sexp old new)])))
    (subs-sexp sexp old new)))
