;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 399ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 399
;; ------------
;; Louise, Jane, Laura, Dana, and Mary decide to run a lottery that assigns one
;; gift recipient to each of them. Since Jane is a developer, they ask her to
;; write a program that performs this task in an impartial manner. Of course,
;; the program must not assign any of the sisters to herself.
;;
;; Here is the core of Jane’s program:
;;
;;    ; [List-of String] -> [List-of String] 
;;    ; picks a random non-identity arrangement of names
;;    (define (gift-pick names)
;;      (random-pick
;;        (non-same names (arrangements names))))
;;     
;;    ; [List-of String] -> [List-of [List-of String]]
;;    ; returns all possible permutations of names
;;    ; see exercise 213
;;    (define (arrangements names)
;;      ...)
;;
;; It consumes a list of names and randomly picks one of those permutations that
;; do not agree with the original list at any place.
;;
;; Your task is to design two auxiliary functions:
;;
;;    ; [NEList-of X] -> X 
;;    ; returns a random item from the list 
;;    (define (random-pick l)
;;      (first l))
;;     
;;    ; [List-of String] [List-of [List-of String]] 
;;    ; -> 
;;    ; [List-of [List-of String]]
;;    ; produces the list of those lists in ll that do 
;;    ; not agree with names at any place 
;;    (define (non-same names ll)
;;      ll)
;;
;; Recall that random picks a random number; see exercise 99. 
;; -----------------------------------------------------------------------------


; [List-of String] -> [List-of String] 
; picks a random non-identity arrangement of names
(define (gift-pick names)
  (random-pick
   (non-same names (arrangements names))))

; [NEList-of X] -> X 
; returns a random item from the list
(define (random-pick l)
  (list-ref l (random (length l))))
 
; [List-of String] [List-of [List-of String]] 
; -> 
; [List-of [List-of String]]
; produces the list of those lists in ll that do 
; not agree with names at any place

(check-member-of (non-same '("a" "b" "c") (arrangements '("a" "b" "c")))
                 '(("c" "a" "b") ("b" "c" "a"))
                 '(("b" "c" "a") ("c" "a" "b")))

(check-satisfied (non-same '("a" "b" "c" "d") (arrangements '("a" "b" "c" "d")))
                 (list
                  (list "d" "c" "b" "a")
                  (list "d" "c" "a" "b")
                  (list "d" "a" "b" "c")
                  (list "b" "d" "a" "c")
                  (list "b" "a" "d" "c")
                  (list "c" "d" "b" "a")
                  (list "c" "d" "a" "b")
                  (list "c" "a" "d" "b")
                  (list "b" "c" "d" "a")))

(define (non-same names ll)
  (local (; [List-of String] [List-of String] -> Boolean
          ; do the two lists have the same element at any position?
          ; ASSUMPTION: both are of the same length
          (define (agrees? l1 l2)
            (ormap (λ (l1-e l2-e) (equal? l1-e l2-e)) l1 l2)))
    (filter (λ (l) (not (agrees? l names))) ll)))



;; -----------------------------------------------------------------------------

; Word -> List-of-words
; creates all rearrangements names w
(define (arrangements w)
  (local (; String -> List-of-strings
          ; finds all words that the letters of some given word spell
          (define (insert-everywhere/in-all-words s l)
            (cond
              [(empty? l) '()]
              [else (append (insert-everywhere s (first l)) ; : Word -> List-of-words
                            (insert-everywhere/in-all-words s (rest l))  ; : List-of-words
                            )]))

          ; 1String Word -> List-of-words
          ; inserts s at all positions in w and makes a list of them
          (define (insert-everywhere s w)
            (insert-everywhere-aux s w (length w)))


          ; 1String Word  Nat -> List-of-words
          ; inserts s at all positions in w at positions 0 to n
          (define (insert-everywhere-aux s w n)
            (cond
              [(= 0 n) (list (insert-s-at-ith s w 0))]
              [else (cons (insert-s-at-ith s w n)
                          (insert-everywhere-aux s w (sub1 n)))]))


          ; 1String Word Nat -> Word
          ; inserts s at ith position in w (i <= (length w))
          (define (insert-s-at-ith s w i)
            (cond
              [(= i 0) (cons s w)]
              [else (cons (first w) (insert-s-at-ith s (rest w) (sub1 i)))])))
    (cond
      [(empty? w) (list '())]
      [else (insert-everywhere/in-all-words (first w)
                                            (arrangements (rest w)))])))


;; -----------------------------------------------------------------------------

; [List-of X] -> [[List-of X] -> Boolean]
; a function that checks if l is a rearrangement of k
(define (variant? k)
  (local (; [List-of X] [List-of X] -> Boolean 
          ; are all items in list k members of list l
          (define (contains? l k)
            (andmap (lambda (in-k) (member? in-k l)) k)))
    (lambda (l)
      (and (contains? l k)
           (contains? k l)
           (= (length k) (length l))))))