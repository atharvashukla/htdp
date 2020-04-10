;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 391ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 391
;; ------------
;; Design replace-eol-with using the strategy of Processing Two Lists
;; Simultaneously: Case 3. Start from the tests. Simplify the result
;; systematically.
;; -----------------------------------------------------------------------------


; [List-of Number] [List-of Number] -> [List-of Number]
; replaces the final '() in front with end

(check-expect (replace-eol-with.v1 '() '(a b)) '(a b))
(check-expect (replace-eol-with.v1 (cons 1 '()) '(a))
              (cons 1 '(a)))
(check-expect (replace-eol-with.v1
               (cons 2 (cons 1 '())) '(a))
              (cons 2 (cons 1 '(a))))

(define (replace-eol-with.v1 front end)
  (cond
    [(empty? front) end]
    [else
     (cons (first front)
           (replace-eol-with.v1 (rest front) end))]))


(check-expect (replace-eol-with.v1 '() '(a b)) '(a b))
(check-expect (replace-eol-with.v1 (cons 1 '()) '(a))
              (cons 1 '(a)))
(check-expect (replace-eol-with.v1
               (cons 2 (cons 1 '())) '(a))
              (cons 2 (cons 1 '(a))))

;; -----------------------------------------------------------------------------

; [List-of Number] [List-of Number] -> [List-of Number]
; replaces the final '() in front with end

(check-expect (replace-eol-with.v2 '() '(a b)) '(a b))
(check-expect (replace-eol-with.v2 (cons 1 '()) '(a))
              (cons 1 '(a)))
(check-expect (replace-eol-with.v2
               (cons 2 (cons 1 '())) '(a))
              (cons 2 (cons 1 '(a))))

(define (replace-eol-with.v2 front end)
  (foldr (λ (e a) (cons e a)) end front))
