;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |431|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 431
;; ------------
;; Answer the four key questions for the bundle problem and the first three
;; questions for the quick-sort< problem. How many instances of generate-problem
;; are needed?
;; -----------------------------------------------------------------------------

; Bundle
; ------

; 1. What is a trivially solvable problem?
; => (bundle '() n) for any n

; 2. How are trivial solutions solved?
; => bundling an empty list yields an empty list


; 3. How does the algorithm generate new problems that are more easily solvable
;    than the original one? Is there one new problem that we generate or are
;    there several?
; => - "drop" the first n elements from the list
;    - only one new problem: (rest l)

; 4. Is the solution of the given problem the same as the solution of (one of)
;    the new problems? Or, do we need to combine the solutions to create a
;    solution for the original problem? And, if so, do we need anything from the
;    original problem data?
; => - bundling (rest l) is the same as (cons bundled (bundle (rest l))
;    - we need to "take" the first n elements from l to make bundled

; quick-sort-<
; ------------

; 1. What is a trivially solvable problem?
; => sorting empty or 1-element list

; 2. How are trivial solutions solved?
; => result = the list itself


; 3. How does the algorithm generate new problems that are more easily solvable
;    than the original one? Is there one new problem that we generate or are
;    there several?
; => - divide the list into larger elments, smaller elements, and elements that
;      are equal to the first element (pivot)
;    - 2 sub-problems are generated: largers and smallers

; 4. Is the solution of the given problem the same as the solution of (one of)
;    the new problems? Or, do we need to combine the solutions to create a
;    solution for the original problem? And, if so, do we need anything from the
;    original problem data?
; => - no, we need to combine the three parts
;    - we only need the sorted largers, sorted smallers, and the sames