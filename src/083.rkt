;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 83ex) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 83.
;; ------------
;; 
;; Design the function render, which consumes an Editor and produces an image.
;; 
;; The purpose of the function is to render the text within an empty scene of
;; 200 x 20 image pixels. For the cursor, use a 1 x 20 image red rectangle and
;; for the strings, black text of size 16.
;;
;; Develop the image for a sample string in DrRacket’s interactions area. We
;; started with this expression:
;;
;;    (overlay/align "left" "center"
;;                   (text "hello world" 11 "black")
;;                   (empty-scene 200 20))
;;
;; You may wish to read up on beside, above, and such functions. When you are
;; happy with the looks of the image, use the expression as a test and as a
;; guide to the design of render. 
;; -----------------------------------------------------------------------------

(require 2htdp/image)
(require 2htdp/universe)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

;; Scene
(define SCN-WIDTH 200)
(define SCN-HEIGHT 20)
(define SCN (empty-scene SCN-WIDTH SCN-HEIGHT))

;; Cursor
(define CURSOR-HEIGHT 20)
(define CURSOR-WIDTH 1)
(define CURSOR-COLOR "red")

(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT "solid" CURSOR-COLOR))

;; Text
(define TEXT-SIZE 11)
(define TEXT-COLOR "black")

; Editor -> Image
; image of e
#;
(define (render e)
  empty-image)



(check-expect
 (render (make-editor "hello" "world"))
 (overlay/align "left" "center"
               (beside (text "hello" 11 "black")
                       CURSOR
                       (text "world" 11 "black"))
               (empty-scene 200 20)))

(check-expect
 (render (make-editor "" "world"))
 (overlay/align "left" "center"
               (beside (text "" 11 "black")
                       CURSOR
                       (text "world" 11 "black"))
               (empty-scene 200 20)))

(check-expect
 (render (make-editor "hello" ""))
 (overlay/align "left" "center"
               (beside (text "hello" 11 "black")
                       CURSOR
                       (text "" 11 "black"))
               (empty-scene 200 20)))

(check-expect
 (render (make-editor "" ""))
 (overlay/align "left" "center"
               (beside (text "" 11 "black")
                       CURSOR
                       (text "" 11 "black"))
               (empty-scene 200 20)))



(define (render e)
  (overlay/align "left" "center"
                 (beside (textify (editor-pre e))
                         CURSOR
                         (textify (editor-post e)))
                 SCN))

; String -> Image
; text with configured properties

(check-expect (textify "") (text "" TEXT-SIZE TEXT-COLOR))
(check-expect (textify "abc") (text "abc" TEXT-SIZE TEXT-COLOR))

(define (textify str)
  (text str TEXT-SIZE TEXT-COLOR))