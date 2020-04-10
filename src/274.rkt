;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 274ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 274
;; ------------
;; Use existing abstractions to define the prefixes and suffixes functions from
;; exercise 190. Ensure that they pass the same tests as the original function.
;; -----------------------------------------------------------------------------

(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "a" "b") (list "a")))

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

; [List-of 1String] -> [List-of [List-of 1String]]
; all prefixes of lo1s

(check-expect (prefixes-abs '()) '())
(check-expect (prefixes-abs (list "a")) (list (list "a")))
(check-expect (prefixes-abs (list "a" "b")) (reverse (list (list "a" "b") (list "a"))))
(check-expect (prefixes-abs (list "a" "b" "c")) (reverse (list (list "a" "b" "c") (list "a" "b") (list "a"))))

(define (prefixes-abs l)
  (local (; total # of 1Strinfs in l
          (define total-elems (length l))

          ; Nat -> [List-of 1String]
          ; gets the first n items from l
          (define (make-prefix n)
            (take-n (add1 n) l))

          ; gets the first n items from l
          ; ASSUME: the length of l >= n
          (define (take-n n l)
            (cond
              [(= n 0) '()]
              [else (cons (first l) (take-n (sub1 n) (rest l)))])))

    ; takes n items from the list and adds them to the result
    (build-list (length l) make-prefix)))





; --------------------------------------------------------------------


(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b")) (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c")) (list (list "a" "b" "c") (list "b" "c")  (list "c")))

;; List-of-1String -> List-of-list-of-1String
;; list of all the suffixes of lo1s

(define (suffixes lo1s)
  (cond
    [(empty? lo1s) '()]
    [else (cons lo1s
                (suffixes (rest lo1s)))]))



; [List-of 1String] -> [List-of [List-of 1String]]
; all suffixes of lo1s

(check-expect (suffixes-abs '()) '())
(check-expect (suffixes-abs (list "a")) (list (list "a")))
(check-expect (suffixes-abs (list "a" "b"))  (reverse (list (list "a" "b") (list "b"))))
(check-expect (suffixes-abs (list "a" "b" "c")) (reverse (list (list "a" "b" "c") (list "b" "c")  (list "c"))))

(define (suffixes-abs l)
  (local (; total # of 1Strings in l
          (define total-elems (length l))

          ; Nat -> [List-of 1String]
          (define (make-suffix n)
            (remove-elems (- total-elems (add1 n)) l))

          ; [X] Nat -> [List-of X] -> [List-of X] 
          ; removes n items from l
          ; ASSUME: l has length of at least n
          (define (remove-elems n l)
            (cond
              [(= n 0) l]
              [else (remove-elems (sub1 n) (rest l))])))
    ; for each nat, remove that many elems from l
    (build-list (length l) make-suffix)))
