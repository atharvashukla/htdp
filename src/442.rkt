;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 442ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 442
;; ------------
;; Add sort< and quick-sort< to the definitions area. Run tests on the functions
;; to ensure that they work on basic examples. Also develop create-tests, a
;; function that creates large test cases randomly. Then explore how fast each
;; works on various lists.

;; Does the experiment confirm the claim that the plain sort< function often
;; wins over quick-sort< for short lists and vice versa?

;; Determine the cross-over point. Use it to build a clever-sort function that
;; behaves like quick-sort< for large lists and like sort< for lists below this
;; cross-over point. Compare with exercise 427.
;; -----------------------------------------------------------------------------

; Number Number Number -> [List-of [List-of Number]]
; generates `lists` # of lists with `elems` number of elements
; maximum element can be in the range [0, max)
(define (gen-random-set elems lists max)
  (build-list lists (λ (x) (build-list elems (λ (e) (random max))))))

; Number Number Number -> Number Number Number
; dummy variable. 
; EFFECT: displays the time taken to sort each list
; in the set using quick-sort< and sort<
(define (get-time elems lists max)
  (local ((define l (gen-random-set elems lists max))
          (define q (time (map quick-sort< l)))
          (define i (time (map sort< l))))
    (list elems lists max)))

; Q. sort< function often wins over quick-sort< for short lists and vice versa?

; A. Yes

; sorting 1000 1000-element lists
; -------------------------------
; quick-sort<: cpu time: 46696 real time: 46923 gc time: 1628
; sort<: cpu time: 394995 real time: 395726 gc time: 7886

; sorting 1000 10-element lists
; -----------------------------
; quick-sort<: cpu time: 127 real time: 128 gc time: 0
; sort<: cpu time: 49 real time: 49 gc time: 0

; searching for the cross-over point
; ----------------------------------
; 56
; cpu time: 1360 real time: 1362 gc time: 16
; cpu time: 1348 real time: 1360 gc time: 12

#;
(get-time 'x)


(define CROSS-OVER 56)

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct

(check-expect (quick-sort-faster< (list 55 41 37 49 40 15 74 43 48))
              (sort (list 55 41 37 49 40 15 74 43 48) <))

(check-expect (quick-sort-faster< (list 55 41 37))
              (list 37  41 55))

(check-expect (quick-sort-faster< (list 41 55 37))
              (list 37 41 55))

(define l (build-list 1000 (λ (x) (random 1000))))

(check-expect (quick-sort-faster< l) (sort l <))

(define (quick-sort-faster< alon)
  (if (<= (length alon) CROSS-OVER)
      (sort< alon)
      (quick-sort< alon)))

;; -----------------------------------------------------------------------------

; [List-of Number] -> [List-of Number]
; produces a sorted version of alon
; assume the numbers are all distinct 
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers (rest alon) pivot))
                    (sames alon pivot)
                    (quick-sort< (largers (rest alon) pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))
 
; [List-of Number] Number -> [List-of Number]
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n) 
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))

(define (sames alon n)
  (cond
    [(empty? alon) '()]
    [else (if (= (first alon) n)
              (cons (first alon) (sames (rest alon) n))
              (sames (rest alon) n))]))

;; -----------------------------------------------------------------------------

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(define (sort< l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort< (rest l)))]))
 
; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers l 
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (<= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))


;; -----------------------------------------------------------------------------
