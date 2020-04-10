;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 449ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 448
;; ------------
;; As presented in figure 159, find-root computes the value of f for each
;; boundary value twice to generate the next interval. Use local to avoid this
;; recomputation.
;;
;; In addition, find-root recomputes the value of a boundary across recursive
;; calls. For example, (find-root f left right) computes (f left) and, if
;; [left,mid] is chosen as the next interval, find-root computes (f left) again.
;; Introduce a helper function that is like find-root but consumes not only left
;; and right but also (f left) and (f right) at each recursive stage.
;;
;; How many recomputations of (f left) does this design maximally avoid? *Note*
;; The two additional arguments to this helper function change at each recursive
;; stage, but the change is related to the change in the numeric arguments.
;; These arguments are so-called accumulators, which are the topic of
;; Accumulators. 
;; -----------------------------------------------------------------------------

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
         [(local ((define f@l (f left))) (or (<= f@l 0 f@mid) (<= f@mid 0 f@l)))
          (find-root f left mid)]
         [(local ((define f@r (f right))) (or (<= f@mid 0 f@r) (<= f@r 0 f@mid)))
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
                   [(or (<= fleft 0 f@mid) (<= f@mid 0 fleft))
                    (find-root-acc f left mid fleft f@mid)]
                   [(or (<= f@mid 0 fright) (<= fright 0 f@mid))
                    (find-root-acc f mid right f@mid fright)]))])))
    (find-root-acc f l r (f l) (f r))))



(check-satisfied (find-root2 poly -1 3) (check-root poly))
(check-satisfied (find-root2 poly 3 4) (check-root poly))



; Our design iterations avoided maximally 2 recomputations of (f left)
; every recursive call. So 2*(log n) calls