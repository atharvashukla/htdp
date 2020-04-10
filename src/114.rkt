;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |114|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 114.
;; -------------
;; Use the predicates from exercise 113 to check the space invader world
;; program, the virtual pet program (exercise 106), and the editor program
;; (A Graphical Editor). 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(require "provide.rkt")

(require "087.rkt")
(require "100.rkt")
(require "106.rkt")
(require "113.rkt")

; virtual-pets
(define (virtual-pets ws)
  (big-bang ws
    [check-with vanimal?]
    [on-tick   animal-tock]
    [stop-when animal-zero-happiness?]
    [to-draw   animal-render]
    [on-key    animal-keystroke-handler]))

; space-invaders
(define (space-invaders sigs)
  (big-bang sigs
    [check-with sigs??]
    [on-tick   si-move]
    [stop-when si-game-over?]
    [to-draw   si-render]
    [on-key    si-control]))

; Any -> Boolean
; recognizer for an Editor

(check-expect (editor?? (make-editor 1 "abc")) #t)
(check-expect (editor?? (make-editor "abc" 1)) #f)

(define (editor?? e)
  (and (editor? e)
       (and (number? (editor-idx e))
            (string? (editor-text e)))))

; editor
(define (editor-prog ws)
  (big-bang ws
    [check-with editor??]
    [to-draw   render]
    [on-key    edit]))