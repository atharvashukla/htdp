;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 189ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 189
;; ------------
;; Here is the function search:
;; 
;;    ; Number List-of-numbers -> Boolean
;;    (define (search n alon)
;;      (cond
;;        [(empty? alon) #false]
;;        [else (or (= (first alon) n)
;;                  (search n (rest alon)))]))
;; 
;; It determines whether some number occurs in a list of numbers. The function
;; may have to traverse the entire list to find out that the number of interest
;; isn’t contained in the list.
;; 
;; Develop the function search-sorted, which determines whether a number occurs
;; in a sorted list of numbers. The function must take advantage of the fact
;; that the list is sorted. 
;; -----------------------------------------------------------------------------

; Number List-of-numbers -> Boolean
(define (search n alon)
  (cond
    [(empty? alon) #false]
    [else (or (= (first alon) n)
              (search n (rest alon)))]))


(check-expect (search 3 '(1 2 3)) #true)
(check-expect (search 2 '(1 2 3)) #true)
(check-expect (search 3 '(2 3 1)) #true)
(check-expect (search 1 '(2 3 2)) #false)
(check-expect (search 0 '(3 2 1)) #false)

; Number List-of-numbers -> Boolean
; searches a number is a sorted list (ascending order)
(define (search-sorted n alon)
  (cond
    [(empty? alon) #false]
    [else (if (< n (first alon))
              #false
              (or (= n (first alon))
                  (search n (rest alon))))]))


(check-expect (search-sorted 0 '()) #false)
(check-expect (search-sorted 3 '(1 2 3)) #true)
(check-expect (search-sorted 2 '(1 2 3)) #true)
(check-expect (search-sorted 3 '(2 3 1)) #true)
(check-expect (search-sorted 1 '(2 3 2)) #false)
(check-expect (search-sorted 0 '(3 2 1)) #false)