#lang htdp/bsl

; Exercise 7.
; -----------
; Boolean expressions can express some everyday problems. Suppose you want to
; decide whether today is an appropriate day to go to the mall. You go to the
; mall either if it is not sunny or if today is Friday (because that is when
; stores post new sales items).
;
; Here is how you could go about it using your new knowledge about Booleans.
; First add these two lines to the definitions area of DrRacket:
;
;    (define sunny #true)
;    (define friday #false)
;
; Now create an expression that computes whether sunny is false or friday is
; true. So in this particular case, the answer is #false. (Why?)
;
; See exercise 1 for how to create expressions in DrRacket. How many
; combinations of Booleans can you associate with sunny and friday? 
; ------------------------------------------------------------------------------

(define sunny  #false)
(define friday #true)

(or (not sunny) friday)
; => #true



; Number of combinations that can be associated with `sunny` and `friday` are:
; 4

; | x      | y      | (or x y) |
; |--------+--------+----------|
; | #true  | #true  | #true    |
; | #true  | #false | #true    |
; | #false | #true  | #true    |
; | #false | #false | #false   |

; | x      | y      | (and x y) |
; |--------+--------+-----------|
; | #true  | #true  | #true     |
; | #true  | #false | #false    |
; | #false | #true  | #false    |
; | #false | #false | #false    |


; | sunny  | friday  | (not sunny) | (or (not sunny) friday) |
; |--------+---------|-------------|-------------------------|
; | #true  | #true   | #false      | #true                   |
; | #true  | #false  | #false      | #false                  |
; | #false | #true   | #true       | #true                   |
; | #false | #false  | #true       | #true                   |



