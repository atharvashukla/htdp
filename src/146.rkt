;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 146ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; An NEList-of-temperatures is one of: 
; – ???
; – (cons CTemperature NEList-of-temperatures)

; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 

; NEList-of-temperatures -> Number
; computes the average temperature 
 
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)
 
(define (average ne-l)
  (/ (sum ne-l) (how-many ne-l)))

; NEList-of-temperatures -> Number
; computes the sum of the given temperatures 
(check-expect
  (sum (cons 1 (cons 2 (cons 3 '())))) 6)
#;
(define (sum ne-l) 0)

; NEList-of-temperatures -> Number
#;
(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
     (... (first ne-l) ... (sum (rest ne-l)) ...)]))

(define (sum ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else (+ (first ne-l) (sum (rest ne-l)))]))


; List-of-temperature -> Number
; how many temperatures are there in the list
#;
(define (how-many ne-l) 0)

; NEList-of-temperatures -> Number
#;
(define (how-many ne-l)
  (cond
    [(empty? (rest ne-l)) (first ne-l)]
    [else
     (... (first ne-l) ... (how-many (rest ne-l)) ...)]))



(check-expect (how-many '()) 0)
(check-expect (how-many (cons 1 (cons 2 '()))) 2)

(define (how-many alot)
  (cond
    [(empty? alot) 0]
    [else (+ 1 (how-many (rest alot)))]))
