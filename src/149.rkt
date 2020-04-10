;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 149ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 149.
;; -------------
;; Does copier function properly when you apply it to a natural number and a
;; Boolean or an image? Or do you have to design another function? Read
;; Abstraction for an answer.
;;
;; An alternative definition of copier might use else:
;;
;;    (define (copier.v2 n s)
;;      (cond
;;        [(zero? n) '()]
;;        [else (cons s (copier.v2 (sub1 n) s))]))
;;
;; How do copier and copier.v2 behave when you apply them to 0.1 and "x"?
;; Explain. Use DrRacket’s stepper to confirm your explanation. 
;; -----------------------------------------------------------------------------

; N String -> List-of-strings 
; creates a list of n copies of s (make-list n s)
 
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
 
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))

;; Exercise 149

(check-expect (copier.v2 0 "hello") '())
(check-expect (copier.v2 2 "hello")
              (cons "hello" (cons "hello" '())))

(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))

;; How do copier and copier.v2 behave whe you apply them to 0.1 and "x"? Explain.
;; Use DrRacket's stepper to confirm your explaination.▮


; (copier 0.1 "hello")
; ==> cond: all question results were false
;     [not zero AND not positive, plus contract violation]

; (copier.v2 0.1 "hello")
; ==> does not terminate