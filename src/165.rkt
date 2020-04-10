;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 165ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 165
;; ------------
;; Design the function subst-robot, which consumes a list of toy descriptions
;; (one-word strings) and replaces all occurrences of "robot" with "r2d2"; all
;; other descriptions remain the same.
;; 
;; Generalize subst-robot to substitute. The latter consumes two strings, called
;; new and old, and a list of strings. It produces a new list of strings by
;; substituting all occurrences of old with new.
;; -----------------------------------------------------------------------------

;; String -> String
;; converts the "robot" to "r2d2"
(define (convert-one-robot rbt)
  (cond
    [(string=? "robot" rbt) "r2d2"]
    [else rbt]))

(check-expect (convert-one-robot "robot") "r2d2")
(check-expect (convert-one-robot "") "")
(check-expect (convert-one-robot "rooboot") "rooboot")

;; List-of-strings -> List-of-strings
;; converts all "robots" in los to "r2d2"
(define (subst-robot lor)
  (cond
    [(empty? lor) '()]
    [else (cons (convert-one-robot (first lor))
                (subst-robot (rest lor)))]))

(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "robot" '())) (cons "r2d2" '()))
(check-expect (subst-robot (cons "robot" (cons "" '()))) (cons "r2d2" (cons "" '())))
(check-expect (subst-robot (cons "robot" (cons "rooboot" '()))) (cons "r2d2" (cons "rooboot" '())))

;; List-of-strings String String-> List-of-strings
;; converts all old in los to new
(define (substitute los old new)
  (cond
    [(empty? los) '()]
    [else (cons (if (string=? (first los) old) new (first los))
                (substitute (rest los) old new))]))

(check-expect (substitute '() "me" "you") '())
(check-expect (substitute (cons "me" (cons "you" '())) "me" "you") (cons "you" (cons "you" '())))