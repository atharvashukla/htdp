;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 133ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 133.
;; -------------
;; Here is another way of formulating the second cond clause in contains-flatt?:
;; 
;;    ... (cond
;;          [(string=? (first alon) "Flatt") #true]
;;          [else (contains-flatt? (rest alon))]) ...
;;
;; Explain why this expression produces the same answers as the or expression in
;; the version of figure 47. Which version is clearer to you? Explain.
;; -----------------------------------------------------------------------------


; The expression produces the same answer as the `or` version because
; (or e1 e2) == (cond [e1 #true] [else e2])
; I think the first version is better because it follows the "one cond clause
; per clause of the data definition" slogan.
; The clauses can easily be matched ("case analysis") when reading the code too.



