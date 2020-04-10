;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 206ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 206
;; ------------
;; Design the function find-association. It consumes three arguments: a String
;; called key, an LAssoc, and an element of Any called default. It produces the
;; first Association whose first item is equal to key, or default if there is
;; no such Association.
;;
;; *Note* Read up on assoc after you have designed this function. 
;; -----------------------------------------------------------------------------

(require "provide.rkt")
(provide find-association)

; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)
; 
; An Association is a list of two items: 
;   (cons String (cons BSDN '()))


(define lassoc1
  (list
   (list "Name" "Call It Stormy Monday (Live)")
   (list "Artist" "Albert King 38 Stevie Ray Vaughan")
   (list "Album Artist" "Albert King 38 Stevie Ray Vaughan")
   (list "Album" "In Session (Live)")
   (list "Total Time" 540167)))

(define lassoc2
  (list
   (list "Name" "Brianstorm")
   (list "Artist" "Arctic Monkeys")
   (list "Album Artist" "Arctic Monkeys")
   (list "Album" "Favourite Worst Nightmare")
   (list "Total Time" 172253)))

; ----------

; String LAssoc Any -> (U Any Association)
; the association whose first item is key or default if
; no such association exists
#;
(define (find-association key lassoc default)
  default)

; template driven by lassoc
#; 
(define (find-association key lassoc default)
  (cond
    [(empty? lassoc)  ...]
    [else (... (first lassoc) ... (find-association key (rest lassoc) default) ...)]))

(check-expect (find-association "Total Time" lassoc2 #false) (list "Total Time" 172253))
(check-expect (find-association "Total Time" '() #false) #false)
(check-expect (find-association "Not there" '() "yes") "yes")

(define (find-association key lassoc default)
  (cond
    [(empty? lassoc)  default]
    [else (if  (equal? (first (first lassoc)) key)
               (first lassoc)
               (find-association key (rest lassoc) default))]))
