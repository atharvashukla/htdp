;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 190ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 190
;; ------------
;; Design the prefixes function, which consumes a list of 1Strings and produces
;; the list of all prefixes. A list p is a prefix of l if p and l are the same
;; up through all items in p. For example, (list "a" "b" "c") is a prefix of
;; itself and (list "a" "b" "c" "d").
;;
;; Design the function suffixes, which consumes a list of 1Strings and produces
;; all suffixes. A list s is a suffix of l if p and l are the same from the end,
;; up through all items in s. For example, (list "b" "c" "d") is a suffix of
;; itself and (list "a" "b" "c" "d").
;; -----------------------------------------------------------------------------

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a"))
              (list (list "a")))
(check-expect (prefixes (list "a" "b"))
              (list (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c"))
              (list (list "a" "b" "c") (list "a" "b") (list "a")))

;; List-of-1String -> List-of-list-of-1String
;; list of all the prefixes of lo1s

(define (prefixes lo1s)
  (cond
    [(empty? lo1s) '()]
    [else (cons lo1s
                (prefixes (rem-last-elem lo1s)))]))


;; List-of-1String -> List-of-list-of-1String
;; removes the last element from l


(check-expect (rem-last-elem (list "a" "b" "c")) (list "a" "b"))
(check-expect (rem-last-elem (list "a")) '())
(check-expect (rem-last-elem '()) '())

(define (rem-last-elem l)
  (cond
    [(empty? l) '()]
    [else (if (empty? (rest l))
              '()
              (cons (first l) (rem-last-elem (rest l))))]))

; --------------------------------------------------------------------


(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a"))
              (list (list "a")))
(check-expect (suffixes (list "a" "b"))
              (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c"))
              (list (list "a" "b" "c") (list "b" "c")  (list "c")))

;; List-of-1String -> List-of-list-of-1String
;; list of all the suffixes of lo1s

(define (suffixes lo1s)
  (cond
    [(empty? lo1s) '()]
    [else (cons lo1s
                (suffixes (rest lo1s)))]))