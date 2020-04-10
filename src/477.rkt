;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 477ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 477
;; ------------
;; Inspect the function definition of arrangements in figure 171. The figure
;; displays a generative-recursive solution of the extended design problem
;; covered by Word Games, the Heart of the Problem, namely
;;
;;    given a word, create all possible rearrangements of the letters.
;;
;; The extended exercise is a direct guide to the structurally recursive design
;; of the main function and two auxiliaries, where the design of the latter
;; requires the creation of two more helper functions. In contrast, figure 171
;; uses the power of generative recursion—plus foldr and map—to define the same
;; program as a single function definition.
;;
;; Explain the design of the generative-recursive version of arrangements.
;; Answer all questions that the design recipe for generative recursion poses,
;; including the question of termination.
;;
;; Does arrangements in figure 171 create the same lists as the solution of Word
;; Games, the Heart of the Problem? 
;; -----------------------------------------------------------------------------


; [List-of X] -> [List-of [List-of X]]
; creates a list of all rearrangements of the items in w
; TERMINATION: base case terminates. The call to arrangements in the
; recursive call is on a smaller list (with the item removed from w)
(define (arrangements w)
  (cond
    [(empty? w) '(())]
    [else
      (foldr (lambda (item others)
               (local ((define without-item (arrangements (remove item w)))
                       (define add-item-to-front (map (lambda (a) (cons item a)) without-item)))
                 (append add-item-to-front others)))
        '()
        w)]))

(check-expect (arrangements '()) '(()))
(check-expect (arrangements '(c)) '((c)))
(check-expect (arrangements '(b c)) '(; this pair is from when 'b' was removed
                                      (b c)
                                      ; this result is from when 'c' was removed
                                      (c b)))

(define (all-words-from-rat? w)
  (and (member (explode "rat") w)
       (member (explode "art") w)
       (member (explode "tar") w)))
 
(check-satisfied (arrangements '("r" "a" "t"))
                 all-words-from-rat?)


; 1. What is a trivially solvable problem?
; => (arrangements '())

; 2. How are trivial solutions solved?
; => the empty list has only one re-arrangment '(())

; 3. How does the algorithm generate new problems that are more easily solvable
;    than the original one? Is there one new problem that we generate or are
;    there several?
; => - arrangmenets without the first item
;    - only one new sub-problem (using fold)

; 4. Is the solution of the given problem the same as the solution of (one of)
;    the new problems? Or, do we need to combine the solutions to create a
;    solution for the original problem? And, if so, do we need anything from the
;    original problem data?
; => - we need to combine the solution, by appending the removed element to the results
;    - we needcombine the solution by appending the first element to the rearrangement
;      of the list without the first element




; The results are different. Generative:
; '((a b c) (a c b) (b a c) (b c a) (c a b) (c b a))

; from Word Games:
; '((c b a) (c a b) (a c b) (b c a) (b a c) (a b c))



