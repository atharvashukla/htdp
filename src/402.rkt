;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 402ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 402
;; ------------
;; Reread exercise 354. Explain the reasoning behind our hint to think of the
;; given expression as an atomic value at first.
;; -----------------------------------------------------------------------------

;; -----------------------------------------------------------------------------
;; Exercise 354
;; ------------
;; Design eval-variable. The checked function consumes a BSL-var-expr and
;; determines its value if numeric? yields true for the input. Otherwise it
;; signals an error.
;;
;; In general, a program defines many constants in the definitions area, and
;; expressions contain more than one variable. To evaluate such expressions,
;; we need a representation of the definitions area when it contains a series
;; of constant definitions. For this exercise we use association lists:
;;
;;    ; An AL (short for association list) is [List-of Association].
;;    ; An Association is a list of two items:
;;    ;   (cons Symbol (cons Number '())).
;;
;; Make up elements of AL.
;;
;; Design eval-variable*. The function consumes a BSL-var-expr ex and an
;; association list da. Starting from ex, it iteratively applies subst to all
;; associations in da. If numeric? holds for the result, it determines its
;; value; otherwise it signals the same error as eval-variable.
;;
;; *Hint* Think of the given BSL-var-expr as an atomic value and traverse the
;; given association list instead. We provide this hint because the creation of
;; this function requires a little design knowledge from Simultaneous Processing
;; -----------------------------------------------------------------------------

;; We go through the AL and substitute in each variable into the expression.
;; When we're done, we see if the expression is numeric? and if so, we evaluate.

;; Here the AL parameter plays the dominant role, therefore we traverse it.
;; while simply substituting into the expression (`subst` was available)
