;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 267ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 267
;; ------------
;; Use map to define the function convert-euro, which converts a list of US$
;; amounts into a list of € amounts based on an exchange rate of US$1.06 per
;; € (on April 13, 2017).

;; Also use map to define convertFC, which converts a list of Fahrenheit
;; measurements to a list of Celsius measurements.

;; Finally, try your hand at translate, a function that translates a list of
;; Posns into a list of lists of pairs of numbers.
;; -----------------------------------------------------------------------------

;; (List-of Number) -> (List-of Number)
;; Converts a list of USD to Euro at rate: 1.06
(check-expect (convert-euro '()) '())
(check-expect (convert-euro '(100 10)) '(106 10.6))
(check-expect (convert-euro '(100 10 0)) '(106 10.6 0))
(check-expect (convert-euro '(100 10 0 50)) '(106 10.6 0 53))
(define (convert-euro lo-usd)
  (map usd2eur lo-usd))


;; Number -> Number
;; Converts a USD value to a EUR value
;; at the rate: 1.06
(check-expect (usd2eur 100) 106)
(check-expect (usd2eur 10) 10.6)
(check-expect (usd2eur 0) 0)
(check-expect (usd2eur 50) 53)
(define (usd2eur usd)
  (* usd 1.06))



;; (List-of Number) -> (List-of Number)
;; Converts a list of fahrenheit to a list of celsius
(check-expect (convertFC '()) '())
(check-expect (convertFC '(32)) '(0))
(check-within (convertFC '(32 0)) '(0 -17.7778) 0.0001)
(check-within (convertFC '(32 0 212)) '(0 -17.7778 100) 0.0001)
(define (convertFC lo-fh)
  (map F2C lo-fh))

;; Number -> Number
;; Converts a fahrenheit to a celsius
(check-expect (F2C 32) 0)
(check-within (F2C 0) -17.7778 0.0001)
(check-within (F2C -100) -73.3333 0.0001)
(check-within (F2C 100) 37.7778 0.0001)

(define (F2C fah)
  (* (- fah 32) (/ 5 9)))


; [List-of Posn] -> [List-of (list Number Number)]
; converts a list of posn to a list of pair of numbers

(check-expect (translate '()) '())
(check-expect (translate (list (make-posn 3 4))) '((3 4)))
(check-expect (translate (list (make-posn 3 4) (make-posn 0 0))) '((3 4) (0 0)))

(define (translate lop)
  (local (; Posn -> (list Number Number)
          ; converts a posn to a pair of numbers
          (define (posn->pair p)
            (list (posn-x p) (posn-y p))))
    (map posn->pair lop)))



