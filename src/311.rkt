;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 311ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define-struct no-parent [])
(define-struct child [father mother name date eyes])
; An FT (short for family tree) is one of: 
; – (make-no-parent)
; – (make-child FT FT String N String)

(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

#|
+----------------------------------------------------------------------------+
| Exercise 311                                                               |
| ------------                                                               |
| Develop the function average-age. It consumes a family tree and the current|
| year. It produces the average age of all child structures in the family    |
| tree.                                                                      |
+----------------------------------------------------------------------------+
|#

;; STUB
#;
(define (count-persons an-ftree)
  0)

;; TEMPLATE

; FT -> ???
#;
(define (fun-FT an-ftree)
  (cond
    [(no-parent? an-ftree) ...]
    [else (... (fun-FT (child-father an-ftree)) ...
               ... (fun-FT (child-mother an-ftree)) ...
               ... (child-name an-ftree) ...
               ... (child-date an-ftree) ...
               ... (child-eyes an-ftree) ...)]))

(check-expect (average-age Carl 2018) 92)
(check-expect (average-age Bettina 2018) 92)
(check-expect (average-age Adam 2018) 252/3)
(check-expect (average-age Dave 2018) 247/3)
(check-expect (average-age Eva 2018) 79)
(check-expect (average-age Fred 2018) 52)
(check-expect (average-age Gustav 2018) 63.8)

;; FT Num -> Num
;; the average of all members on the an-ftree
(define (average-age an-ftree year)
  (/ (sum-ages an-ftree year) (sum-FT an-ftree)))

(check-expect (sum-FT Carl) 1)
(check-expect (sum-FT Bettina) 1)
(check-expect (sum-FT Adam) 3)
(check-expect (sum-FT Dave) 3)
(check-expect (sum-FT Eva) 3)
(check-expect (sum-FT Fred) 1)
(check-expect (sum-FT Gustav) 5)

;; FT -> Num
;; count the number of ancestors in the FT
(define (sum-FT an-ftree)
  (cond
    [(no-parent? an-ftree) 0]
    [else (+ 1 (sum-FT (child-father an-ftree))
             (sum-FT (child-mother an-ftree)))]))


;; FT Num -> Num
;; calculates the sum of all the ages in the family tree
(check-expect (sum-ages Carl 2018) 92)
(check-expect (sum-ages Bettina 2018) 92)
(check-expect (sum-ages Adam 2018) 252)
(check-expect (sum-ages Dave 2018) 247)
(check-expect (sum-ages Eva 2018) 237)
(check-expect (sum-ages Fred 2018) 52)
(check-expect (sum-ages Gustav 2018) 319)

(define (sum-ages an-ftree year)
  (cond
    [(no-parent? an-ftree) 0]
    [else (+ (- year (child-date an-ftree))
             (sum-ages (child-father an-ftree) year)
             (sum-ages (child-mother an-ftree) year))]))