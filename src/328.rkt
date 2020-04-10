;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 328ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+--------------------------------------------------------------------------------+
| Exercise 328.                                                                  |
| -------------                                                                  |
| Copy and paste figure 120 into DrRacket; include your test suite. Validate the |
| test suite. As you read along the remainder of this section, perform the edits |
| and rerun the test suites to confirm the validity of our arguments.            |
+--------------------------------------------------------------------------------+
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


; S-expr Symbol Atom -> S-expr
; replaces all occurrences of old (symbol) in sexp with new
 
(check-expect (substitute '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))

(check-expect (substitute '((((one)))) 'one 'two) '((((two)))))

;; contract violation : (added for code coverage)...hmm? 
(check-expect (substitute '((((1)))) 1 2) '((((1)))))
(check-expect (substitute '(((("1")))) "1" "2") '(((("1")))))

;; VERSION 1

(define (substitute sexp old new)
  (local (; S-expr -> S-expr
          (define (for-sexp sexp)
            (cond
              [(atom? sexp) (for-atom sexp)]
              [else (for-sl sexp)]))
          ; SL -> S-expr 
          (define (for-sl sl)
            (cond
              [(empty? sl) '()]
              [else (cons (for-sexp (first sl))
                          (for-sl (rest sl)))]))
          ; Atom -> S-expr
          (define (for-atom at)
            (cond
              [(number? at) at]
              [(string? at) at]
              [(symbol? at) (if (equal? at old) new at)])))
    (for-sexp sexp)))

;; VERSION 2.. MAPPING IN SL

(define (substitute.v2 sexp old new)
  (local (; S-expr -> S-expr
          (define (for-sexp sexp)
            (cond
              [(atom? sexp) (for-atom sexp)]
              [else (for-sl sexp)]))
          ; SL -> S-expr 
          (define (for-sl sl)
            (map for-sexp sl))
          ; Atom -> S-expr
          (define (for-atom at)
            (cond
              [(number? at) at]
              [(string? at) at]
              [(symbol? at) (if (equal? at old) new at)])))
    (for-sexp sexp)))

(check-expect (substitute.v2 '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))

(check-expect (substitute.v2 '((((one)))) 'one 'two) '((((two)))))

;; contract violation : (added for code coverage)...hmm? 
(check-expect (substitute.v2 '((((1)))) 1 2) '((((1)))))
(check-expect (substitute.v2 '(((("1")))) "1" "2") '(((("1")))))

;; VERSION 3.. INLINING ATOM

(define (substitute.v3 sexp old new)
  (local (; S-expr -> S-expr
          (define (for-sexp sexp)
            (cond
              [(atom? sexp) (for-atom sexp)]
              [else (for-sl sexp)]))
          ; SL -> S-expr 
          (define (for-sl sl) (map for-sexp sl))
          ; Atom -> S-expr
          (define (for-atom at)
            (if (equal? at old) new at)))
    (for-sexp sexp)))

(check-expect (substitute.v3 '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))

(check-expect (substitute.v3 '((((one)))) 'one 'two) '((((two)))))

;; VERSION 4... ONE FUNC IN LOCAL

(define (substitute.v4 sexp old new)
  (local (; S-expr -> S-expr
          (define (for-sexp sexp)
            (cond
              [(atom? sexp)
               (if (equal? sexp old) new sexp)]
              [else
               (map for-sexp sexp)])))
    (for-sexp sexp)))

(check-expect (substitute.v4 '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))

(check-expect (substitute.v4 '((((one)))) 'one 'two) '((((two)))))


;; VERSION 5

(define (substitute-final sexp old new)
  (cond
    [(atom? sexp) (if (equal? sexp old) new sexp)]
    [else
     (map (lambda (s) (substitute-final s old new)) sexp)]))



(check-expect (substitute-final '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))

(check-expect (substitute-final '((((one)))) 'one 'two) '((((two)))))