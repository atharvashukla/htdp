;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname 312ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
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
+-----------------------------------------------------------------------------+
|  Exercise 312                                                               |
|  ------------                                                               |
|  Develop the function eye-colors, which consumes a family tree and produces |
|  a list of all eye colors in the tree. An eye color may occur more than     |
|  once in the resulting list. Hint Use append to concatenate the lists       |
+-----------------------------------------------------------------------------+
|#

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



;; FT -> List of Strings
;; produces a list of all eye colors in the family tree
#;
(define (eye-colors an-ftree)
  '())

(check-expect (eye-colors Carl) '("green"))                           
(check-expect (eye-colors Bettina) '("green"))
(check-expect (eye-colors Adam) '("hazel" "green" "green"))
(check-expect (eye-colors Dave) '("black" "green" "green"))
(check-expect (eye-colors Eva) '("blue" "green" "green"))
(check-expect (eye-colors Fred) '("pink"))
(check-expect (eye-colors Gustav) '("brown" "pink" "blue" "green" "green"))

(define (eye-colors an-ftree)
  (cond
    [(no-parent? an-ftree) '()]
    [else (append (list (child-eyes an-ftree))
                  (eye-colors (child-father an-ftree))
                  (eye-colors (child-mother an-ftree)))]))