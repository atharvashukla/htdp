;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |176ex [nc]|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 176
;; ------------
;; Mathematics teachers may have introduced you to matrix calculations by now.
;; In principle, matrix just means rectangle of numbers. Here is one possible
;; data representation for matrices:
;;
;;    ; A Matrix is one of: 
;;    ;  – (cons Row '())
;;    ;  – (cons Row Matrix)
;;    ; constraint all rows in matrix are of the same length
;;     
;;    ; A Row is one of: 
;;    ;  – '() 
;;    ;  – (cons Number Row)
;;
;; Note the constraints on matrices. Study the data definition and translate the
;; two-by-two matrix consisting of the numbers 11, 12, 21, and 22 into this data
;; representation. Stop, don’t read on until you have figured out the data
;; examples.
;;
;; Here is the solution for the five-second puzzle:
;;
;;    (define row1 (cons 11 (cons 12 '())))
;;    (define row2 (cons 21 (cons 22 '())))
;;    (define mat1 (cons row1 (cons row2 '())))
;;
;; If you didn’t create it yourself, study it now.
;;
;; Figure 70: Transpose a matrix:
;;
;;    ; Matrix -> Matrix
;;    ; transposes the given matrix along the diagonal 
;;     
;;    (define wor1 (cons 11 (cons 21 '())))
;;    (define wor2 (cons 12 (cons 22 '())))
;;    (define tam1 (cons wor1 (cons wor2 '())))
;;     
;;    (check-expect (transpose mat1) tam1)
;;     
;;    (define (transpose lln)
;;      (cond
;;        [(empty? (first lln)) '()]
;;        [else (cons (first* lln) (transpose (rest* lln)))]))

;;
;; The function in figure 70 implements the important mathematical operation of
;; transposing the entries in a matrix. To transpose means to mirror the entries
;; along the diagonal, that is, the line from the top-left to the bottom-right.
;;
;; Stop! Transpose mat1 by hand, then read figure 70. Why does transpose ask
;; (empty? (first lln))?
;;
;; The definition assumes two auxiliary functions:
;;
;; - first*, which consumes a matrix and produces the first column as a list of
;;   numbers; and
;;
;; - rest*, which consumes a matrix and removes the first column. The result is
;;   a matrix.
;;
;; Even though you lack definitions for these functions, you should be able to
;; understand how transpose works. You should also understand that you cannot
;; design this function with the design recipes you have seen so far. Explain
;; why.
;;
;; Design the two wish-list functions. Then complete the design of transpose
;; with some test cases. 
;;
;; -----------------------------------------------------------------------------



; A Row is one of:
; - '()
; - (cons Number Row)

; A matrix is one of:
; - (cons Row '())
; - (cons Row Matrix)

;;  Stop, don’t read on until you have figured out the data examples.

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

;; Stop! Transpose mat1 by hand, then read figure 70.

(define mat1-t
  (cons (cons 11 (cons 21 '()))       ; first row
        (cons (cons 12 (cons 22 '())) ; second row
              '())))


; Matrix -> Matrix
; transposes the given matrix along the diagonal 
 
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '()))) ; nice name :)
 
(check-expect (transpose mat1) tam1)
 
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

;; Why does transpose ask (empty? (first lln))?

;; if (first lln) is empty, then the matrix is empty. 
;; Transpose of an empty matrix is an empty matrix


; ----- my functions: -----

(define empty-matrix (cons '() '()))

; Matrix -> Boolean
; is the matrix empty?
(check-expect (empty-mat? empty-matrix) #true)
(check-expect (empty-mat? (cons (cons 1 (cons 2 '())) (cons 1 (cons 2 '())))) #false)
(define (empty-mat? m)
  (empty? (first m)))

; NE-Matrix -> List-of-numbers
; first row of a non empty matrix
(check-expect (first-row mat1) (cons 11 (cons 12 '())))
(define (first-row m)
  (first m))

; NE-Matrix -> Number
; first element of a non empty matrix
(check-expect (get-top-left-elem mat1) 11)
(define (get-top-left-elem m)
  (first (first m)))

; NE-Matrix -> List-of-Numebr
; removes the top left element from the first row
(check-expect (remove-top-left-elem mat1) (cons 12 '()))
(define (remove-top-left-elem m)
  (rest (first m)))

; Matrix -> List-of-number
; first column of m
(check-error (first* empty-matrix) )
(check-expect (first* mat1) (cons 11 (cons 21 '())))
(define (first* m)
  (cond
    [(empty-mat? m) (error "the matrix is empty")]
    [(empty? (rest m)) (cons (get-top-left-elem m) '())]
    [else (cons (get-top-left-elem m) (first* (rest m)))]))

; Matrix -> List-of-number
; removes the first column of m
(check-error (rest* empty-matrix))
(check-expect (rest* mat1) (cons (cons 12 '()) (cons (cons 22 '()) '())))
(define (rest* m)
  (cond
    [(empty? (first m)) (error "the matrix is empty")]
    [(empty? (rest m)) (cons (remove-top-left-elem m) '())]
    [else (cons (remove-top-left-elem m) (rest* (rest m)))]))

