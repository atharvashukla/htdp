;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 419ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 419
;; ------------
;; 
;;    (define JANUS
;;      (list 31.0
;;            #i2e+34
;;            #i-1.2345678901235e+80
;;            2749.0
;;            -2939234.0
;;            #i-2e+33
;;            #i3.2e+270
;;            17.0
;;            #i-2.4e+270
;;            #i4.2344294738446e+170
;;            1.0
;;            #i-8e+269
;;            0.0
;;            99.0))
;;
;;    Figure 144: A Janus-faced series of inexact numbers
;;
;; When you add two inexact numbers of vastly different orders of magnitude, you
;; may get the larger one back as the result. For example, if a number system
;; uses only 15 significant digits, we run into problems when adding numbers
;; that vary by more than a factor of image:
;;
;; 1.0 * 10 ^16 + 1 = 1.0000000000000001 * 10 ^ 16
;;
;; but the closest representable answer is 10 ^16
;;
;; At first glance, this approximation doesn’t look too bad. Being wrong by one
;; part in 10 ^ 16 (ten million billion) is close enough to the truth.
;; Unfortunately, this kind of problem can add up to huge problems. Consider the
;; list of numbers in figure 144 and determine the values of these expressions:
;;
;; - (sum JANUS)
;; 
;; - (sum (reverse JANUS))
;; 
;; - (sum (sort JANUS <))
;;
;; Assuming sum adds the numbers in a list from left to right, explain what
;; these expressions compute. What do you think of the results?
;;
;; Generic advice on inexact calculations tells programmers to start additions
;; with the smallest numbers. While adding a big number to two small numbers
;; might yield the big one, adding small numbers first creates a large one,
;; which might change the outcome:
;;
;;    > (expt 2 #i53.0)
;;    #i9007199254740992.0
;;    
;;    > (sum (list #i1.0 (expt 2 #i53.0)))
;;    #i9007199254740992.0
;;    
;;    > (sum (list #i1.0 #i1.0 (expt 2 #i53.0)))
;;    #i9007199254740994.0
;;
;; This trick may *not* work; see the JANUS interactions above.
;;
;; In a language such as ISL+, you can convert the numbers to exact rationals,
;; use exact arithmetic on those, and convert the result back:
;;
;;    (exact->inexact (sum (map inexact->exact JANUS)))
;;
;; Evaluate this expression and compare the result to the three sums above. What
;; do you think now about advice from the web? 
;; -----------------------------------------------------------------------------


(define JANUS
  (list 31.0
        #i2e+34
        #i-1.2345678901235e+80
        2749.0
        -2939234.0
        #i-2e+33
        #i3.2e+270
        17.0
        #i-2.4e+270
        #i4.2344294738446e+170
        1.0
        #i-8e+269
        0.0
        99.0))

; [List-of Number] -> Number
; adds all numbers in l
(define (sum l)
  (apply + l))

(sum JANUS)
; => #i99.0

(sum (reverse JANUS))
; => #i-1.2345678901234999e+80

(sum (sort JANUS <))
; => #i0.0


;; ALL THOSE ARE TOTALLY DIFFERENT ANSWERS!


(exact->inexact (sum (map inexact->exact JANUS)))
; #i4.2344294738446e+170

;; The correct answer ^



; What do you think now about advice from the web?
; it's just wrong and may work sometimes.