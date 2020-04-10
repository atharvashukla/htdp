;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 86ex_test) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Exercise 86.
;; ------------
;; Notice that if you type a lot, your editor program does not display all of
;; the text. Instead the text is cut off at the right margin. Modify your
;; function edit from exercise 84 so that it ignores a keystroke if adding it to
;; the end of the pre field would mean the rendered text is too wide for your
;; canvas.
;; -----------------------------------------------------------------------------

;; Renamed the edit from before to `edit-old` and the new edit is `edit`
;; it first checks if the text exceeds, if it does, the editor remains the same
;; otherwise, control is dispatched to the old edit.


(require 2htdp/image)
(require 2htdp/universe)


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

; Editor -> Editor
; launches the graphical text editor with an initial statte
(define (run ws)
  (big-bang ws
    [to-draw   render]
    [on-key    edit]))

(define INIT-EDITOR (make-editor "" ""))

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
                 (text+cursor-gen (editor-pre e) (editor-post e))
                 SCN))


(define (text+cursor-gen strl strr)
  (beside (textify strl) CURSOR (textify strr)))

; String -> Image
; text with configured properties

(check-expect (textify "") (text "" TEXT-SIZE TEXT-COLOR))
(check-expect (textify "abc") (text "abc" TEXT-SIZE TEXT-COLOR))

(define (textify str)
  (text str TEXT-SIZE TEXT-COLOR))

(define LONGWORD "1234567890987654321234567890987654321")
(define LONG-EDITOR (make-editor LONGWORD LONGWORD))

(check-expect (edit LONG-EDITOR "d") LONG-EDITOR)
(check-expect (edit (make-editor "ab" "c") "d")
              (make-editor "abd" "c"))

; Editor KeyEvent -> Editor
; modifies the editor in response to the keystroke
(define (edit e ke)
  (if (exceeds-limit? e)
   e
   (edit-old e ke)))

;; wish list: exceeds-limit?

; Editor -> Boolean
; does the rendering exceed the scene width?

(check-expect (exceeds-limit? LONG-EDITOR) #t)
(define (exceeds-limit? e)
  (>= (image-width (text+cursor-gen (editor-pre e) (editor-post e))) SCN-WIDTH))

; Editor KeyEvent -> Editor
; Responds to keypress:
; - Adds the `ke` at the end of `pre` field of `ed`
; - Deletes it if "\b" is pressed.
; - Ignores "\t" and "\r"
; - Moves left on "left" and right on "right"
#;
(define (edit-old ed ke)
  ed)

; - "|" "a" -> "a|"
; - "|" "left" -> "|"
; - "|" "right" -> "|"
; - "|" "\b" -> "|"
; - "|" "\t" -> "|"
; - "|" "\r" -> "|"
; - "abc|" "\b" -> "ab|"
; - "ab|c" "\b" -> "a|c"
; - "|abc" "\b" -> "|abc"
; - "ab|" "c" -> "abc|"
; - "|bc" "a" -> "a|bc"
; - "a|c" "b" -> "ab|c"
; - "abc|" "left" -> "ab|c"
; - "abc|" "right" -> "abc|"
; - "|abc" "left" -> "|abc"
; - "|abc" "right" -> "a|bc"
; - "ab|c" "\t" -> "ab|c"
; - "ab|c" "\r" -> "ab|c" 
#;
(define (edit ed ke)
  (cond
    [(key=? "\b" ke) ...]
    [(key=? "left" ke) ...]
    [(key=? "right" ke) ...]
    [(or (key=? "\t" ke) (key=? "\r" ke)) ...]
    [else ...]))

(define (edit-old ed ke)
  (cond
    [(key=? "\b" ke) (delete ed)]
    [(key=? "left" ke) (move-left ed)]
    [(key=? "right" ke) (move-right ed)]
    [(or (key=? "\t" ke) (key=? "\r" ke)) ed]
    [else (insert ed ke)]))

;; Wish list: delete, move-left, move-right, insert

; Editor -> Editor
; deletes a letter to the left of the cursor
#;
(define (delete ed)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (delete ed)
  (delete-str (editor-pre ed) (editor-post ed)))

; Editor -> Editor
; moves the cursor to its left
#;
(define (move-left ed)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (move-left ed)
  (move-left-str (editor-pre ed)
                 (editor-post ed)))

; Editor -> Editor
; moves the cursor to its right
#;
(define (move-right ed)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (move-right ed)
  (move-right-str (editor-pre ed) (editor-post ed)))


; Editor KeyEvent-> Editor
; inserts ke at the cursor position
#;
(define (insert ed ke)
  (... (editor-pre ed) ... (editpr-post ed) ...))

(define (insert ed ke)
  (insert-str (editor-pre ed) (editor-post ed) ke))


; String String -> Editor
(define (delete-str strl strr)
  (cond
    [(empty-string? strl) (make-editor strl strr)]
    [else (make-editor (string-remove-last strl) strr)]))

; String String -> Editor
(define (move-left-str strl strr)
  (if (empty-string? strl)
      (make-editor strl strr)
      (make-editor (string-remove-last strl) (string-append (string-last strl) strr))))

; String String -> Editor
(define (move-right-str strl strr)
  (if (empty-string? strr)
      (make-editor strl strr)
      (make-editor (string-append strl (string-first strr)) (string-rest strr))))

; String String -> Editor
(define (insert-str strl strr e)
  (make-editor (string-append strl e) strr))



(check-expect (edit-old (make-editor "" "") "a") (make-editor "a" ""))
(check-expect (edit-old (make-editor "" "") "left") (make-editor "" ""))
(check-expect (edit-old (make-editor "" "") "right") (make-editor "" ""))
(check-expect (edit-old (make-editor "" "") "\b") (make-editor "" ""))
(check-expect (edit-old (make-editor "" "") "\t") (make-editor "" ""))
(check-expect (edit-old (make-editor "" "") "\r") (make-editor "" ""))
(check-expect (edit-old (make-editor "abc" "") "\b") (make-editor "ab" ""))
(check-expect (edit-old (make-editor "ab" "c") "\b") (make-editor "a" "c"))
(check-expect (edit-old (make-editor "" "abc") "\b") (make-editor "" "abc"))
(check-expect (edit-old (make-editor "ab" "") "c") (make-editor "abc" ""))
(check-expect (edit-old (make-editor "" "bc") "a") (make-editor "a" "bc"))
(check-expect (edit-old (make-editor "a" "c") "b") (make-editor "ab" "c"))
(check-expect (edit-old (make-editor "abc" "") "left") (make-editor "ab" "c"))
(check-expect (edit-old (make-editor "abc" "") "right") (make-editor "abc" ""))
(check-expect (edit-old (make-editor "" "abc") "left") (make-editor "" "abc"))
(check-expect (edit-old (make-editor "" "abc") "right") (make-editor "a" "bc"))
(check-expect (edit-old (make-editor "ab" "c") "\t") (make-editor "ab" "c"))
(check-expect (edit-old (make-editor "ab" "c") "\r") (make-editor "ab" "c"))

;; String helpers

; NEString -> String
; gets the first character of a ne-str

(check-expect (string-first "abc") "a")

(define (string-first ne-str)
  (substring ne-str 0 1))

; NEString -> String
; gets the rest of the ne-str

(check-expect (string-rest "abc") "bc")

(define (string-rest ne-str)
  (substring ne-str 1))


; NEString -> String
; gets the last character of ne-str

(check-expect (string-last "abc") "c")

(define (string-last ne-str)
  (substring ne-str (sub1 (string-length ne-str))))

; NEString -> String
; removes the last character of ne-str

(check-expect (string-remove-last "abc") "ab")

(define (string-remove-last ne-str)
  (substring ne-str 0 (sub1 (string-length ne-str))))

; String -> Boolean
; is the string "" ?

(check-expect (empty-string? "abc") #false)
(check-expect (empty-string? "") #true)

(define (empty-string? str)
  (string=? "" str))

#;
(run INIT-EDITOR)