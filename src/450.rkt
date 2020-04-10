;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 450ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 450
;; ------------
;; A function f is monotonically increasing if (<= (f a) (f b)) holds whenever
;; (< a b) holds. Simplify find-root assuming the given function is not only
;; continuous but also monotonically increasing.  
;; -----------------------------------------------------------------------------

(define ep 0.001)

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

; [Number -> Number] -> [Number -> Number]

(check-expect ((check-root poly) 2) #true)
(check-expect ((check-root poly) 3) #false)

(define (check-root f)
  (λ (x)
    (<= (abs (f x)) (* 2 ep))))


; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R ε)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divides interval in half, the root is in one of the two
; halves, picks according to assumption
(define (find-root2 f l r)
  (local (; [Number -> Number] Number Number Number Number -> Number
          (define (find-root-acc f left right fleft fright)
            (cond
              [(<= (- right left) ep) left]
              [else
               (local ((define mid (/ (+ left right) 2))
                       (define f@mid (f mid)))
                 (cond
                   ; simplifications:
                   [(<= fleft 0 f@mid) (find-root-acc f left mid fleft f@mid)]
                   [(<= f@mid 0 fright) (find-root-acc f mid right f@mid fright)]))])))
    (find-root-acc f l r (f l) (f r))))


; Monotonically increasing ranges:
(check-satisfied (find-root2 poly 3 4) (check-root poly))
(check-satisfied (find-root2 poly 3 100) (check-root poly))
