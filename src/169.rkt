;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 169ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 169
;; ------------
;; Design the function legal. Like translate from exercise 168, the function
;; consumes and produces a list of Posns. The result contains all those Posns
;; whose x-coordinates are between 0 and 100 and whose y-coordinates are between
;; 0 and 200.
;; -----------------------------------------------------------------------------

;; List-of-posn -> List-of-posn
;; filters the lop by posns whose
;; x coordinate is bw 0 & 100, AND y cord is bw 0 & 200
(define (legal lop)
  (cond
    [(empty? lop) '()]
    [else (if (islegal? (first lop))
              (cons (first lop) (legal (rest lop)))
              (legal (rest lop)))]))

(define pos1 (make-posn -1 50)) ; illegal
(define pos2 (make-posn 50 -1)) ; illegal
(define pos3 (make-posn -1 -1)) ; illegal
(define pos4 (make-posn 50 50)) ; legal
(define pos5 (make-posn 0 200)) ; legal
(define pos6 (make-posn 100 0)) ; legal

(define lop1 (cons pos1 '()))
(define lop2 (cons pos2 lop1))
(define lop3 (cons pos3 lop2))
(define lop4 (cons pos4 lop3))
(define lop5 (cons pos5 lop4))
(define lop6 (cons pos6 lop5))

(check-expect (legal '()) '())
(check-expect (legal lop1) '())
(check-expect (legal lop2) '())
(check-expect (legal lop3) '())
(check-expect (legal lop4) (cons pos4 '()))
(check-expect (legal lop5) (cons pos5 (cons pos4 '())))
(check-expect (legal lop6) (cons pos6 (cons pos5 (cons pos4 '()))))

(check-expect (islegal? pos1) #false)
(check-expect (islegal? pos2) #false)
(check-expect (islegal? pos3) #false)
(check-expect (islegal? pos4) #true)
(check-expect (islegal? pos5) #true)
(check-expect (islegal? pos6) #true)

(define (islegal? pos)
  (and (and (>= (posn-y pos) 0) (<= (posn-y pos) 200))
       (and (>= (posn-x pos) 0) (<= (posn-x pos) 100))))