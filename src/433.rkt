;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |433|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 433
;; ------------
;; Develop a checked version of bundle that is guaranteed to terminate for all
;; inputs. It may signal an error for those cases where the original version
;; loops.
;; -----------------------------------------------------------------------------


(check-expect (bundle-checked (explode "abcdefg") 3)
              (list "abc" "def" "g"))

(check-expect (bundle-checked '("a" "b") 3) (list "ab"))

(check-expect (bundle-checked '() 3) '())

(check-error (bundle-checked '() 0)
             "cannot bundle list with 0-sized bundles")

(check-error (bundle-checked (explode "abcdefg") 0)
             "cannot bundle list with 0-sized bundles")


; [List-of 1String] N -> [List-of String]
; bundles sub-sequences of s into strings of length n
; termination (bundle s 0) loops unless s is '()
(define (bundle-checked s n)
  (if (= n 0)
      (error "cannot bundle list with 0-sized bundles")
      (bundle s n)))


; [List-of 1String] N -> [List-of String]
; bundles chunks of s into strings of length n
; idea take n items and drop n at a time
(define (bundle s n)
  (cond
    [(empty? s) '()]
    [else
     (cons (implode (take s n)) (bundle (drop s n) n))]))
 
; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
 
; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))