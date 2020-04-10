;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 87ex-graphical-editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 87.
;; ------------
;; Develop a data representation for an editor based on our first idea, using a
;; string and an index. Then solve the preceding exercises again. Retrace the
;; design recipe. Hint if you haven’t done so, solve the exercises in Functions.

;; Note on Design Choices The exercise is a first study of making design
;; choices. It shows that the very first design choice concerns the data
;; representation. Making the right choice requires planning ahead and weighing
;; the complexity of each. Of course, getting good at this is a question of
;; gaining experience.
;; -----------------------------------------------------------------------------


(require 2htdp/image)
(require 2htdp/universe)

(require "provide.rkt")
(provide render edit editor? editor-idx editor-text make-editor)

(define-struct editor [idx text])

; "|"   -> 0, ""
; "a|"  -> 1, "a"
; "|a"  -> 0, "a"
; "a|b" -> 1 "ab"

; An Editor is a strucutre
;   (make-editor Number String)
; *interpretation*
; the cursor is at `idx`th position
; the `text` is the content

(define editor-ex-1 (make-editor 0 ""))
(define editor-ex-2 (make-editor 1 "a"))
(define editor-ex-3 (make-editor 0 "a"))
(define editor-ex-4 (make-editor 1 "ab"))

(define INIT-EDITOR (make-editor 0 ""))

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

; Editor -> Editor
; starts the editor with an initial state
(define (run w)
  (big-bang w
    [to-draw render]
    [on-key edit]))

; Editor -> Image
; displays the graphical text editor

(check-expect (render editor-ex-4)
              (overlay/align "left" "center"
                 (text+cursor-gen "a" "b")
                 SCN))

(define (render e)
  (overlay/align "left" "center"
                 (text+cursor-gen (get-editor-pre e) (get-editor-post e))
                 SCN))


(define (text+cursor-gen strl strr)
  (beside (textify strl) CURSOR (textify  strr)))

(define (textify str)
  (text str TEXT-SIZE TEXT-COLOR))

; Wish list:
(define (get-editor-post e)
  (substring (editor-text e) (editor-idx e)))

(define (get-editor-pre e)
  (substring (editor-text e) 0 (editor-idx e)))

(define LONGWORD "1234567890987654321234567890987654321")
(define LONG-EDITOR (make-editor 10 (string-append LONGWORD LONGWORD)))

(check-expect (edit LONG-EDITOR "d") LONG-EDITOR)
(check-expect (edit (make-editor 1 "ab") "d")
              (make-editor 2 "adb"))

; Editor KeyEvent -> Editor
; responds to the key event
(define (edit e ke)
  (if (exceeds-limit? e)
      e
      (edit-old e ke)))



(define (exceeds-limit? e)
  (>= (image-width (text+cursor-gen (get-editor-pre e) (get-editor-post e))) SCN-WIDTH))

(check-expect (edit-old editor-ex-2 "\b") editor-ex-1)
(check-expect (edit-old editor-ex-1 "\b") editor-ex-1)
(check-expect (edit-old editor-ex-1 "left") editor-ex-1)
(check-expect (edit-old editor-ex-2 "left") editor-ex-3)
(check-expect (edit-old editor-ex-3 "right") editor-ex-2)
(check-expect (edit-old editor-ex-1 "right") editor-ex-1)
(check-expect (edit-old editor-ex-4 "\t") editor-ex-4)
(check-expect (edit-old editor-ex-4 "\r") editor-ex-4)

(define (edit-old ed ke)
  (cond
    [(key=? "\b" ke) (delete ed)]
    [(key=? "left" ke) (move-left ed)]
    [(key=? "right" ke) (move-right ed)]
    [(or (key=? "\t" ke) (key=? "\r" ke)) ed]
    [else (insert ed ke)]))


; "|"   -> 0, ""
; "a|"  -> 1, "a"
; "|a"  -> 0, "a"
; "a|b" -> 1 "ab"

(check-expect (delete editor-ex-2) editor-ex-1)
(check-expect (delete editor-ex-1) editor-ex-1)

(define (delete ed)
  (cond
    [(= (editor-idx ed) 0) ed]
    [else (make-editor (sub1 (editor-idx ed))
                       (string-append (string-remove-last (get-editor-pre ed))
                                      (get-editor-post ed)))]))

(check-expect (move-left editor-ex-1) editor-ex-1)
(check-expect (move-left editor-ex-2) editor-ex-3)

(define (move-left ed)
  (cond
    [(= (editor-idx ed) 0) ed]
    [else (make-editor (sub1 (editor-idx ed)) (editor-text ed))]))

(check-expect (move-right editor-ex-3) editor-ex-2)
(check-expect (move-right editor-ex-1) editor-ex-1)

(define (move-right ed)
  (cond
    [(= (editor-idx ed) (string-length (editor-text ed))) ed]
    [else (make-editor (add1 (editor-idx ed)) (editor-text ed))]))


(check-expect (insert editor-ex-1 "a") editor-ex-2)

(define (insert ed ke)
  (make-editor (add1 (editor-idx ed))
               (string-append (get-editor-pre ed)
                              ke
                              (get-editor-post ed))))


(define (string-remove-last ne-str)
  (substring ne-str 0 (sub1 (string-length ne-str))))

#;
(run INIT-EDITOR)