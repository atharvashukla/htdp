;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 141ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 141.
;; -------------
;;  If you are asked to design the function cat, which consumes a list of
;; strings and appends them all into one long string, you are guaranteed to end
;; up with this partial definition:
;;
;;    ; List-of-string -> String
;;    ; concatenates all strings in l into one long string
;;     
;;    (check-expect (cat '()) "")
;;    (check-expect (cat (cons "a" (cons "b" '()))) "ab")
;;    (check-expect
;;      (cat (cons "ab" (cons "cd" (cons "ef" '()))))
;;      "abcdef")
;;     
;;    (define (cat l)
;;      (cond
;;        [(empty? l) ""]
;;        [else (... (first l) ... (cat (rest l)) ...)]))
;;
;; ill in the table in figure 57 (below). Guess a function that can create the
;; desired result from the values computed by the sub-expressions.
;;
;; Use DrRacket’s stepper to evaluate (cat (cons "a" '())). 
;; -----------------------------------------------------------------------------


#| Figure 57: A Table for cat 

| l                                       | (first l) | (rest l) | (cat (rest l)) | (cat l   |
|-----------------------------------------+-----------+----------+----------------+----------|
| (cons "a" (cons "b" '()))               | ???       | ???      | ???            | "ab"     |
| (cons "ab" (cons "cd" (cons "ef" '()))) | ???       | ???      | ???            | "abcdef" |

|#


; List-of-string -> String
; concatenates all strings in l into one long string
 
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
 (cat (cons "ab" (cons "cd" (cons "ef" '()))))
 "abcdef")

#;
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (... (first l) ... (cat (rest l)) ...)]))


#|
| l                                       | (first l) | (rest l)                    | (cat (rest l)) | (cat l   |
|-----------------------------------------+-----------+-----------------------------+----------------+----------|
| (cons "a" (cons "b" '()))               | "a"       | (cons "b" '())              | "b"            | "ab"     |
| (cons "ab" (cons "cd" (cons "ef" '()))) | "ab"      | (cons "cd" (cons "ef" '())) | "cdef"         | "abcdef" |

|#

(define (cat l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (cat (rest l)))]))

(cat (cons "a" '()))
; ==
(cond
  ((empty? (cons "a" '())) "")
  (else
   (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))))
; ==
(cond
  (#true "")
  (else
   (string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))))
; ==
(string-append (first (cons "a" '())) (cat (rest (cons "a" '()))))
; ==
(string-append "a" (cat '()))
; ==
(string-append
 ""
 (cond
   [(empty? '()) ""]
   [else (string-append (first '()) (cat (rest '())))]))
; ==
(string-append
 ""
 (cond
   [#true ""]
   [else (string-append (first '()) (cat (rest '())))]))
; ==
(string-append "a" "")
; ==
"a"
