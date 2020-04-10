;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 315ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
+----------------------------------------------------------------------------+
| Exercise 315                                                               |
| ------------                                                               |
| Design the function average-age. It consumes a family forest and a year    |
| (N). From this data, it produces the average age of all child instances in |
| the forest. Note If the trees in this forest overlap, the result isn’t a   |
| true average because some people contribute more than others. For this     |
| exercise, act as if the trees don’t overlap.                               |
+----------------------------------------------------------------------------+
|#

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


; An FF (short for family forest) is one of: 
; – '()
; – (cons FT FF)
; interpretation a family forest represents several
; families (say, a town) and their ancestor trees

; An FF is a [List-of FT].


(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))


;; FF N -> N
;; average age of all child instances in a-forest
#;
(define (average-age a-forest year)
  0)

(check-expect (average-age-ff ff1 2018) 92)
(check-expect (average-age-ff ff2 2018) (/ (+ 92 92 53 52) 4))
(check-expect (average-age-ff ff3 2018) (/ (+ 92 92 92 53 52) 5))


(define (average-age-ff ff year)
  ;; weighted sum divided by the number of people
  (/ (apply +
          ;; weighing the average age by the number of people
          (map * (map (λ (x) (average-age x year)) ff) (map sum-FT ff)))
       ;; sum of all FTs in the FF
       (apply + (map sum-FT ff))))



;; ------------------------ FUNCTIONS ------------------
;; sum-FT      > count the number of people in the ftree
;; sum-ages    > sum of all ages in the ftree
;; average-age > average age of all members of the ftree

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
    [else (+ 1
             (sum-FT (child-father an-ftree))
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

