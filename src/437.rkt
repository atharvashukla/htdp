;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 437ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 437
;; ------------
;; Define solve and combine-solutions so that
;; 
;; - special computes the length of its input,
;; - special negates each number on the given list of numbers, and
;; - special uppercases the given list of strings.
;; - What do you conclude from these exercises?
;; 
;; -----------------------------------------------------------------------------


(check-expect (special-length '()) 0)
(check-expect (special-length '(1 2 3)) 3)

; [X] [List-of X] -> [List-of X]
; length of the list P
(define (special-length P)
  (local ((define (solve-length P)
            0)

          (define (combine-solutions-length P special-length-so-far)
            (+ 1 special-length-so-far))

          (define (special-length-l P)
            (cond
              [(empty? P) (solve-length P)]
              [else (combine-solutions-length P (special-length-l (rest P)))])))
    (special-length-l P)))


(check-expect (special-map-negate '()) '())
(check-expect (special-map-negate '(1 2 3)) '(-1 -2 -3))


; [List-of String] -> [List-of String]
; negates all numbers in P
(define (special-map-negate P)
  (local ((define (solve-map-negate P)
            '())

          (define (combine-solutions-map-negate P special-map-negate-so-far)
            (cons (* -1 (first P)) special-map-negate-so-far))

          (define (special-map-negate-l P)
            (cond
              [(empty? P) (solve-map-negate P)]
              [else (combine-solutions-map-negate P (special-map-negate-l (rest P)))])))
    (special-map-negate-l P)))



(check-expect (special-string-upcase '()) '())
(check-expect (special-string-upcase '("a" "b" "c")) '("A" "B" "C"))

; [List-of String] -> [List-of String]
; upcases all strings in P
(define (special-string-upcase P)
  (local ((define (solve-string-upcase P)
            '())

          (define (combine-solutions-string-upcase P special-string-upcase-so-far)
            (cons (string-upcase (first P)) special-string-upcase-so-far))

          (define (special-string-upcase-l P)
            (cond
              [(empty? P) (solve-string-upcase P)]
              [else (combine-solutions-string-upcase P (special-string-upcase-l (rest P)))])))
    (special-string-upcase-l P)))



; These exercises prove that the list processing functions
; are simply a special case of the more general generative
; recursion template.

; - trivial? == empty?
; - generate == rest
; - the exercise was to make various "combine-solutions" 
;   and "solve" for various applications
