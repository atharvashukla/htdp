;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 476ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 476
;; ------------
;; Finite State Machines poses a problem concerning finite state machines and
;; strings but immediately defers to this chapter because the solution calls for
;; generative recursion. You have now acquired the design knowledge needed to
;; tackle the problem.
;; 
;; Design the function fsm-match. It consumes the data representation of a
;; finite state machine and a string. It produces #true if the sequence of
;; characters in the string causes the finite state machine to transition from
;; an initial state to a final state.
;;
;; Since this problem is about the design of generative recursive functions, we
;; provide the essential data definition and a data example:
;;
;;    (define-struct transition [current key next])
;;    (define-struct fsm [initial transitions final])
;;     
;;    ; An FSM is a structure:
;;    ;   (make-fsm FSM-State [List-of 1Transition] FSM-State)
;;    ; A 1Transition is a structure:
;;    ;   (make-transition FSM-State 1String FSM-State)
;;    ; An FSM-State is String.
;;     
;;    ; data example: see exercise 109
;;     
;;    (define fsm-a-bc*-d
;;      (make-fsm
;;       "AA"
;;       (list (make-transition "AA" "a" "BC")
;;             (make-transition "BC" "b" "BC")
;;             (make-transition "BC" "c" "BC")
;;             (make-transition "BC" "d" "DD"))
;;       "DD"))
;;
;; The data example corresponds to the regular expression a (b|c)* d. As
;; mentioned in exercise 109, "acbd", "ad", and "abcd" are examples of
;; acceptable strings; "da", "aa", or "d" do not match.
;;
;; In this context, you are designing the following function:
;;
;;    ; FSM String -> Boolean 
;;    ; does an-fsm recognize the given string
;;    (define (fsm-match? an-fsm a-string)
;;      #false)
;;
;; *Hint* Design the necessary auxiliary function locally to the fsm-match?
;; function. In this context, represent the problem as a pair of parameters: the
;; current state of the finite state machine and the remaining list of 1Strings.
;; -----------------------------------------------------------------------------


(define-struct transition [current key next])
(define-struct fsm [initial transitions final])
 
; An FSM is a structure:
;   (make-fsm FSM-State [List-of 1Transition] FSM-State)
; A 1Transition is a structure:
;   (make-transition FSM-State 1String FSM-State)
; An FSM-State is String.
 
; data example: see exercise 109
 
(define fsm-a-bc*-d
  (make-fsm
   "AA"
   (list (make-transition "AA" "a" "BC")
         (make-transition "BC" "b" "BC")
         (make-transition "BC" "c" "BC")
         (make-transition "BC" "d" "DD"))
   "DD"))


; FSM String -> Boolean 
; does an-fsm recognize the given string

(check-expect (fsm-match? fsm-a-bc*-d "acbd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "ad") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abcd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "da") #false)
(check-expect (fsm-match? fsm-a-bc*-d "aa") #false)
(check-expect (fsm-match? fsm-a-bc*-d "d") #false)

(define (fsm-match? an-fsm a-string)
  (local ((define transitions (fsm-transitions an-fsm))
          ; String String -> Boolean
          ; simulates fsm by keeping track of fsm-state
          ; and the string simulated so far
          (define (fsm-match?-h current s)
            (cond
              [(string=? s "") (equal? current (fsm-final an-fsm))]
              [else (fsm-match?-h (transit current (substring s 0 1))
                                  (substring s 1))]))
          ; FSM-State String -> FSM-State
          ; transition to the next FSM-State according to s
          (define (transit current str)
            (local ((define candidate-l
                      (filter (λ (tr) (equal? str (transition-key tr)))
                              (filter (λ (t) (equal? current (transition-current t)))
                                      transitions))))
            (if (empty? candidate-l)
                current
                (transition-next (first candidate-l))))))
  (fsm-match?-h (fsm-initial an-fsm) a-string)))