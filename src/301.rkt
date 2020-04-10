;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 301ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 301
;; ------------
;;  Draw a box around the scope of each binding occurrence of sort and alon in
;; figure 105. Then draw arrows from each occurrence of sort to the appropriate
;; binding occurrence. Now repeat the exercise for the variant in figure 106.
;; Do the two functions differ other than in name? 
;; -----------------------------------------------------------------------------

; changing all "sort" names to "my-sort"

(define (insertion-sort alon)
  (local ((define (my-sort alon)
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (my-sort (rest alon)))]))
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon)
                             (add an (rest alon)))])])))
    (my-sort alon)))

; Figure 105: Drawing lexical scope contours for exercise 301

(define (my-sort alon)
  (local ((define (my-sort alon)
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (my-sort (rest alon)))]))
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
                (cond
                  [(> an (first alon)) (cons an alon)]
                  [else (cons (first alon)
                              (add an (rest alon)))])])))
    (my-sort alon)))

; Figure 106: Drawing lexical scope contours for exercise 301 (version 2)


; for figure 105
; --------------
; - my-sort would be the whole local expression
; - box for alon which occurs as the param of my-sort
;   would be the body of my-sort
; - box for alon which occurs as the param of add
;   would be the body of add

; for figure 106
; --------------
; - box for the my-sort, the outer function, would be
;   its body except the local expression
; - box for the my-dort definition within the local
;   would be the whole local expression
; - box for alon which occurs as the param of my-sort
;   would be the body of my-sort
; - box for alon which occurs as the param of add
;   would be the body of add

; - the two functions differ only in their names