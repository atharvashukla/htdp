;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 420ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 420
;; ------------
;; JANUS is just a fixed list, but take a look at this function:
;;
;;    (define (oscillate n)
;;      (local ((define (O i)
;;                (cond
;;                  [(> i n) '()]
;;                  [else
;;                   (cons (expt #i-0.99 i) (O (+ i 1)))])))
;;        (O 1)))
;;
;; Applying oscillate to a natural number n produces the first n elements of a
;; mathematical series. It is best understood as a graph, like the one in figure
;; 145. Run (oscillate 15) in DrRacket and inspect the result.
;;
;; <fig-145-oscillate.png>
;;
;; Figure 145: The graph of oscillate
;;
;; Summing its results from left to right computes a different result than from
;; right to left:
;;
;;    > (sum (oscillate #i1000.0))
;;    #i-0.49746596003269394
;;    
;;    > (sum (reverse (oscillate #i1000.0)))
;;    #i-0.4974659600326953
;;
;; Again, the difference may appear to be small until we see the context:
;;
;;    > (- (* 1e+16 (sum (oscillate #i1000.0)))
;;         (* 1e+16 (sum (reverse (oscillate #i1000.0)))))
;;    #i14.0
;;
;; Can this difference matter? Can we trust computers? 
;; -----------------------------------------------------------------------------


; This difference matters. It's hard to trust floating point numerics!
; We should identify where it matters, and choose precision over speed. 