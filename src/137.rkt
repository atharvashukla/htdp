;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 137ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 137.
;; -------------
;; Compare the template for contains-flatt? with the one for how-many. Ignoring
;; the function name, they are the same. Explain the similarity.
;; -----------------------------------------------------------------------------

; List-of-names -> Boolean
; does "Flatt" occir in alos
(define (contains-flatt? alos)
  (cond
    [(empty? alos) ...]
    [(cons? alos)
     (... (first alos) ...
          ... (contains-flatt? (rest alos)) ...)]))


; List-of-strings -> Number
; determines how many strings are on alos
(define (how-many alos)
  (cond
    [(empty? alos) ...]
    [else
     (... (first alos) ...
          ... (how-many (rest alos)) ...)]))


;; Similarity, Both follow the basic structure for fun-for-los,
;; any general self referential data definition that
;; has to deal with lists will follow this basic structure

(define (fun-for-los alos)
  (cond
    [(empty? alos) ...]
    [else
     (... (first alos) ...
          ... (fun-for-los (rest alos)) ...)]))