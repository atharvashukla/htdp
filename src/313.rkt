;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |313|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
#|
+---------------------------------------------------------------------------+
| Exercise 313                                                              |
| ------------                                                              |
| Suppose we need the function blue-eyed-ancestor?, which is like           |
| blue-eyed-child? but responds with #true only when a proper ancestor, not |
| the given child itself, has blue eyes.                                    |
|                                                                           |
| Although the goals clearly differ, the signatures are the same:           |
| ; FT -> Boolean                                                           |
| (define (blue-eyed-ancestor? an-ftree) ...)                               |
| Stop! Formulate a purpose statement for the function.                     |
| To appreciate the difference, we take a look at Eva:                      |
| (check-expect (blue-eyed-child? Eva) #true)                               |
|                                                                           |
| Eva is blue-eyed, but has no blue-eyed ancestor. Hence,                   |
| (check-expect (blue-eyed-ancestor? Eva) #false)                           |
|                                                                           |
| In contrast, Gustav is Eva’s son and does have a blue-eyed ancestor:      |
| (check-expect (blue-eyed-ancestor? Gustav) #true)                         |
|                                                                           |
| Now suppose a friend comes up with this solution:                         |
| (define (blue-eyed-ancestor? an-ftree)                                    |
|   (cond                                                                   |
|     [(no-parent? an-ftree) #false]                                        |
|     [else                                                                 |
|      (or                                                                  |
|        (blue-eyed-ancestor?                                               |
|          (child-father an-ftree))                                         |
|        (blue-eyed-ancestor?                                               |
|          (child-mother an-ftree)))]))                                     |
|                                                                           |
| Explain why this function fails one of its tests. What is the result of   |
| (blue-eyed-ancestor? A) no matter which A you choose? Can you fix your    |
| friend’s solution?                                                        |
+---------------------------------------------------------------------------+
|#

(define-struct no-parent [])
(define-struct child [father mother name date eyes])
; An FT (short for family tree) is one of: 
; – (make-no-parent)
; – (make-child FT FT String N String)

(define NP (make-no-parent))
; An FT is one of: 
; – NP
; – (make-child FT FT String N String)

; Oldest Generation:
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
 
; Middle Generation:
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
 
; Youngest Generation: 
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))




;; FT -> Boolean
;; does any ancestor have a blue eye

; (check-expect (blue-eyed-child? Eva) #true)
(check-expect (blue-eyed-ancestor? Eva) #false)
(check-expect (blue-eyed-ancestor? Gustav) #true)
(check-expect (blue-eyed-ancestor? Carl) #false)
(check-expect (blue-eyed-ancestor? NP) #false)


(define (blue-eyed-ancestor? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else
     (or
       (blue-eyed-child? (child-father an-ftree))
       (blue-eyed-child? (child-mother an-ftree)))]))


; FT -> Boolean
; does an-ftree contain a child
; structure with "blue" in the eyes field
 
(check-expect (blue-eyed-child? Carl) #false)
(check-expect (blue-eyed-child? Gustav) #true)
 
(define (blue-eyed-child? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else (or (string=? (child-eyes an-ftree) "blue")
              (blue-eyed-child? (child-father an-ftree))
              (blue-eyed-child? (child-mother an-ftree)))]))

