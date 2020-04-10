;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 180ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 180
;; ------------
;; Design editor-text without using implode.
;; -----------------------------------------------------------------------------


(require 2htdp/image)

(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 


; Lo1s -> Image
; renders a list of 1Strings as a text image

(check-expect
  (editor-text
   (cons "p" (cons "o" (cons "s" (cons "t" '())))))
  (text "post" FONT-SIZE FONT-COLOR))

(define (editor-text s)
  (text (collapse s) FONT-SIZE FONT-COLOR))



; LO1S -> String
; my version of implode

(check-expect (collapse '()) "")
(check-expect (collapse (cons "a" (cons "b" '()))) "ab")

(define (collapse lo1s)
  (cond
    [(empty? lo1s) ""]
    [else (string-append (first lo1s) (collapse (rest lo1s)))]))

