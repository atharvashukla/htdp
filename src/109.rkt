;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 109ex_add-tests) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 109.
;; -------------
;; Design a world program that recognizes a pattern in a sequence of KeyEvents.
;; Initially the program shows a 100 by 100 white rectangle. Once your program
;; has encountered the first desired letter, it displays a yellow rectangle of
;; the same size. After encountering the final letter, the color of the
;; rectangle turns green. If any “bad” key event occurs, the program displays a
;; red rectangle.
;;
;; * conventional
;; 
;;    ; ExpectsToSee.v1 is one of: 
;;    ; – "start, expect an 'a'"
;;    ; – "expect 'b', 'c', or 'd'"
;;    ; – "finished" 
;;    ; – "error, illegal key"
;;
;; * defined abbreviations
;; 
;;    ; ExpectsToSee.v2 is one of:
;;    ; – AA
;;    ; – BB
;;    ; – DD 
;;    ; – ER
;;
;;    (define AA "start, ...")
;;    (define BB "expect ...")
;;    (define DD "finished")
;;    (define ER "error, ...")
;;
;; Figure 36: Two ways of writing a data definition for FSMs
;; 
;; The specific sequences that your program looks for start with "a", followed
;; by an arbitrarily long mix of "b" and "c", and ended by a "d". Clearly,
;; "acbd" is one example of an acceptable string; two others are "ad" and
;; "abcbbbcd". Of course, "da", "aa", or "d" do not match.
;;
;; <fsm-diagram.png>
;;
;; Figure 37: A finite state machine as a diagram
;;
;; 
;; *Hint* Your solution implements a finite state machine (FSM), an idea
;; introduced in Finite State Worlds as one design principle behind world
;; programs. As the name says, an FSM program may be in one of a finite number
;; of states. The first state is called an initial state. Each key event causes
;; the machine to reconsider its current state; it may transition to the same
;; state or to another one. When your program recognizes a proper sequence of
;; key events, it transitions to a final state.
;;
;; For a sequence-recognition problem, states typically represent the letters
;; that the machine expects to see next; see figure 36 for a data definition.
;; Take a look at the last state, which says an illegal input has been
;; encountered. Figure 37 shows how to think of these states and their
;; relationships in a diagrammatic manner. Each node corresponds to one of the
;; four finite states; each arrow specifies which KeyEvent causes the program to
;; transition from one state to another
;;
;; *History* In the 1950s, Stephen C. Kleene, whom we would call a computer
;; scientist, invented regular expressions as a notation for the problem of
;; recognizing text patterns. For the above problem, Kleene would write
;;
;;                              a (b|c)* d
;;
;; which means a followed by b or c arbitrarily often until d is encountered. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

;*
	
; ExpectsToSee.v2 is one of:
; – AA
; – BB
; – DD 
; – ER 
 
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

(define initial-img (rectangle 100 100 "solid" "white"))
(define final-img (rectangle 100 100 "solid" "green"))
(define good-key-img (rectangle 100 100 "solid" "yellow"))
(define bad-key-img (rectangle 100 100 "solid" "red"))

;; WS KeyEvent -> WS
;; alters the ws acc to ke
(define (key-handler ws ke)
  (cond
    [(equal? ws AA) (AA-handler ws ke)]
    [(equal? ws BB) (BB-handler ws ke)]
    [(equal? ws DD) ws]
    [(equal? ws ER) ws]))

(define (AA-handler ws ke)
  (cond
    [(equal? ke "a") BB]
    [else ER]))

(define (BB-handler ws ke)
  (cond
    [(or (equal? ke "b") (equal? ke "c")) BB]
    [(equal? ke "d") DD]
    [else ER]))


;; WS -> Image
;; renders the image of ws
(define (render ws)
  (cond
    [(equal? ws AA) initial-img]
    [(equal? ws BB) good-key-img]
    [(equal? ws DD) final-img]
    [(equal? ws ER) bad-key-img]))

;; WS -> WS
;; launches the program with the is
(define (main is)
  (big-bang is
    [on-key key-handler]
    [to-draw render]))

#;
(main AA)

