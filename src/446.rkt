;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 446ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 446
;; ------------
;; Add the test from exercise 445 to the program in figure 159. Experiment with
;; different values for ε. 
;; -----------------------------------------------------------------------------

; (define ep 0.01)
(define ep 0.001)


; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption 
(define (find-root f left right)
  (cond
    [(<= (- right left) ep) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid)))
        (cond
          [(or (<= (f left) 0 f@mid) (<= f@mid 0 (f left)))
           (find-root f left mid)]
          [(or (<= f@mid 0 (f right)) (<= (f right) 0 f@mid))
           (find-root f mid right)]))]))

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

; [Number -> Number] -> [Number -> Number]

(check-expect ((check-root poly) 2) #true)
(check-expect ((check-root poly) 3) #false)

(define (check-root f)
  (λ (x)
    (<= (abs (f x)) (* 2 ep))))


(check-satisfied (find-root poly -1 3) (check-root poly))
(check-satisfied (find-root poly 3 4) (check-root poly))








