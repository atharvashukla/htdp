;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 478ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 478
;; ------------
;; You can also place the first queen in all squares of the top-most row, the
;; right-most column, and the bottom-most row. Explain why all of thes
;; solutions are just like the three scenarios depicted in figure 173.
;;
;; This leaves the central square. Is it possible to place even a second queen
;; after you place one on the central square of a 3 by 3 board?
;; -----------------------------------------------------------------------------


; We can place the first queen in all those squares because
; the second queen can be placed in a night's jump's space from the 1st


; It isn't possible to place the second queen after the first
; is placed in the central square, it threatens the entire board